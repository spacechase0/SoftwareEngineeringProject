# Software Implementation and Testing For Group <X>
Version 1.0
# Authors
Chase Warrington <!-- spacechase0 -->

Amanda Lovett<!-- arin -->

Megan Primavera<!-- Danger Duchess -->

Carissa Garde<!-- HollenStarr -->

# Programming Languages
<!-- 5 points -->
GDScript - Godot's in-house scripting language, using due to ease of access and efficient management of programming/game designing capabilities.
<!-- List the programming languages use in your project, where you use them (what components of your project) and your reason for choosing them (whatever that may be).  -->

# Platforms, APIs, Databases, and other technologies used
<!-- 5 points -->
* Godot Engine - programming, implementation of all other elements into one software 
* Sibelius, Audacity - music and sound design
* Paint Tool SAI - artwork
* Github - writing/storyboarding 
<!-- List all the platforms, APIs, Databases, and any other technologies you use in your project and where you use them (in what components of your project). -->

# Execution-based Functional Testing
<!-- 10 points -->
Basic character movement function has been determined and tested, namely:
- A change in form/artwork for normal walking, crouching, and flying (aka water vapor)
- The ability to stand on platforms without phasing through them
- The ability to shoot projectiles, but only when in normal form
- The ability to be injured by enemies
Basic enemy has been determined and tested, namely:
- A walk cycle independent of the player
- The ability to collide with the player
- The ability to disappear when destroyed
A Pause menu has been determined and tested:
- Ability to exit game
- Ability to pause game and resume
<!-- Describe how/if you performed functional testing for your project (i.e., tested for the functional requirements listed in your RD). -->

# Execution-based Non-Functional Testing
<!-- 10 points -->
Testing of various visual functions have been performed:
- The player character (Droppy's) form animations have been tested, namely crouching, walking, and vapor forms.
- A camera follows the player character(Droppy)
- The cloud platform have been tested and match up with the collision form underneath.
- The seagull enemy is successfully drawn and animated, and disappears when a projectile successfully collides with it.
- Dialogue boxes are triggered when the player reaches certain points of the stage
- Dialogue boxes successfully close when the player hits "Enter"
- A Pause menu has been added and triggers when player hits "ESC"
- Pause menu resumes game when "Continue" is pressed
- Pause Menu exits game when "Exit" is pressed
- Cutscene is triggered at the Cutscene triggers
- Borders were added to prevent player from going out of bounds
<!-- Describe how/if you performed non-functional testing for your project (i.e., tested for the non-functional requirements listed in your RD). -->
Testing of audio functions has also been performed:
- Music restarts and loops through the themes once the clip is over
- Clips have been edited to ensure little pause between songs

# Non-Execution-based Testing
<!-- 10 points -->
Components such as art, story, character design, and music have all been presented to every member of the group, and changes have been made where necessary. Code has been uploaded and shared through Git, and those working on the code have partaken in reviews to ensure functionality.
<!-- Describe how/if you performed non-execution-based testing (such as code reviews/inspections/walkthroughs). -->
