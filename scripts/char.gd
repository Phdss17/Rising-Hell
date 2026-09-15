extends CharacterBody2D

#movimentacao
const SPEED = 10000.0
var lR: float
var uD: float
var moves: Vector2

#atirar
@onready var gun = $gun

#efeitos
@onready var sprite = $AnimatedSprite2D
@onready var passo = $passo
@onready var pivot = $pivot
const gunDis := 12

func _physics_process(delta: float) -> void:
	getMoves()
	move(delta)
	
	var mouse = pivot.global_position.direction_to(get_global_mouse_position())
	gun.global_position = pivot.global_position + mouse * gunDis
	gun.show_behind_parent = mouse.y < 0
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
func getMoves():
	lR = Input.get_axis("left", "right")
	uD = Input.get_axis("up", "down")
	
func move(delta):
	moves = Vector2(lR, uD).normalized()
	if moves:
		velocity = moves * SPEED * delta
		if moves.x < 0:
			sprite.flip_h = true
			sprite.offset = Vector2(-1, -3)
		else:
			sprite.offset = Vector2(1, -3)
			sprite.flip_h = false
		sprite.play("running")
		if not passo.playing:
			passo.play()
	else:
		sprite.play("idle")
		velocity = Vector2.ZERO
	move_and_slide()
		
