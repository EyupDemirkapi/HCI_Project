extends TileMap

var isPlayerInLight = false
var lightTimer = 0.0
@onready var player = $/root/Game/Modulate/Player
@onready var moon = $/root/Game/Camera2D/Moon
@onready var sun = $/root/Game/Camera2D/Sun

func _physics_process(delta: float) -> void:
	#$/root/Game/Label.text = "Light Timer: {0}, Is Player In: {1}".format([str(lightTimer),str(isPlayerIn)])
	if (not player.isInNoLightArea) and isPlayerInLight and player.HEALTH > 0 and sun.position.y < moon.position.y:
		lightTimer -= delta
		if lightTimer <= 0:
			player.HEALTH -= 1
			player.knockback(0,3.5)
			lightTimer = 120.0/-sun.position.y

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		isPlayerInLight = true
		lightTimer = 120.0/-sun.position.y
func _on_body_exited(body: Node2D) -> void:
	if body == player:
		isPlayerInLight = false
		lightTimer = 0.0
