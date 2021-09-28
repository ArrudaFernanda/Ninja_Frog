extends Area2D

var velocity = Vector2.ZERO
var shoot_speed = -100

func _physics_process(delta):
	velocity.x = shoot_speed * delta
	
	#Não usa move_and_slide pq aqui não é KinematicBody
	translate(velocity)


func _on_clearNode_screen_exited():
	queue_free()
