extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_next():
	get_tree().change_scene("res://Levels/Menu/MainMenu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("mouse_click")):
		load_next()

func _unhandled_input(event):
	if(event is InputEventScreenTouch):
		if(event.is_pressed()):
			load_next()
