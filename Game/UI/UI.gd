extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score = 0
var multiplier = 1
var UIlives = 9
var distance = 0
var max_distance = 0
onready var scoreDisplay = $ScoreDisplay/Score
onready var liveIcons = $Lives
onready var multiLabel = $MultiplierDisplay/MultiplierLabel
onready var multiCurrent = $MultiplierDisplay/Multiplier


# Called when the node enters the scene tree for the first time.
func _ready():
	increment_score(0)
	update_multiplier(2)
	update_lives(9)

func update_lives(num):
	if num > liveIcons.get_child_count():
		return
	var i = 1
	for icon in liveIcons.get_children():
		if(i <= num):
			icon.modulate = Color(1,1,1,1)
		else:
			icon.modulate = Color(1,1,1,0.1)
		i+=1

func update_multiplier(num):
	multiplier = num
	if(multiplier > 1):
		multiCurrent.show()
		multiLabel.show()
		multiCurrent.play("x%d"%multiplier)
	else:
		multiCurrent.hide()
		multiLabel.hide()
		multiCurrent.play("default")

func increment_score(num):
	score += num * multiplier
	scoreDisplay.text = "%010d"%score
	Globals.score = score

func update_distance(num):
	distance = num
	$Distance/Progress.value = distance

func update_max_distance(num):
	max_distance = num
	$Distance/Progress.max_value = max_distance

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
