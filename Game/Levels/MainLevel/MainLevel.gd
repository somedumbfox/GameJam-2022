extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var topmostPostion : Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	DefaultCamera.reset()
	DefaultCamera.scrollUp = true
	topmostPostion = $Backgrounds.get_child($Backgrounds.get_child_count()-1).position


# Called every frame. 'delta' is the elapsed time since the previous frame.

func load_next():
	get_tree().change_scene("res://Levels/End/GameEnd.tscn")

func _process(delta):
	if(Input.is_action_just_pressed("ui_cancel")):
		load_next()
	if(DefaultCamera.position.y <= topmostPostion.y):
		DefaultCamera.scrollUp = false
		DefaultCamera.position = topmostPostion

func _unhandled_input(event):
	if(event is InputEventScreenTouch):
		if(event[1].is_pressed()):
			load_next()
