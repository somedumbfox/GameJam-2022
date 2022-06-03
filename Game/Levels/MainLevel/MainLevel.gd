extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var topmostPostion : Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	DefaultCamera.reset()
	DefaultCamera.scrollUp = true
	topmostPostion = $Backgrounds.get_child($Backgrounds.get_child_count()-1).position
	get_tree().call_group("UI", "update_max_distance", abs(topmostPostion.y))


# Called every frame. 'delta' is the elapsed time since the previous frame.

func load_next():
	get_tree().change_scene("res://Levels/End/GameEnd.tscn")

func _process(delta):
	if(Input.is_action_just_pressed("ui_cancel")):
		load_next()
	if(DefaultCamera.position.y <= topmostPostion.y):
		DefaultCamera.scrollUp = false
		DefaultCamera.position = topmostPostion
	else:
		get_tree().call_group("UI", "update_distance", abs(DefaultCamera.position.y))

func _unhandled_input(event):
	if(event is InputEventScreenTouch):
		if(event[1].is_pressed()):
			load_next()


func _on_Boss_tree_exited():
	$AudioStreamPlayer.stop()
	load_next() # Replace with function body.


func _on_Boss_onDestroy():
	$AudioStreamPlayer.stop()
	load_next() # Replace with function body.
