extends KinematicBody2D

export var speed = 100
export var knockback = 70
export var thrust = 2

var bullet = preload("res://scenes/instances/Bullet.tscn")

var velocity = Vector2()
var damping = 0.99

func _ready():
	pass

func get_input():
	var vector = Vector2()
	# Handle user movement input
	if Input.is_action_pressed("ui_right"):
		vector.x += 1
	if Input.is_action_pressed("ui_left"):
		vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		vector.y += 1
	if Input.is_action_pressed("ui_up"):
		vector.y -= 1
	velocity += vector.normalized() * thrust
	# Handle fire input
	if Input.is_action_just_pressed("ui_accept"):
		shoot()

func shoot():
	velocity += Vector2(0, knockback)
	var new_bullet = bullet.instance()
	new_bullet.position = position
	get_tree().get_root().add_child(new_bullet)

func _physics_process(delta):
	get_input()
	move_and_slide(velocity * speed * delta)
	
	for i in get_slide_count():
		var collision: KinematicCollision2D = get_slide_collision(i)
		if round(collision.normal.x) != 0:
			velocity.x = 0
		if round(collision.normal.y) == -1:
			velocity.y = 0
	velocity *= damping
