extends Area2D

const speed := 200
const distance := 400
var inicialX : float
var reache := false

func _ready() -> void:
	inicialX = position.x

func _process(delta: float) -> void:
	reached()
	if not reache:
		position.x = move_toward(position.x, inicialX - distance, delta * speed)
	else:
		queue_free()
	
func reached():
	if position.x <= (inicialX - distance):
		reache = true
