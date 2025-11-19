extends Panel

var time = 0
var bases_entered = 0
var read_length = 0

func _ready():
	pass
	
func _process(delta):
	time += delta
	
	$bases_per_second.text = "Bases per second: " + str(snapped(bases_entered/time, 0.01))
	$longest_read.text = "Read length: " + str(read_length)
	
func base_entered(base) -> void:
	bases_entered += 1
	
	if base == get_node("../nucleotides").current_base:
		read_length += 1
	else:
		read_length = 0
