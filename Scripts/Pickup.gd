extends AnimatedSprite2D

@onready var HEALTH_UP = $Stats.HEALTH_UP
@onready var MAX_HEALTH_UP = $Stats.MAX_HEALTH_UP
@onready var STRENGTH_UP = $Stats.STRENGTH_UP
@onready var SCORE_UP = $Stats.SCORE_UP

@onready var player = $/root/Game/Modulate/Player
@onready var heartGenerator = $/root/Game/Camera2D/UI/HeartUIGenerator

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		player.HEALTH += HEALTH_UP
		player.MAX_HEALTH += MAX_HEALTH_UP
		if player.HEALTH > player.MAX_HEALTH:
			player.HEALTH = player.MAX_HEALTH
		if HEALTH_UP > 0 or MAX_HEALTH_UP > 0:
			heartGenerator.generateHearts(player.HEALTH)
		player.STRENGTH += STRENGTH_UP
		#player.SCORE += SCORE_UP
		
		queue_free()
