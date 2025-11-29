extends CharacterBody2D

var jumped = 0
var moved = 0
var t = 0.0
var startingposition:Vector2


func _physics_process(delta: float) -> void:
	if not is_on_floor() and jumped == 0:
		jumped = 3
	if jumped != 1 and jumped != 3 and moved == 0:
		if Input.is_action_just_pressed("ui_up") and is_on_floor() and jumped == 0:
			jumped = 1
			t = 0.0
			startingposition = position
		if Input.is_action_just_pressed("ui_left"):
			moved = -1
			t = 0.0
			startingposition = position
			$AnimatedSprite2D.flip_h = true
			if jumped == 2:
				jumped = 3
		if Input.is_action_just_pressed("ui_right"):
			moved = 1
			t = 0.0
			startingposition = position
			$AnimatedSprite2D.flip_h = false
			if jumped == 2:
				jumped = 3
	elif jumped == 1:
		t += delta * 4
		position = startingposition.lerp(startingposition + Vector2.UP*32,t)
		if t >= 1:
			jumped = 2
	elif jumped == 3 and moved == 0:
		t += delta * 4
		position = startingposition.lerp(startingposition + Vector2.DOWN*32,t)
		if t >= 1:
			jumped = 0
	if moved != 0:
		t += delta * 4
		position = startingposition.lerp(startingposition + Vector2.RIGHT*32*moved,t)
		if t >= 1:
			moved = 0
			startingposition = position
			t = 0.0

	move_and_slide()
