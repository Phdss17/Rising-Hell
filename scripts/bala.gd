extends Area2D

var speed = 250
var direction: Vector2
@onready var borked = $break
var shouldMove = true
@onready var impact 

func _ready() -> void:
	impact = get_tree().get_nodes_in_group("gun")[0].get_child(-1)

func _process(delta: float) -> void:
	if shouldMove:
		position += direction * speed * delta
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()

func setDirection(dir: Vector2):
	direction = dir.normalized()

func _on_body_entered(body: Node2D) -> void:
	shouldMove = false 
	if body is TileMapLayer:
		impact.play()
	borked.play("hiddet")
	await borked.animation_finished
	queue_free()
