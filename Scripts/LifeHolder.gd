extends Control

var life_size = 32

func on_change_life(vida):
	$lifes.rect_size.x = Global.vida * life_size
