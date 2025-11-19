extends Control

func _ready():
	pass
	
func _process(delta):
	pass

func nucleotide_entered(base) -> void:
	#get_node("../stats").base_entered(base)
	get_node("../nucleotides").enter_nucleotide(base)
	
	#if base == get_node("../nucleotides").current_base:
		#get_node("../nucleotides").next_nucleotide()
	#else:
		#get_node("../nucleotides").previous_nucleotide()

func _on_a_pressed():
	nucleotide_entered("A")

func _on_t_pressed():
	nucleotide_entered("T")

func _on_c_pressed():
	nucleotide_entered("C")

func _on_g_pressed():
	nucleotide_entered("G")
