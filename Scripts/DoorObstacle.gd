extends RigidBody2D


@onready var player = $/root/Game/Modulate/Player
@onready var area = $Area2D

func _ready() -> void:
	set_collision_layer_value(get_parent().get_tileset().get_physics_layer_collision_layer(0),true)
	set_collision_mask_value(get_parent().get_tileset().get_physics_layer_collision_layer(0),true)
	area.set_collision_layer_value(get_parent().get_tileset().get_physics_layer_collision_layer(0),true)
	area.set_collision_mask_value(get_parent().get_tileset().get_physics_layer_collision_layer(0),true)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player and player.KEYS > 0 and $AnimatedSprite2D.animation == "Idle":
		$AnimatedSprite2D.play("Open")
		set_collision_layer_value(get_parent().get_tileset().get_physics_layer_collision_layer(0),false)
		set_collision_mask_value(get_parent().get_tileset().get_physics_layer_collision_layer(0),false)
		area.set_collision_layer_value(get_parent().get_tileset().get_physics_layer_collision_layer(0),false)
		area.set_collision_mask_value(get_parent().get_tileset().get_physics_layer_collision_layer(0),false)
		player.KEYS -= 1
