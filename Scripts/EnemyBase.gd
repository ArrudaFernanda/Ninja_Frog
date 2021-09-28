extends KinematicBody2D
#Agora este script se torna uma classe acessivel
class_name enemyBase

export var speed = 64
export var health = 1
var velocity = Vector2.ZERO
var move_direction = -1
onready var texture = get_node("texture")
onready var anim = get_node("anim")
onready var ray_wall = get_node("ray_wall")
var gravity = 1200
var hitted = false

#var vida = 3
var maxVida = 3

func _physics_process(delta):
	velocity.x = speed * move_direction
	
	velocity = move_and_slide(velocity)
	
	if move_direction == 1:
		texture.flip_h = true
	else:
		texture.flip_h = false
	if ray_wall.is_colliding():
		anim.play("idle")
	
func apply_gravity(delta):
	velocity.y += gravity * delta

func _on_anim_animation_finished(anim_name):
	if anim_name == "idle":
		ray_wall.scale.x *= -1
		move_direction *= -1
		anim.play("run")

func _on_hitbox_body_entered(body):
	$".".queue_free()

	
signal changeLife(vida)

func _ready() -> void:
	connect("changeLife", get_parent().get_node("HUD/HBoxContainer/Holder"), "on_change_life")
	emit_signal("changeLife", maxVida)


func _on_hurtbox_body_entered(body):
	Global.vida -= 1
	emit_signal("changeLife", Global.vida)
	if Global.vida <= 0:
		yield(get_tree().create_timer(1), "timeout")
		queue_free()
		Global.is_dead = true
		get_tree().change_scene("res://Prefabs/GameOver.tscn")


