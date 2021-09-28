extends Area2D

onready var changer = get_parent().get_node("Transition_in")
func _ready():
	pass


func _on_goal_body_entered(body):
	if body.name == "Player":
		$confetti.emitting = true
		changer.change_scene("res://Levels/Level_02.tscn")
		Global.checkpoint_position = 0
