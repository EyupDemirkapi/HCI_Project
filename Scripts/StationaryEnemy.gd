extends Node2D

const LEVEL_LIMIT = 120
const isStationary = true

@onready var HEALTH = $Stats.HEALTH
@onready var STRENGTH = $Stats.STRENGTH
@onready var INVI_DURATION = $Stats.INVI_DURATION
@onready var MASS = $Stats.MASS
@onready var BYPASSES_INVIS = $Stats.BYPASSES_INVIS
@onready var AWARENESS = $Stats.AWARENESS

var ySpeed = 0
var invitimer = 0
var knockedBack = false
var freed = false
var attacking = false

@onready var sprite = $AnimatedSprite2D
@onready var RayLeft = $RaycastLeft
@onready var RayRight = $RaycastRight
@onready var RayDown = $RaycastDown
@onready var player = $/root/Game/Player
@onready var hurtArea = $HurtArea

func _ready() -> void:
	RayDown.set_collision_mask_value(get_parent().get_tileset().get_physics_layer_collision_layer(0),true)
	hurtArea.set_collision_mask_value(get_parent().get_tileset().get_physics_layer_collision_layer(0),true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if AWARENESS <= 0 or abs(position.x - player.position.x) <= AWARENESS:
		attacking = true
	
	if position.y > LEVEL_LIMIT:
		queue_free()
	#$Label.text = "HP: " + str(int(HEALTH))
	if HEALTH > 0:
		if invitimer > 0:
			invitimer -= delta
		
		if not knockedBack:
			sprite.play("Walk")
		else:
			sprite.play("Hurt")
		
		if RayDown.is_colliding() and RayDown.get_collider() != player:
			if sprite.animation == "Hurt" and sprite.frame > 0:
				knockedBack = false
			if ySpeed >= 0:
				ySpeed = 0
		else:
			ySpeed += 10
		
	else:
		if sprite.animation != "Dead":
			sprite.play("Dead")
		if not freed:
			ySpeed = -250
			freed = true
		ySpeed += 10
	position.y += delta * ySpeed

func knockback(playerPos,strength) -> void:
	if HEALTH > 0:
		knockedBack = true
		ySpeed = -25 * strength
