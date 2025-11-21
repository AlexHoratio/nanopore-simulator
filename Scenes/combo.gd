extends Control

var timer_max = 5
var time_val = 5

var current_combo = 0

var label_shake = 0
var label_max_shake = 25
var label_start_position = Vector2(0, 0)

func _ready():
	label_start_position = $read_length.position
	
func _process(delta):
	time_val -= delta
	
	if time_val <= 0:
		
		if current_combo > 0:
			var read_completed = load("res://Prefabs/read_completed.tscn").instantiate()
			read_completed.position = Vector2(200 + (randf() * (get_viewport_rect().size.x - 400)), get_viewport_rect().size.y + 20)
			read_completed.read_length = current_combo
			get_parent().get_parent().add_child(read_completed)
			
		current_combo = 0
		timer_max = 5
		time_val = 0
	
	$time_bar.max_value = timer_max
	$time_bar.value = time_val
	$time_bar.tint_progress = lerp(Color.RED, Color.GREEN, time_val / timer_max)
	$read_length.text = str(int(current_combo)) + " b.p."
	
	label_shake = clamp(label_shake - delta*5, 0, 1)
	
	$read_length.position = label_start_position + Vector2(randf()*2 - 1, randf()*2 - 1) * label_max_shake * label_shake * label_shake
	
func add_to_combo() -> void:
	timer_max = 5 * pow(0.99, current_combo)
	time_val = timer_max
	
	current_combo += 1
	
	label_max_shake = 25 - 25 * pow(0.99, current_combo)
	label_shake += 1
