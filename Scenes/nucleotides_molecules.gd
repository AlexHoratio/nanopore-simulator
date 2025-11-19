extends Control

var base_textures = {
	"A": preload("res://Graphics/adenine.png"),
	"T": preload("res://Graphics/thymine.png"),
	"C": preload("res://Graphics/cytosine.png"),
	"G": preload("res://Graphics/guanine.png"),
}

var base_px_offsets = { # backbone/current
	"A": Vector2(1037, 637),
	"T": Vector2(1151, 572),
	"C": Vector2(1104, 553),
	"G": Vector2(1125, 687),
}

var current_base = "X"
var speed_sequence = 0
var speed_sequence_rate = 0
var speed_sequence_timer = 0

var nuc_range = 15

func _ready():
	pass
	#spawn_starting_nucleotides()
	
func _process(delta):
	#if get_children().size() < 5:
		#var nucleotide = load("res://Prefabs/nucleotide.tscn").instantiate()
		#nucleotide.position = Vector2(747, 60)
		#add_child(nucleotide)
		#
	organize_nucleotides(delta)
	speed_sequence_rate = 0.03
	if speed_sequence > 0:
		speed_sequence_timer += delta
		if speed_sequence_timer > speed_sequence_rate:
			speed_sequence_timer = 0
			speed_sequence -= 1
			next_nucleotide()
			
	current_base = get_child(floor(nuc_range/2.0)).nucleotide_type
	
	if get_child_count() > nuc_range:
		get_child(0).queue_free()
	
func organize_nucleotides(delta: float) -> void:
	position.x = 50 + get_viewport_rect().size.x/2.0
	
	for nucleotide in get_children():
		var x = -(get_child_count())*(811.0/2.0) + nucleotide.get_index()*811.0
		nucleotide.position = lerp(nucleotide.position, Vector2(x, 60), 10*delta)
			
		nucleotide.modulate.a = lerp(nucleotide.modulate.a, 0.2 if nucleotide.get_index() < 2 else 1.0, 10*delta)
		
func next_nucleotide() -> void:
	get_child(0).queue_free()
	
	spawn_new_nucleotide()
	
	Genome.save_progress()
	
func previous_nucleotide() -> void:
	get_child(nuc_range - 1).queue_free()
	
	spawn_last_nucleotide()
	
	Genome.current_place -= 1
	Genome.save_progress()
	
func spawn_new_nucleotide() -> void:
	var nucleotide = load("res://Prefabs/nucleotide.tscn").instantiate()
	nucleotide.position = Vector2(get_viewport_rect().size.x/(scale.x) + 4*811, 60)
	nucleotide.nucleotide_type = Genome.pop_next_base()
	add_child(nucleotide)
	
func spawn_last_nucleotide() -> void:
	var nucleotide = load("res://Prefabs/nucleotide.tscn").instantiate()
	nucleotide.position = Vector2(get_viewport_rect().size.x/(scale.x) - 4*811, 60)
	nucleotide.nucleotide_type = Genome.genome_data[max(0, Genome.current_place - nuc_range)]
	add_child(nucleotide)
	move_child(nucleotide, 0)
	
func spawn_starting_nucleotides() -> void:
	for i in range(nuc_range):
		var nucleotide = load("res://Prefabs/nucleotide.tscn").instantiate()
		nucleotide.position = Vector2(DisplayServer.window_get_size().x/(scale.x) + 4*811, 60)
		nucleotide.nucleotide_type = Genome.genome_data[max(0, Genome.current_place - (nuc_range - i))]
		add_child(nucleotide)
