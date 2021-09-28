extends Area2D
var maxVida = 3
signal changeLife(vida)

func _ready():
	connect("changeLife", get_parent().get_node("HUD/HBoxContainer/Holder"), "on_change_life")
	emit_signal("changeLife", maxVida)

func _on_Fire_body_entered(body):
	Global.vida -= 1
	emit_signal("changeLife", Global.vida)
	if Global.vida <= 0:
		yield(get_tree().create_timer(1), "timeout")
		queue_free()
		Global.is_dead = true
		get_tree().change_scene("res://Prefabs/GameOver.tscn")


func _on_startTimer_timeout():
	$anim.play("on")
	$FireCol.set_deferred("disabled", false)


func _on_stopTimer_timeout():
	$anim.play("off")
	$FireCol.set_deferred("disabled", true)
