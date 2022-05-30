extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_next():
	get_tree().change_scene("res://Levels/MainLevel/MainLevel.tscn")

func _process(delta):
	pass

func _unhandled_input(event):
	if(event is InputEventScreenTouch):
		if(event.is_pressed()):
			load_next()


func _on_Subtitle_pressed():
	load_next() # Replace with function body.
