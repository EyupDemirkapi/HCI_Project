extends Node

@onready var maxhealth = $/root/Game/Modulate/Player/Stats.MAX_HEALTH
var startPos = Vector2(19,19)
var generatedHearts = []

func _ready() -> void:
	initialGenerate()

func initialGenerate() -> void:
	for i in range(maxhealth-1,-1,-1):
		var heart = load("res://Scenes/UIHeart.tscn").instantiate()
		generatedHearts.append(heart)
		heart.position = startPos + Vector2(i*16,0)
		heart.play("Full")
		get_parent().add_child.call_deferred(heart)

func generateHearts(health:int) -> void:
	maxhealth = $/root/Game/Modulate/Player.MAX_HEALTH
	if health < 0:
		health = 0
	for i in generatedHearts:
		get_parent().remove_child(i)
	generatedHearts.clear()
	for i in range(maxhealth-1,-1,-1):
		var heart = load("res://Scenes/UIHeart.tscn").instantiate()
		generatedHearts.append(heart)
		heart.position = startPos + Vector2(i*16,0)
		if i > health-1:
			heart.play("Empty")
		else:
			heart.play("Full")
		get_parent().add_child(heart)
