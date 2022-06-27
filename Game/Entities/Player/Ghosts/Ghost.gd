extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var isEnabled: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func enable():
	visible = true
	isEnabled = true
	$EntityCollisionDetector.set_deferred("monitoring", true)
	$EntityCollisionDetector.set_deferred("monitorable", true)

func disable():
	visible = false
	isEnabled = false
	$EntityCollisionDetector.set_deferred("monitoring", false)
	$EntityCollisionDetector.set_deferred("monitorable", false)


func _on_EntityCollisionDetector_area_entered(area):
	if(area.get_collision_layer_bit(3) and isEnabled):
		area.get_parent().queue_free()
