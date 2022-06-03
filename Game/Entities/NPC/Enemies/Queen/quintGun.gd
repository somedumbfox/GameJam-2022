extends Node2D


export var isEnabled = true
var player : Node2D
var direction

var projectile = preload("res://Entities/NPC/Enemies/Projectiles/EnemyProjectile.tscn")

func _ready():
	#get_tree().get_root().print_tree_pretty()
	player = get_tree().get_root().find_node("Player", true, false)
	pass

func fire():
	var guns = $Spawners.get_children()
	# Don't fire if player is above me
	if(player != null and player.position.y < self.global_position.y):
		return
	#fire all available guns
	var count = 0
	for gun in guns:
		var bullet = projectile.instance()
		match(count):

			0:
				bullet.direction = Vector2(-.25, 0)
				bullet.rotation_degrees = 180
				continue
			1:
				bullet.direction = Vector2(-.3, .3)
				bullet.rotation_degrees = 135
				continue
			2:
				bullet.direction = Vector2(0, .5)
				bullet.rotation_degrees = 90
				continue
			3:
				bullet.direction = Vector2(.3, .3)
				bullet.rotation_degrees = 45
				continue
			4:
				bullet.direction = Vector2(.25, 0)
				continue
		#var rad = player.position.angle_to_point(self.global_position)
		#direction = Vector2(cos(rad), sin(rad))
		#bullet.direction = direction
		bullet.global_position = gun.global_position
		bullet.set_as_toplevel(true)
		get_tree().get_current_scene().add_child(bullet)
		count +=1

func _on_gunTimer_timeout():
	if(isEnabled):
		fire()
