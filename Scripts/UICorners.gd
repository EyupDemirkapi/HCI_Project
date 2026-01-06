extends Node2D

var topleft:Vector2
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	topleft = get_viewport_rect().position - get_viewport_rect().size
	for ch in get_children():
		if ch.name == "TopLeft":
			ch.position = topleft/(get_parent().zoom*2)
		if ch.name == "TopRight":
			ch.position = (topleft + Vector2(get_viewport_rect().size.x*2,0))/(get_parent().zoom*2)
		if ch.name == "BottomLeft":
			ch.position = (topleft + Vector2(0,get_viewport_rect().size.y*2))/(get_parent().zoom*2)
		if ch.name == "BottomRight":
			ch.position = (topleft + get_viewport_rect().size)/(get_parent().zoom*2)
