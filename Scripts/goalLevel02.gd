extends Area2D

onready var changer = get_parent().get_node("Transition_in")
export var pasta = "res://Prefabs/YouWon.tscn"
func _ready():
	pass


func _on_goal_body_entered(body):
	if body.name == "Player":
		$confetti.emitting = true
		changer.change_scene(pasta)
		Global.checkpoint_position = 0
