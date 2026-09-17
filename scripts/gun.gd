extends Node2D

@onready var player 
const bala = preload("res://entities/bala.tscn")
@onready var pivot := $pivot
@onready var thoos = $AnimatedSprite2D
@onready var sound = $bala

var ultimaBala: float = 0
var direction

func _ready() -> void:
	player = get_parent()

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
	
	if Input.is_action_just_pressed("shoot") and can_Shoot():
		shoot()
		thoos.play("shooting")
		sound.play()
		await thoos.animation_finished
		thoos.play("default")
		
func shoot():
	ultimaBala = Time.get_unix_time_from_system()
	var nBala = bala.instantiate()
	nBala.global_position = pivot.global_position
	var dir = (get_global_mouse_position() - pivot.global_position).normalized()
	nBala.setDirection(dir)
	nBala.rotation = dir.angle() + deg_to_rad(90) 
	get_tree().root.add_child(nBala)
	
func can_Shoot() -> bool:
	var tempoAtual = Time.get_unix_time_from_system()
	if ultimaBala + 0.4 <= tempoAtual or ultimaBala == 0:
		return true
	else:
		return false
