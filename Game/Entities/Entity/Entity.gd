extends Node2D


export var health:int = 3 # The amount of health this entity has.
export var numLives:int = 1 # The amount of Lives this entity has.
export var hasDied:bool = false # The entity has been marked for death.
export var scoreValue = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _damage_health(num:int = 1):
	health -= num
	if(health < 0):
		health = 0
