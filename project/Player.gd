extends KinematicBody2D

const Projectile = preload("res://Projectile.gd")
const Projectile_scene = preload("res://PlayerProjectile.tscn")

enum DropletState {
	NORMAL,
	VAPOR,
}

export var GRAVITY: float = 25
export var JUMP_FORCE : float = 350
export var SPEED : float = 100
export var PROJECTILE_SPEED : float = 250
export var SHOOT_COOLDOWN : float = 0.35

var state : int = DropletState.NORMAL
var velocity : Vector2 = Vector2()
var facingRight : bool = true
var shootCooldown : float = 0

func _ready() -> void:
	pass

func _physics_process(delta : float) -> void:
	# Change between vapor and not
	if Input.is_action_just_pressed("form_change"):
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
	
	#amanda's code
	if (velocity.length() > 0) && state == DropletState.NORMAL:
		$DroppyBody/Face.play("default")
		$DroppyBody.play("walk")
	else:
		$DroppyBody.play("default")
	#end amanda's code
	
	if shootCooldown > 0:
		shootCooldown -= delta
	
	# State-specific
	if state == DropletState.NORMAL:
		if velocity.length() <= 0: #ac
			$DroppyBody.play("default") #ac
			$DroppyBody/Face.play("default") #ac
		# Gravity, jumping
		velocity.y += GRAVITY
		if is_on_floor() and Input.is_action_just_pressed("move_up"):
			velocity.y = -JUMP_FORCE
		
		# Crouching
		var crouching : bool = Input.is_action_pressed("move_down")
		if (crouching): #ac
			$DroppyBody/Face.play("altcrouch") #ac
			$DroppyBody.play("altcrouch") #ac
			
		($Collision_Normal as CollisionShape2D).disabled = crouching
		($Collision_Crouch as CollisionShape2D).disabled = !crouching
		($DisplayForms/Normal as Node2D).visible = !crouching
		($DisplayForms/Crouch as Node2D).visible = crouching
		
		# Shooting
		if !crouching and Input.is_action_pressed("shoot") and shootCooldown <= 0:
			shootCooldown = SHOOT_COOLDOWN
			
			#not currently working but for when shooting sound effect is added
			#var shootEffect = get_tree().get_root().get_node("AudioStreamPlayer2D")
			#var voiceID = shootEffect.play("bloop.wav")
			#shootEffect.set_volume(voiceID, .1)
			
			var proj : Projectile = Projectile_scene.instance()
			proj.velocity.x = PROJECTILE_SPEED
			if !facingRight:
				proj.velocity.x = -proj.velocity.x
			proj.global_position = self.global_position
			get_parent().add_child(proj)
	elif state == DropletState.VAPOR:
		$DroppyBody/Face.play("default") #ac, should be changed to "vapor" face when i add that
		$DroppyBody.play("vapor") #ac
		# Vertical movement
		var vdir : float = 0.0
		if Input.is_action_pressed("move_up"):
			vdir -= 1
		elif Input.is_action_pressed("move_down"):
			vdir += 1
		velocity.y = vdir * SPEED
	
	# Collision
	velocity = move_and_slide_with_snap(velocity, Vector2(0, .01), Vector2(0, -1))
	
