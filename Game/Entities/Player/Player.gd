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
var lives = 9

enum {dualShot = 0, dualShotPowerup = 15, triShot = 30, triShotPowerUp = 60, quintSpread = 180, quintSpreadPowerup = 290}


# Called when the node enters the scene tree for the first time.
func _ready():
	health = 3
	SPRITE = $EntitySprite
	pass # Replace with function body.

func _process(delta):
	update_debug_box()
	
func update_debug_box():
	$health.text = "Lives: %d\nHealth: %d\nCombo: %d\nMultiplier: %d" % [lives, health, combo, multiplier]
	
func increment_combo(num):
	combo += num
	update_guns()
	update_multiplier()

func update_multiplier():
	if(range(dualShot, dualShotPowerup).has(combo)):
		multiplier = 1
	if(range(dualShotPowerup, triShot).has(combo)):
		multiplier = 2
	if(range(triShot, triShotPowerUp).has(combo)):
		multiplier = 4
	if(range(triShotPowerUp, quintSpread).has(combo)):
		multiplier = 8
	if(range(quintSpread, quintSpreadPowerup).has(combo)):
		multiplier = 16

func reset_combo():
	combo = 0
	multiplier = 1
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
#	if(mouse.x > self.position.x+10):
#		SPRITE.play("floatRight")
#		pass
#	elif(mouse.x < self.position.x-10):
#		SPRITE.play("floatLeft")
#		pass
#	else:
#		SPRITE.play("default")
	
	var move = mouse - self.position
	position += (move*delta*SPEED)
	position.x = clamp(position.x, 0 , DefaultCamera.zoom.x*600) #keep player position in bounds
	position.y = clamp(position.y, DefaultCamera.position.y+256, DefaultCamera.position.y+1024*DefaultCamera.zoom.y)


func get_position_of_pointers():
	if(!screen_controls_enabled):
		mouse_position = DefaultCamera.get_global_mouse_position()
	
func _unhandled_input(event):
	if(event is InputEventScreenDrag):
		screen_controls_enabled = true
		mouse_position = event.position


func _on_EntityCollisionDetector_area_entered(area):
	$AnimationPlayer.play(("RESET"))
	$AnimationPlayer.play("hit") 
	health -= 1
	if(health == 0):
		lives -= 1
		health = 3
		reset_guns()
		reset_combo()
