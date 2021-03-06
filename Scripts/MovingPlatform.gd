extends Node

onready var platform = $platform
onready var tween = $Tween
export var speed = 3.0
export var horizontal = true
export var distance = 192
const WAIT_DURATION = 1.0

func _ready():
	_start_tween()

func _start_tween():
	var move_direction = Vector2.RIGHT * distance if horizontal else Vector2.UP * distance
	var duration = move_direction.length() / float(speed * 16)
	tween.interpolate_property(
		platform, "position", Vector2.ZERO, move_direction, duration,
		 Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, WAIT_DURATION
	)
	tween.interpolate_property(
		platform, "position", move_direction, Vector2.ZERO, duration,
		 Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + WAIT_DURATION * 2
	)
	tween.start()
