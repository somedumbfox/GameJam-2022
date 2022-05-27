extends Node2D


export var isEnabled = true
var player : Node2D
var direction

var projectile = preload("res://Entities/NPC/Enemies/Projectiles/EnemyProjectile.tscn")

func _ready():
	#get_tree().get_root().print_tree_pretty()
	player = get_tree().get_root().find_node("Player", true, false)

func fire():
	var guns = $Spawners.get_children()
	var bullet = projectile.instance()
	# Don't fire if player is above me
	if(player != null and player.position.y < self.global_position.y):
		return
	#fire all available guns
	for gun in guns:
		if(player != null):
#			var rad = player.position.angle_to_point(self.global_position)
#			direction = Vector2(cos(rad), sin(rad))
			bullet.rotation_degrees = 90
#			bullet.direction = direction
			pass
		bullet.global_position = gun.global_position
		bullet.set_as_toplevel(true)
		get_tree().get_root().add_child(bullet)

func _on_gunTimer_timeout():
	if(isEnabled):
		fire()
