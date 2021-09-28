extends Control


func _ready():
	pass


func _on_returnBtn_pressed():
	get_tree().change_scene("res://Prefabs/startScreen.tscn")
