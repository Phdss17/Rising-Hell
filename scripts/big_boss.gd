extends CharacterBody2D

var hits = 1
@onready var hit = $hit
@onready var fala = $fala
@onready var hitbox = $Area2D
@onready var vitoria = $vitoria

@onready var tentacles
@onready var eye: Node2D 
var palpebra: AnimatedSprite2D
var pupila: Sprite2D
@onready var pivot: Marker2D
var player: CharacterBody2D

var shake := 0
const maxShake := 8
var cooldown := 0.0
var pupilDis = 15

var isDead := false

func _ready() -> void:
	player = get_tree().get_nodes_in_group("player")[0]
	tentacles = get_child(1).get_children()
	eye = get_tree().get_nodes_in_group("eye")[0]
	palpebra = eye.get_child(2)
	pupila = eye.get_child(1)
	pivot = eye.get_child(-1)

func _physics_process(delta: float) -> void:
	lookAtYou()
	cooldown -= delta
	if shake > 0:
		if shake >= 1 and shake <= 2:
			position += Vector2(2, -0.5)
		elif shake >= 2 and shake <= 4:
			position -= Vector2(2, -0.5)
		elif shake >= 4 and shake <= 6:
			position += Vector2(2, 0.5)
		elif shake >= 6 and shake <= 8:
			position -= Vector2(2, 0.5)
		shake -= 1
	
func receiveDamage() -> void:
	if hits > 0:
		hits -= 1
		sounds()
		var tween = create_tween()
		tween.tween_property(eye, "modulate", Color(4, 4, 4), 0.05)
		tween.tween_property(eye, "modulate", Color.WHITE, 0.1)
		shake = maxShake
	else:
		isDead = true
		palpebra.play("die")
		for tentacle in tentacles:
			tentacle.stop()
		hitbox.queue_free()
		vitoria.play()
		await vitoria.finished
	
func sounds() -> void:
	var bi = randi() % 4
	if bi == 0:
		fala.play()
	else:
		hit.play()

func _on_area_2d_area_shape_entered(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if cooldown <= 0:
		cooldown = 0.0
		receiveDamage()

func _on_timer_timeout() -> void:
	if !isDead:
		palpebra.play("blinking")
		await palpebra.animation_finished
		palpebra.play("idle")

func lookAtYou() -> void:
	if !isDead:
		var player = pivot.global_position.direction_to(player.position)
		pupila.global_position = pivot.global_position + player * pupilDis
	
