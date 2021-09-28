extends Area2D


func _ready():
	pass


func _on_trampoline_body_entered(body):
	body.velocity.y = -500
	$anim.play("jump")
