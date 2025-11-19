extends Control

func _ready():
	pass
	
func _process(delta):
	if randf() < 0.0005:
		var star = load("res://Prefabs/star.tscn").instantiate()
		star.position = Vector2(100 + (get_viewport_rect().size.x - 200)*randf(), randf()*get_viewport_rect().size.y * 0.3 + 100)
		star.pop.connect(star_popped)
		add_child(star)

func star_popped() -> void:
	get_node("../nucleotides").speed_sequence += 75
