extends Control

@onready var buttonStart := $VBoxContainer/start
@onready var buttonQuit := $VBoxContainer/quit

func _ready() -> void:
	pass 

func _process(_delta: float) -> void:
	var tweenS = create_tween()
	if buttonStart.is_hovered():
		tweenS.tween_property(buttonStart, "modulate", Color(0.7, 0.7, 0.7), 0.02)
		tweenS.tween_property(buttonStart, "scale", Vector2(1.1, 1.1), 0.02)
	else:
		tweenS.tween_property(buttonStart, "modulate", Color.WHITE, 0.1)
		tweenS.tween_property(buttonStart, "scale", Vector2(1, 1), 0.1)
		
	var tweenQ = create_tween()	
	if buttonQuit.is_hovered():
		tweenQ.tween_property(buttonQuit, "modulate", Color(0.7, 0.7, 0.7), 0.02)
		tweenQ.tween_property(buttonQuit, "scale",  Vector2(1.1, 1.1), 0.02)
	else:
		tweenQ.tween_property(buttonQuit, "modulate", Color.WHITE, 0.02)
		tweenQ.tween_property(buttonQuit, "scale", Vector2(1, 1), 0.1)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/room.tscn")

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
