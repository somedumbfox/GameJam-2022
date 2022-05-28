extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var scrollUp = false;
var SPEED = 50


# Called when the node enters the scene tree for the first time.
func _ready():
	reset()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(scrollUp):
		position -= Vector2(0,1)*SPEED*delta

func reset():
	position = Vector2(0,0)
	scrollUp = false
