extends Node2D


export var isEnabled = true
var player

var projectile = preload("res://Entities/Player/Gun/Projectile.tscn")

func _ready():
	player = get_parent().get_parent()

func fire():
	var guns = $spawners.get_children()
	for gun in guns:
		var bullet = projectile.instance()
		bullet.power = player.bulletPower
		bullet.global_position = gun.global_position
		bullet.set_as_toplevel(true)
		add_child(bullet)


func _on_gunTimer_timeout():
	if(isEnabled):
		fire()
