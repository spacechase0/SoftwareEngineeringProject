extends KinematicBody2D

const Projectile = preload("res://Projectile.gd")
const Projectile_scene = preload("res://PlayerProjectile.tscn")
signal health_lost(value)
enum DropletState {
	NORMAL,
	VAPOR,
}

export var GRAVITY: float = 25
export var JUMP_FORCE : float = 350
export var SPEED : float = 100
export var PROJECTILE_SPEED : float = 250
export var VAPOR_REFILL_RATE : float = 0.2
export var VAPOR_CONSUME_RATE : float = 0.4
export var VAPOR_MAX : float = 100
export var VAPOR_PROJECTILE_COST : float = 15
var max_health = 3
var vapor : float = 100

var state : int = DropletState.NORMAL
var velocity : Vector2 = Vector2()
var facingRight : bool = true
onready var invulnerability_timer = $Invulnerability
onready var is_invulnerable = false
onready var health = max_health setget _set_health

func get_class():
	return "Player"

func _ready() -> void:
	vapor = VAPOR_MAX
	invulnerability_timer.stop()
	
func _process(delta : float) -> void:
	var canvas = get_tree().get_root().find_node("UiCommon", true, false)
	var vaporBar = canvas.find_node("VaporBar") as ProgressBar
	vaporBar.value = vapor

func _physics_process(delta : float) -> void:
	var forceChangeForm = false
	if state == DropletState.VAPOR:
		vapor -= VAPOR_CONSUME_RATE
		if vapor < 0:
			vapor = 0
			forceChangeForm = true
	else:
		vapor += VAPOR_REFILL_RATE
		if ( vapor > VAPOR_MAX ):
			vapor = VAPOR_MAX
	
	# Change between vapor and not
	if (forceChangeForm or Input.is_action_just_pressed("form_change")):
		if state != DropletState.VAPOR:
			state = DropletState.VAPOR
			($Collision_Normal as CollisionShape2D).disabled = true
			($Collision_Crouch as CollisionShape2D).disabled = true
			($Collision_Vapor as CollisionShape2D).disabled = false
			($DisplayForms/Normal as Node2D).visible = false
			($DisplayForms/Crouch as Node2D).visible = false
			($DisplayForms/Vapor as Node2D).visible = true
		else:
			state = DropletState.NORMAL
			($Collision_Normal as CollisionShape2D).disabled = false
			($Collision_Vapor as CollisionShape2D).disabled = true
			($DisplayForms/Normal as Node2D).visible = true
			($DisplayForms/Vapor as Node2D).visible = false
	
	# Horizontal movement
	var hdir : float = 0.0
	if Input.is_action_pressed("move_left"):
		facingRight = false
		hdir -= 1
		
	if Input.is_action_pressed("move_right"):
		facingRight = true
		hdir += 1
	velocity.x = hdir * SPEED
	$DroppyBody.flip_h = !facingRight
	$DroppyBody/Face.flip_h = !facingRight
	
	#Introduce crouching prior to any movement calls
	var crouching : bool = Input.is_action_pressed("move_down")
	
	# Walking and Crouching animation
	if (velocity.length() > 0) && state == DropletState.NORMAL:
		if (crouching):
			$DroppyBody/Face.play("crouch")
			$DroppyBody.play("crouchmove")
		elif !Input.is_action_pressed("move_right") && !Input.is_action_pressed("move_left"):
			$DroppyBody.play("default")
			$DroppyBody/Face.play("default")
		else: 
			$DroppyBody/Face.play("default")
			$DroppyBody.play("walk")
			
	elif (state == DropletState.VAPOR):
		$DroppyBody.play("vapor")
		$DroppyBody/Face.play("default")
		
	else:
		$DroppyBody.play("default")
	
	# State-specific
	
	if state == DropletState.NORMAL:
		# Animation/visuals to be displayed for this form
		if velocity.length() <= 0: 
			$DroppyBody.play("default") 
			$DroppyBody/Face.play("default") 
			if (crouching):
				$DroppyBody.play("crouch")
				$DroppyBody/Face.play("crouch")
		# Gravity, jumping
		velocity.y += GRAVITY
		if is_on_floor() and Input.is_action_just_pressed("move_up"):
			$Jump.play()
			velocity.y = -JUMP_FORCE
			
		($Collision_Normal as CollisionShape2D).disabled = crouching
		($Collision_Crouch as CollisionShape2D).disabled = !crouching
		($DisplayForms/Normal as Node2D).visible = !crouching
		($DisplayForms/Crouch as Node2D).visible = crouching
		
		# Shooting
		if !crouching and Input.is_action_just_pressed("shoot") and vapor >= VAPOR_PROJECTILE_COST:
			vapor -= VAPOR_PROJECTILE_COST
			$Shoot.play()
			var proj : Projectile = Projectile_scene.instance()
			proj.velocity.x = PROJECTILE_SPEED
			if !facingRight:
				proj.velocity.x = -proj.velocity.x
			proj.global_position = self.global_position
			get_parent().add_child(proj)
			
	elif state == DropletState.VAPOR:
		 
		# Vertical movement
		var vdir : float = 0.0
		if Input.is_action_pressed("move_up"):
			vdir -= 1
		elif Input.is_action_pressed("move_down"):
			vdir += 1
		velocity.y = vdir * SPEED
	
	
	# Collision
	velocity = move_and_slide_with_snap(velocity, Vector2(0, .01), Vector2(0, -1))
	for i in range(0, get_slide_count()):
		var coll = get_slide_collision(i)
		if coll.collider.get_class() == "FlowerVine":
			hit(1)

#taking damage
func hit(damage):
	if invulnerability_timer.is_stopped() and is_invulnerable == false:
		invulnerability_timer.start()
		_set_health(health - damage)
		$DroppyBody/Face.play("default") #change to "hit" face later
		$DroppyBody/AnimationPlayer.play("hit")
		$Damage.play()
		is_invulnerable = true

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_lost", health)
		if health == 0:
			print("dead")
			get_tree().reload_current_scene()

func _on_Seagull_damage(damage):
	if is_invulnerable == false:
		hit(damage)


func _on_Invulnerability_timeout():
	is_invulnerable = false
	invulnerability_timer.stop()
	


func _on_Worm_damage(damage):
	if is_invulnerable == false:
		hit(damage)
