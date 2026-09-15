extends ProgressBar

var boss
var bossLife = 35
var decreaseSpeed = 5

func _ready() -> void:
	boss = get_tree().get_nodes_in_group("boss")[0]

func _process(delta: float) -> void:
	if boss.hits != bossLife:
		bossLife = boss.hits
	
	value = move_toward(value, bossLife, delta * decreaseSpeed)
