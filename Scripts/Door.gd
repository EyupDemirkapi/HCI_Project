extends StaticBody2D


@onready var exterior = $/root/Game/ExteriorTileMap
@onready var interior = $/root/Game/InteriorTileMap
@onready var player = $/root/Game/Player
@onready var sprite = $AnimatedSprite2D


func _physics_process(delta:float) -> void:
	#iceri disari cikma
	if sprite.animation == "anim":
		if sprite.frame < 4:
			$/root/Game/Player/AnimatedSprite2D.scale *= 0.9
		elif sprite.frame < 8:
			$/root/Game/Player/AnimatedSprite2D.scale /= 0.9
		else:
			$/root/Game/Player/AnimatedSprite2D.scale = Vector2.ONE #nolur nolmaz
			exterior.visible = not exterior.visible
			interior.visible = not interior.visible
			player.set_collision_layer_value(1, not player.get_collision_layer_value(1))
			player.set_collision_layer_value(2, not player.get_collision_layer_value(2))
			player.set_collision_mask_value(1, not player.get_collision_mask_value(1))
			player.set_collision_mask_value(2, not player.get_collision_mask_value(2))
			sprite.play("idle")
	if Input.is_action_just_pressed("GroundSwap") and $Area2D.overlaps_body(player):
		sprite.play("anim")
