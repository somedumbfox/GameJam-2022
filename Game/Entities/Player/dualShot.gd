extends Node2D


export var isEnabled = true

var projectile = preload("res://Entities/Player/Gun/Projectile.tscn")


func _on_dualShotTimer_timeout():
	if(isEnabled):
		fire()

func fire():
	var guns = $spawners.get_children()
	for gun in guns:
		var bullet = projectile.instance()
		bullet.global_position = gun.global_position
		bullet.set_as_toplevel(true)
		add_child(bullet)
