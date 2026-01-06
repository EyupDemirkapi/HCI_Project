extends Area2D

var isAttackable = false
@onready var player = $/root/Game/Modulate/Player
@onready var heartGenerator = $/root/Game/Camera2D/UI/TopLeft/HeartUIGenerator

func _physics_process(delta: float) -> void:
	if get_parent().HEALTH > 0 and isAttackable:
		if not get_parent().BYPASSES_INVIS and (player.sprite.animation == "AttackStart" or player.sprite.animation == "AttackLoop" or player.sprite.animation == "AttackEnd"):
			if get_parent().invitimer <= 0:
				player.SCORE += 50
				get_parent().HEALTH -= player.STRENGTH
				get_parent().invitimer = get_parent().INVI_DURATION
				get_parent().knockback(player.position.x-get_parent().position.x,10.0/get_parent().MASS)
		elif get_parent().IS_ENEMY:
			if player.invitimer <= 0 and get_parent().attacking:
				player.SCORE -= 50
				player.HEALTH -= get_parent().STRENGTH
				heartGenerator.generateHearts(player.HEALTH)
				player.knockback(player.position.x-get_parent().position.x,10.0*get_parent().STRENGTH)
				player.invitimer = player.INVI_DURATION
		else:
			if player.invitimer <= 0:
				player.SCORE -= 50
				player.HEALTH -= get_parent().STRENGTH
				heartGenerator.generateHearts(player.HEALTH)
				player.knockback(player.position.x-get_parent().position.x,10.0*get_parent().STRENGTH)
				player.invitimer = player.INVI_DURATION

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		isAttackable = true

func _on_body_exited(body: Node2D) -> void:
	if body == player:
		isAttackable = false
