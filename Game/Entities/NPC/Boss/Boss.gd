extends "res://Entities/Entity/Entity.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var SPEED = 0
var offScreen = true
signal onDestroy;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_EntityCollisionDetector_area_entered(area:Area2D):
	if(area.get_collision_layer_bit(4)):
		SPEED = 0
		$AnimationPlayer.play("die")
		return
	
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
		
	if(health <= 0):
		get_tree().call_group("UI", "increment_score", scoreValue)
		$AnimationPlayer.play("die")
		emit_signal("onDestroy")
		
func play_hit():
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.play("hit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_entered():
	offScreen = false # Replace with function body.


func _on_Boss_onDestroy():
	pass # Replace with function body.
