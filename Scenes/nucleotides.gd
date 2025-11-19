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

var current_base = null
var speed_sequence = 0
var speed_sequence_rate = 0
var speed_sequence_timer = 0

var nuc_range = 14
var nuc_spacing = 160

func _ready():
	spawn_starting_nucleotides()
	
func _process(delta):
	#enter_nucleotide(current_base.nucleotide_type)
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
			
	current_base = get_child(floor(nuc_range/2.0))
	
	if get_child_count() > nuc_range:
		get_child(0).queue_free()
	
func organize_nucleotides(delta: float) -> void:
	#position.x = get_viewport_rect().size.x/2.0
	
	for nucleotide in get_children():
		var x = get_viewport_rect().size.x/2.0 + nucleotide.get_index()*nuc_spacing - get_child_count()*(nuc_spacing/2.0) 
		nucleotide.position = lerp(nucleotide.position, Vector2(x, 140), 10*delta)
			
		nucleotide.modulate.a = lerp(nucleotide.modulate.a, 0.7 if nucleotide != current_base else 1.0, 0.2)
		
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
	var nucleotide = load("res://Prefabs/nucleotide_letter.tscn").instantiate()
	nucleotide.position = Vector2(get_viewport_rect().size.x/(scale.x) + 4*811, 60)
	nucleotide.nucleotide_type = Genome.pop_next_base()
	add_child(nucleotide)
	
func spawn_last_nucleotide() -> void:
	var nucleotide = load("res://Prefabs/nucleotide_letter.tscn").instantiate()
	nucleotide.position = Vector2(get_viewport_rect().size.x/(scale.x) - 4*811, 60)
	nucleotide.nucleotide_type = Genome.genome_data[max(0, Genome.current_place - nuc_range)]
	add_child(nucleotide)
	move_child(nucleotide, 0)
	
func spawn_starting_nucleotides() -> void:
	for i in range(nuc_range):
		var nucleotide = load("res://Prefabs/nucleotide_letter.tscn").instantiate()
		nucleotide.position = Vector2(DisplayServer.window_get_size().x/(scale.x) + 4*811, 60)
		nucleotide.nucleotide_type = Genome.genome_data[max(0, (int(Genome.current_place) % 8000) - (nuc_range - i))]
		add_child(nucleotide)

func enter_nucleotide(base: String) -> void:
	if base == current_base.nucleotide_type:
		current_base.modulate = Color.GREEN
		Input.vibrate_handheld(50)
		
		var explosion_effect = load("res://Prefabs/explosion.tscn").instantiate()
		explosion_effect.global_position = current_base.global_position + Vector2(randf()*200, 0).rotated(2*randf()*PI)
		explosion_effect.base = current_base.nucleotide_type
		get_node("../fx").add_child(explosion_effect)
		
		
	else:
		current_base.modulate = Color.RED
		Input.vibrate_handheld(200)
		
	next_nucleotide()
