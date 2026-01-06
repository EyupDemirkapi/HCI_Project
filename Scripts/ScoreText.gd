extends Label

@onready var score = $/root/Game/Modulate/Player.SCORE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score = $/root/Game/Modulate/Player.SCORE
	text = "Score: "+str(score)
