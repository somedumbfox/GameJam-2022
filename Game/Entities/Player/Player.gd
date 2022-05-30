extends "res://Entities/Entity/Entity.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mouse_position : Vector2
var screen_controls_enabled = false
var combo = 0
var multiplier = 1
export var dualShotPower = 1
export var triShotPower = 1
export var quintShotPower = 1
const SPEED = 10
var SPRITE
var CAMERA
const max_lives = 9
var bulletsAbsorbed = 0
var ghostMode = false

enum {dualShot = 0, dualShotPowerup = 15, triShot = 30, triShotPowerUp = 60, quintSpread = 180, quintSpreadPowerup = 290}


# Called when the node enters the scene tree for the first time.
func _ready():
	health = 3
	SPRITE = $EntitySprite
	define_ghost_paths()
	pass # Replace with function body.

func _process(delta):
	update_debug_box()
	
func update_debug_box():
	$health.text = "Lives: %d\nHealth: %d\nCombo: %d\nMultiplier: %d\nBullets Absrobed: %d" % [numLives, health, combo, multiplier, bulletsAbsorbed]

func define_ghost_paths():
	var GhostPath = $GhostPath
	GhostPath.curve.clear_points()
	var points = 9
	#create the circle
	for i in points:
		GhostPath.curve.add_point(Vector2(0, -125).rotated((i / float(points)) * TAU))
	# End the circle.
	GhostPath.curve.add_point(Vector2(0, -125))
	var count = 0
	for path in GhostPath.get_children():
		path.set_unit_offset(float(count)/float(GhostPath.get_child_count()))
		path.get_child(0).disable()
		count += 1
		pass

func update_ghost_speed(speedupdate:float):
	for path in $GhostPath.get_children():
		path.speed_increase = speedupdate

func update_ghost():
	if(numLives == max_lives):
		return
	var numGhosts = max_lives - numLives
	if (numGhosts == max_lives or numGhosts > max_lives):
		return
	var ghostsToAdjust = $GhostPath.get_children()
	var i = 0
	while i < numGhosts:
		ghostsToAdjust[i].set_unit_offset(float(i)/float(numGhosts))
		ghostsToAdjust[i].speed_increase = 1.0 + (float(numLives)/float(max_lives) * 2)
		ghostsToAdjust[i].get_child(0).enable()
		i += 1
	pass
	
	
func increment_combo(num):
	if(!ghostMode):
		combo += num
		update_guns()
		update_multiplier()

func update_multiplier():
	var before = multiplier
	if(range(dualShot, dualShotPowerup).has(combo)):
		multiplier = 1
	if(range(dualShotPowerup, triShot).has(combo) and numLives >= 2):
		multiplier = 2
	if(range(triShot, triShotPowerUp).has(combo) and numLives >= 4):
		multiplier = 4
	if(range(triShotPowerUp, quintSpread).has(combo) and numLives >= 6):
		multiplier = 6
	if(range(quintSpread, quintSpreadPowerup).has(combo) and numLives == 9):
		multiplier = 9
	
	if(before != multiplier):
		get_tree().call_group("UI", "update_multiplier", multiplier)

func reset_combo():
	combo = 0
	update_multiplier()
	reset_guns()

func reset_guns():
	$Guns/triShot.isEnabled = false
	$Guns/quintSpread.isEnabled = false
	dualShotPower = 1
	triShotPower = 1
	quintShotPower = 1

func update_guns():
	if(combo >= quintSpreadPowerup):
		quintShotPower = 2
	if(combo >= quintSpread):
		$Guns/quintSpread.isEnabled = true
	if(combo >= triShotPowerUp):
		triShotPower = 2
	if(combo >= triShot):
		$Guns/triShot.isEnabled = true
	if(combo >= dualShotPowerup):
		dualShotPower = 2
	if(combo >= dualShot):
		$Guns/dualShot.isEnabled = true

func _physics_process(delta):
	get_position_of_pointers()
	_move_player(mouse_position, delta)

func _move_player(mouse:Vector2, delta):
	if(mouse.x > self.position.x+20):
		SPRITE.play("floatRight")
	elif(mouse.x < self.position.x-20):
		SPRITE.play("floatLeft")
	else:
		SPRITE.play("default")
	
	var move = mouse - self.position
	position += (move*delta*SPEED)
	position.x = clamp(position.x, 0 , 600) #keep player position in bounds
	position.y = clamp(position.y, DefaultCamera.position.y+256, DefaultCamera.position.y+1024)


func get_position_of_pointers():
	if(!screen_controls_enabled):
		mouse_position = DefaultCamera.get_global_mouse_position()

# mobile controls really funky, kinetic bodies don't work well
#func _unhandled_input(event):
#	if(event is InputEventScreenDrag):
#		screen_controls_enabled = true
#		mouse_position = event.position

func enter_Ghost_Recovery():
	$AnimationPlayer.play("RESET")
	disable_guns()
	disable_ghosts()
	bullet_absorb_enable()
	$ghostTimer.start(0)
	$AnimationPlayer.play("ghostMode")
	pass

func disable_guns():
	reset_guns()
	$Guns/dualShot.isEnabled = false
	$Guns/triShot.isEnabled = false
	$Guns/quintSpread.isEnabled = false
	pass

func enable_guns():
	reset_combo()
	reset_guns()
	$Guns/dualShot.isEnabled = true
	pass

func exit_Ghost_Recovery():
	bullet_absorb_disable()
	numLives = clamp(bulletsAbsorbed, 1, 9)
	get_tree().call_group("UI", "update_lives", numLives)
	$AnimationPlayer.play("RESET")
	enable_guns()
	update_ghost()
	pass

func disable_ghosts():
	var ghostsToAdjust = $GhostPath.get_children()
	for ghost in ghostsToAdjust:
		ghost.get_child(0).disable()
	pass

func bullet_absorb_enable():
	ghostMode = true
	bulletsAbsorbed = 0
	pass

func bullet_absorb_disable():
	ghostMode = false
	pass

func _on_EntityCollisionDetector_area_entered(area):
	if(!ghostMode):
		$AnimationPlayer.play("RESET")
		$AnimationPlayer.play("hit") 
		health -= 1
		if(area.get_collision_layer_bit(3)):
			area.get_parent().hit()
		if(health == 0):
			numLives -= 1
			update_ghost()
			health = 3
			reset_guns()
			reset_combo()
			get_tree().call_group("UI", "update_lives", numLives)
		if(numLives == 0):
			enter_Ghost_Recovery()
		return
	#Ghost mode only
	if(area.get_collision_layer_bit(3)):
		area.get_parent().absorb()
		bulletsAbsorbed += 1


func _on_ghostTimer_timeout():
	exit_Ghost_Recovery() # Replace with function body.
