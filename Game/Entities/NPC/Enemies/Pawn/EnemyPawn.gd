extends "res://Entities/Entity/Entity.gd"


var SPEED = 200
var offScreen = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2(0,1)*SPEED*delta
	$RichTextLabel.text = String(health)


func _on_VisibilityEnabler2D_screen_entered():
	offScreen = false
	$Gun/gunTimer.start()


func _on_EntityCollisionDetector_area_entered(area:Area2D):
	if(area.get_collision_layer_bit(2)):
		var projectile:Node = area.get_parent()
		if(!offScreen):
			if projectile.get("power") != null:
				play_hit()
				health -= projectile.power
				projectile.queue_free()
	else:
		play_hit()
		health -= 1

	$RichTextLabel.text = String(health)
	if(health <= 0 or area.get_collision_layer_bit(4)):
		queue_free()

func play_hit():
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.play("hit")
