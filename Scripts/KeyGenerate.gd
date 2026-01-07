extends Node

var startPos = Vector2(19,46)
var generatedKeys = []

func generateKeys(keys:int) -> void:
	for i in generatedKeys:
		get_parent().remove_child(i)
	generatedKeys.clear()
	for i in range(keys-1,-1,-1):
		var key = load("res://Scenes/UIKey.tscn").instantiate()
		generatedKeys.append(key)
		key.position = startPos + Vector2(i*16,0)
		get_parent().add_child(key)
