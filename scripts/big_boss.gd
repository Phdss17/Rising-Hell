extends Damageable

var player: CharacterBody2D

@onready var hit = $hit
@onready var fala = $fala
@onready var hitbox = $Area2D
@onready var vitoria = $vitoria

@onready var tentacles
@onready var eye: Node2D 
var palpebra: AnimatedSprite2D
var pupila: Sprite2D
@onready var pivot: Marker2D

var shaking := 0
const maxShake := 8
var cooldown := 0.0
var pupilDis = 15

var isDead := false
@onready var life : TextureProgressBar

const horAttack := preload("res://entities/horizontalAttack.tscn")
const attackDisY := 60
const attackX := 442
const numberAttacks := 3

func _ready() -> void:
	life = get_tree().get_nodes_in_group("lifeBar")[0]
	life.visible = false
	hits = 35
	tweens = 1
	player = get_tree().get_nodes_in_group("player")[0]
	tentacles = get_child(1).get_children()
	eye = get_tree().get_nodes_in_group("eye")[0]
	palpebra = eye.get_child(2)
	pupila = eye.get_child(1)
	pivot = eye.get_child(-1)

func _physics_process(delta: float) -> void:
	lookAtYou()
	cooldown -= delta
	shake()
	
func receiveDamage() -> void:
	if hits > 0:
		damage()
		sounds()
		shaking = maxShake
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
		cooldown = 0.3
		receiveDamage()

func _on_timer_timeout() -> void:
	if !isDead:
		palpebra.play("blinking")
		await palpebra.animation_finished
		palpebra.play("idle")
		attack()

func lookAtYou() -> void:
	if !isDead:
		var playerPos = pivot.global_position.direction_to(player.position)
		pupila.global_position = pivot.global_position + playerPos * pupilDis
	
func shake():
	if shaking > 0:
		if shaking >= 1 and shaking <= 2:
			position += Vector2(2, -0.5)
		elif shaking >= 2 and shaking <= 4:
			position -= Vector2(2, -0.5)
		elif shaking >= 4 and shaking <= 6:
			position += Vector2(2, 0.5)
		elif shaking >= 6 and shaking <= 8:
			position -= Vector2(2, 0.5)
		shaking -= 1
		
func attack():
	var i := player.global_position.y
	for n in range(numberAttacks):
		var hor = horAttack.instantiate()
		hor.global_position = Vector2(attackX, i) 
		get_tree().root.add_child(hor)
		i -= attackDisY


func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	life.visible = true
