extends Node2D


export var isEnabled = false

var projectile = preload("res://Entities/Player/Gun/Projectile.tscn")

func fire():
	var guns = $spawners.get_children()
	for gun in guns:
		var bullet = projectile.instance()
		bullet.global_position = gun.global_position
		bullet.set_as_toplevel(true)
		add_child(bullet)

func _on_gunTimer_timeout():
	if(isEnabled):
		fire()
