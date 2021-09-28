extends Control


func _ready():
	#dá o acesso aos buttons pelo teclado, além do foco no btn desejado:
	$controls/startBtn.grab_focus()


func _on_startBtn_pressed():
	get_tree().change_scene("res://Levels/Level_01.tscn")
	


func _on_controlsBtn_pressed():
	get_tree().change_scene("res://Prefabs/controlsScreen.tscn")


func _on_quitBtn_pressed():
	get_tree().quit()
