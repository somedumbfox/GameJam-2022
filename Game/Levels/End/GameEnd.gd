extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/RichTextLabel.text = "Game Over\n\nFinal Score\n %d" % Globals.score

func load_next():
	get_tree().change_scene("res://Levels/Menu/MainMenu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_Button_pressed():
	load_next() # Replace with function body.
