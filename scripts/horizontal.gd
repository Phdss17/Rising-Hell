extends Area2D

const speed := 220
const distance := 400
var inicialX : float
var reache := false
var dir: int
var shouldMove := false

func _ready() -> void:
	inicialX = position.x

func _process(delta: float) -> void:
	reached()
	if shouldMove:
		if not reache:
			position.x = move_toward(position.x, inicialX + (distance * dir), delta * speed)
		else:
			queue_free()
	
func reached() -> void:
	if position.x == inicialX + (distance * dir):
		reache = true
