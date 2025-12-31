extends Node2D

const LEVEL_LIMIT = 120
const isStationary = false
const IS_ENEMY = true

@onready var SPEED = $Stats.SPEED
@onready var HEALTH = $Stats.HEALTH
@onready var STRENGTH = $Stats.STRENGTH
@onready var INVI_DURATION = $Stats.INVI_DURATION
@onready var MASS = $Stats.MASS
@onready var BYPASSES_INVIS = $Stats.BYPASSES_INVIS
@onready var AWARENESS = $Stats.AWARENESS
@onready var ATTACKTIMER = $Stats.ATTACKTIMER
@onready var KNOCKABLE = $Stats.KNOCKABLE
@onready var RELOADTIMER = $Stats.RELOADTIMER

var animfinished = false
var xSpeed = 0
var ySpeed = 0
var direction = -1
var invitimer = 0
var knockedBack = false
var freed = false
var attacking = false
var attackTimer = ATTACKTIMER

@onready var sprite = $AnimatedSprite2D
@onready var RayLeft = $RaycastLeft
@onready var RayRight = $RaycastRight
@onready var RayDown = $RaycastDown
@onready var player = $/root/Game/Modulate/Player
@onready var hurtArea = $HurtArea

func _ready() -> void:
	attackTimer = ATTACKTIMER
	RayLeft.set_collision_mask_value(get_parent().get_tileset().get_physics_layer_collision_layer(0),true)
	RayRight.set_collision_mask_value(get_parent().get_tileset().get_physics_layer_collision_layer(0),true)
	RayDown.set_collision_mask_value(get_parent().get_tileset().get_physics_layer_collision_layer(0),true)
	hurtArea.set_collision_mask_value(get_parent().get_tileset().get_physics_layer_collision_layer(0),true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if position.y > LEVEL_LIMIT:
		queue_free()
	#$Label.text = "HP: " + str(int(HEALTH))
	if HEALTH > 0:
		if AWARENESS <= 0:
			attacking = true
		elif abs(position.x - player.position.x) <= AWARENESS:
			if attackTimer > 0.0:
				attackTimer -= delta
			elif sprite.animation == "Idle":
				sprite.play("AttackStart")
		if animfinished:
			if sprite.animation == "AttackStart":
				sprite.play("Attack")
				attacking = true
			elif sprite.animation == "Attack":
				sprite.play("AttackEnd")
				attacking = false
			elif sprite.animation == "AttackEnd":
				sprite.play("Idle")
				attackTimer = RELOADTIMER
			else:
				sprite.play("Idle")
			animfinished = false
		
		if attackTimer > 0:
			attackTimer -= delta
		if invitimer > 0:
			invitimer -= delta
		
		position.x += direction * delta * xSpeed
		
		if KNOCKABLE:
			if not knockedBack:
				if sprite.animation == "Hurt":
					sprite.play("Walk")
			else:
				sprite.play("Hurt")
		if sprite.animation != "Hurt":
			xSpeed = SPEED
			if RayLeft.is_colliding() and RayLeft.get_collider() != player:
				direction = 1
			elif RayRight.is_colliding() and RayRight.get_collider() != player:
				direction = -1
		if RayDown.is_colliding() and RayDown.get_collider() != player:
			if sprite.animation == "Hurt" and sprite.frame > 0 and KNOCKABLE:
				knockedBack = false
			if ySpeed >= 0:
				ySpeed = 0
		else:
			ySpeed += 10
			
		
		if direction > 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
			
		
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
		xSpeed = playerPos * strength
		ySpeed = -25 * strength

func _on_animated_sprite_2d_animation_finished() -> void:
	animfinished = true
