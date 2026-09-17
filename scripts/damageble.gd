extends CharacterBody2D
class_name Damageable

var hits := 5
var tweens := 3

func _ready() -> void:
	pass 

func _process(_delta: float) -> void:
	pass

func damage():
	var tween = create_tween()
	for i in range(tweens):
		tween.tween_property(self, "modulate", Color(4, 4, 4), 0.02)
		tween.tween_property(self, "modulate", Color.WHITE, 0.1)
	hits -= 1
