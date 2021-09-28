extends enemyBase

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	apply_gravity(delta)

func _on_Trigger_PlayerEntered():
	set_physics_process(true)
	
	
