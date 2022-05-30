extends PathFollow2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var SPEED = 50
export var speed_increase:float = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	set_offset(get_offset() + (SPEED*speed_increase) * delta)
	pass
