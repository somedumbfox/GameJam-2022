extends "res://Entities/Entity/Entity.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mouse_position : Vector2
var screen_controls_enabled = false
const SPEED = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _physics_process(delta):
	get_position_of_pointers()
	_move_player(mouse_position, delta)

func _move_player(mouse:Vector2, delta):
	var move = mouse - self.position
	position += (move*delta*SPEED)
	position.x = clamp(position.x, 0 , 600) #keep player position in bounds
	position.y = clamp(position.y, 256, 1024)


func get_position_of_pointers():
	if(!screen_controls_enabled):
		mouse_position = get_viewport().get_mouse_position()
	
func _unhandled_input(event):
	if(event is InputEventScreenDrag):
		screen_controls_enabled = true
		mouse_position = event.position
