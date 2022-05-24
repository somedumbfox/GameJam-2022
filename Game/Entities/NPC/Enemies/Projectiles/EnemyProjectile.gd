extends KinematicBody2D

const SPEED = 500
export var power = 1

var direction = Vector2(0,1)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


#Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

func _physics_process(_delta):
	move()
	
func move():
	move_and_slide(direction*SPEED)

func _on_VisibilityNotifier2D_screen_exited():
	#print_debug("I'm gone")
	$AnimationPlayer.play("RESET")
	queue_free()
