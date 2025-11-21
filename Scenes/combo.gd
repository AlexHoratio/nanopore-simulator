extends Control

var timer_max = 5
var time_val = 5

var current_combo = 0

func _ready():
	pass
	
func _process(delta):
	time_val -= delta
	
	if time_val <= 0:
		current_combo = 0
		timer_max = 5
		time_val = 0
	
	$time_bar.max_value = timer_max
	$time_bar.value = time_val
	$read_length.text = str(int(current_combo)) + " b.p."
	
func add_to_combo() -> void:
	timer_max = 5 * pow(0.99, current_combo)
	time_val = timer_max
	
	current_combo += 1
