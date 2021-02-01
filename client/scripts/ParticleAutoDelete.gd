extends Particles2D

func _ready():
	set_one_shot(true)

func _process(delta):
	if not is_emitting():
		queue_free()
