extends Sprite

export var speed = 250
export var random = 0.15

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	speed += random * rng.randi_range(-speed, speed)

func _process(delta):
	if position.y < -(texture.get_size().y/2):
		Server.send_bullet(position.x, speed)
		queue_free()
	else:
		position.y -= speed * delta
