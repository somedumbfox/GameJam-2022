extends Node2D


export var isEnabled = false

var projectileLeft = preload("res://Entities/Player/Gun/angleLeftProjectile.tscn")
var projectileRight = preload("res://Entities/Player/Gun/angleRightProjectile.tscn")

var player

func _ready():
	player = get_parent().get_parent()

func fire():
	var count = 0
	var guns = $spawners.get_children()
	for gun in guns:
		var bullet
		if(count%2 == 0):
			bullet = projectileLeft.instance()
		else:
			bullet = projectileRight.instance()
		bullet.power = player.triShotPower
		bullet.global_position = gun.global_position
		bullet.set_as_toplevel(true)
		add_child(bullet)
		count += 1
		
func _on_gunTimer_timeout():
	if(isEnabled):
		fire()
