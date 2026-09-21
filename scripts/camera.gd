extends Camera2D

var player: CharacterBody2D
var pHits: int
var i: int
@onready var lifes := [$canvasLayer/control/container/HBoxContainer/lifeP1,
$canvasLayer/control/container/HBoxContainer/lifeP2, 
$canvasLayer/control/container/HBoxContainer/lifeP3,
$canvasLayer/control/container/HBoxContainer/lifeP4,
$canvasLayer/control/container/HBoxContainer/lifeP5]
var reached: bool

const speed := 250
const ROOM_TRANSITION_Y := 272.0

func _ready() -> void:
	player = get_tree().get_nodes_in_group("player")[0]
	pHits = player.hits
	i = pHits-1

func _process(delta: float) -> void:
	if position.y < ROOM_TRANSITION_Y:
		reached = true
		position.y = move_toward(position.y, 0, delta * speed)

	if not reached:
		position = player.position
	else:
		position.x = move_toward(position.x, player.position.x, delta * speed) 

	if pHits != player.hits and i >= 0:
		lifes[i].texture.current_frame = 1
		i -= 1
		pHits = player.hits
