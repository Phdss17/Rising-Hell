extends CharacterBody2D

var hits = 35
@onready var hit = $hit
@onready var fala = $fala
@onready var sprite = $AnimatedSprite2D
@onready var hitbox = $Area2D
@onready var vitoria = $vitoria
@onready var tentacles := [$tentacle, $tentacle2, $tentacle3, $tentacle4]

var shake := 0
const maxShake := 8
var cooldown := 0.0

func _physics_process(delta: float) -> void:
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
	
func receiveDamage():
	if hits > 0:
		hits -= 1
		sounds()
		var tween = create_tween()
		tween.tween_property(sprite, "modulate", Color(4, 4, 4), 0.05)
		tween.tween_property(sprite, "modulate", Color.WHITE, 0.1)
		shake = maxShake
	else:
		sprite.play("dead")
		for tentacle in tentacles:
			tentacle.stop()
		hitbox.queue_free()
		vitoria.play()
		await vitoria.finished
		get_tree().quit()
	
func sounds():
	var bi = randi() % 4
	if bi == 0:
		fala.play()
	else:
		hit.play()

func _on_area_2d_area_shape_entered(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if cooldown <= 0:
		cooldown = 0.3
		receiveDamage()
	
