extends KinematicBody2D

export (Array, PackedScene) var fruit_instance
export (int, 0, 20, 1) var fruits = 0
var divX = 2
var divY = 2

func destroy():
	fruits -= 1
	if fruits < 0:
		var region = $texture.region_rect
		var texture = $texture.texture
		var sizeX = region.size.x / divX
		var sizeY = region.size.y / divY
		
		for height in range(divY):
			for width in range(divX):
				var rect = Rect2(region.position.x + (sizeX * width), region.position.y + (sizeY *  height), sizeX, sizeY)
				var sprite = Sprite.new()
				sprite.texture = texture
				sprite.region_enabled = true
				sprite.region_rect = rect
				sprite.centered = false
				sprite.global_position = $texture.global_position
				var rigid = RigidBody2D.new()
				rigid.add_child(sprite)
				get_parent().add_child(rigid)
				rigid.apply_impulse(Vector2.ZERO, Vector2(rand_range(-50, -50), rand_range(-100, -150)))
				
				
