extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var BGMvolumeSlider = $CanvasLayer/Settings/BGMVolume/VBoxContainer/BGMVolumeSlider
onready var SFXvolumeSlider = $CanvasLayer/Settings/SFXVolume/VBoxContainer/SFXVolumeSlider


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/Settings.hide()

func load_next():
	$AudioStreamPlayer.stop()
	get_tree().change_scene("res://Levels/MainLevel/MainLevel.tscn")

func open_settings():
	$CanvasLayer/Settings.show()

func close_settings():
	$CanvasLayer/Settings.hide()

func _unhandled_input(event):
	if(event is InputEventScreenTouch):
		if(event.is_pressed()):
			load_next()

func set_BGM_Volume(num:float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), num)

func set_SFX_Volume(num:float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), num)

func _on_Subtitle_pressed():
	load_next() # Replace with function body.



func _on_closeSettings_pressed():
	close_settings() # Replace with function body.


func _on_OpenSettings_pressed():
	open_settings() # Replace with function body.


func _on_BGMVolumeSlider_value_changed(value):
	set_BGM_Volume(BGMvolumeSlider.value)


func _on_SFXVolumeSlider_value_changed(value):
	set_SFX_Volume(SFXvolumeSlider.value)
