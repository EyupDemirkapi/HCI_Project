extends Node2D

const SPEED = 45
var ySpeed = 0
var direction = -1
@onready var sprite = $AnimatedSprite2D
@onready var RayLeft = $RaycastLeft
@onready var RayRight = $RaycastRight
@onready var RayDown = $RaycastDown
@onready var player = $/root/Game/Player



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	position.x += direction * delta * SPEED
	
	if RayLeft.is_colliding() and RayLeft.get_collider() != player:
		direction = 1
	elif RayRight.is_colliding() and RayRight.get_collider() != player:
		direction = -1
	if RayDown.is_colliding():
		ySpeed = 0
	else:
		ySpeed += 10
		position.y += delta * ySpeed
	
	if direction > 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
