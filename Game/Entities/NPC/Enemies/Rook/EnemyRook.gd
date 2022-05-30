extends "res://Entities/Entity/Entity.gd"


var SPEED = 75
var offScreen = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!offScreen):
		position += Vector2(0,1)*SPEED*delta
	$RichTextLabel.text = String(health)


func _on_EntityCollisionDetector_area_entered(area:Area2D):
	if(area.get_collision_layer_bit(2)):
		var projectile:Node = area.get_parent()
		if(!offScreen):
			if projectile.get("power") != null:
				play_hit()
				health -= projectile.power
				projectile.queue_free()
				get_tree().call_group("combo", "increment_combo", projectile.power)
	else:
		play_hit()
		health -= 1

	$RichTextLabel.text = String(health)
	if(health <= 0 or area.get_collision_layer_bit(4)):
		get_tree().call_group("UI", "increment_score", scoreValue)
		$Gun/gunTimer.stop()
		$AnimationPlayer.play("die")

func play_hit():
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.play("hit")


func _on_VisibilityNotifier2D_screen_entered():
	offScreen = false
	$Gun/gunTimer.start()
