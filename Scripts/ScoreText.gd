extends Label

@onready var score = $/root/Game/Modulate/Player.SCORE
var lerpscore:int
func _ready() -> void:
	lerpscore = score
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score = $/root/Game/Modulate/Player.SCORE
	if lerpscore != score and score >= 0:
		if lerpscore < score:
			lerpscore += 1
		else:
			lerpscore -= 1
	text = "Score: "+str(lerpscore)
