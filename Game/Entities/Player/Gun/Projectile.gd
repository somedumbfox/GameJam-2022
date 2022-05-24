extends KinematicBody2D

const SPEED = 500

var DIRECTION = Vector2(0,-1)


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("fire")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	move()
	
func move():
	move_and_slide(DIRECTION*SPEED)

func _on_VisibilityNotifier2D_screen_exited():
	#print_debug("I'm gone")
	queue_free()
