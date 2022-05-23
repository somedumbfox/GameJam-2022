extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func load_next():
	get_tree().change_scene("res://Levels/End/GameEnd.tscn")

func _process(delta):
	if(Input.is_action_just_pressed("ui_cancel")):
		load_next()

func _unhandled_input(event):
	if(event is InputEventScreenTouch):
		if(event[1].is_pressed()):
			load_next()