extends CharacterBody2D

var walkfinished = true
var jumpfinished = true
#var onDoor = false
var onDoor = true

func _physics_process(delta: float) -> void:
	#iceri disari cikma
	if Input.is_action_just_pressed("GroundSwap") and onDoor:
		set_collision_layer_value(1, not get_collision_layer_value(1))
		set_collision_layer_value(2, not get_collision_layer_value(2))
		set_collision_mask_value(1, not get_collision_mask_value(1))
		set_collision_mask_value(2, not get_collision_mask_value(2))
		$/root/game/ExteriorTileMap.visible = not $/root/game/ExteriorTileMap.visible
		$/root/game/InteriorTileMap.visible = not $/root/game/InteriorTileMap.visible
	
	#hareket
	if is_on_floor():
		if $AnimatedSprite2D.animation == "jump":
			$AnimatedSprite2D.play("land")
		velocity.y = 0
		if Input.is_action_just_pressed("Jump"):
			jumpfinished = false
			$AnimatedSprite2D.play("jumpstart")
			velocity.y-=300
	else:
		velocity.y += 10
	if Input.is_action_pressed("MoveLeft") and abs(velocity.x) < 225:
		if jumpfinished:
			$AnimatedSprite2D.play("walk")
		walkfinished = false
		$AnimatedSprite2D.flip_h = true
		velocity.x=-225
	elif Input.is_action_pressed("MoveRight") and abs(velocity.x) < 225:
		if jumpfinished:
			$AnimatedSprite2D.play("walk")
		walkfinished = false
		$AnimatedSprite2D.flip_h = false
		velocity.x=225
	else:
		if abs(velocity.x) > 1:
			velocity.x /= 1.25
		else:
			velocity.x=0
	#animasyon
	if walkfinished and jumpfinished:
		$AnimatedSprite2D.play("idle")
	if $AnimatedSprite2D.animation == "walk" and $AnimatedSprite2D.frame >= 6:
		walkfinished = true
	if $AnimatedSprite2D.animation == "land" and $AnimatedSprite2D.frame >= 4:
		jumpfinished = true
		$AnimatedSprite2D.play("idle")
	if $AnimatedSprite2D.animation == "jumpstart" and $AnimatedSprite2D.frame >= 4:
			$AnimatedSprite2D.play("jump")
	move_and_slide()
