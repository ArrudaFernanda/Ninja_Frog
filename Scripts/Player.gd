extends KinematicBody2D
#Movimentação no eixo x e y:
var velocity : Vector2 = Vector2()
#Agora sim velocidade:
var move_speed = 200
var gravity = 800
var jump_force = 600
onready var sprite : AnimatedSprite = get_node("sprite")


#Loop do jogo
func _physics_process(delta: float) -> void:
	#Gravity
	velocity.y += gravity * delta
	
	#Movement inputs
	if Input.is_action_pressed("move_left"):
		velocity.x = -move_speed
		sprite.play("run")
	elif Input.is_action_pressed("move_right"):
		velocity.x = move_speed
		sprite.play("run")
	else:
		velocity.x = 0
		sprite.play("idle")
		
	#Para blocos empurráveis
	if velocity.x > 1:
		$pushRight.set_enabled(true)
	else:
		$pushRight.set_enabled(false)
		
	if velocity.x < -1:
		$pushLeft.set_enabled(true)
	else:
		$pushLeft.set_enabled(false)
	
	if $pushRight.is_colliding():
		var object = $pushRight.get_collider()
		object.move_and_slide(Vector2(30,0) * move_speed * delta)
	elif $pushLeft.is_colliding():
		var object = $pushLeft.get_collider()
		object.move_and_slide(Vector2(-30, 0) * move_speed * delta)
	getDirection()
	
	# applying the velocity
	# se atribui a vel para quando o personagem cair, cai
	#suavemente.
	velocity = move_and_slide(velocity, Vector2.UP)
	
	#Melhor modo de ajustar para que o player só pule uma vez,
	#e não permita pular no ar.
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y -= jump_force
	else:
		sprite.play("jump")
		#Como ainda não dá pra testar os sons deixar este comando comentado:
		#$jumpFx.play()
		for platforms in get_slide_count():
			var collision = get_slide_collision(platforms)
			if collision.collider.has_method("collide_with"):
				collision.collider.collide_with(collision, self)
		
#Para espelhar o player conforme a direção:	
func getDirection():
	var move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	if move_direction != 0:
		$sprite.scale.x = move_direction

#Confuguram o checkpoint do jogador
"""
Aparentemente a função _ready() se autoinicia?.
ou, na verdade, Global.gd é quem está em ação.
este position.x, creio ser um position do próprio gdscript.
"""
func _ready() -> void:
	Global.set("player", self)
	position.x = Global.checkpoint_position

func hit_checkpoint():
	Global.checkpoint_position = position.x


func _on_headCollider_body_entered(body):
	if body.has_method("destroy"):
		body.destroy()


func _on_Trigger_PlayerEntered():
	print("Entrou.")
