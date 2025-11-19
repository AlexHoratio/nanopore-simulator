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

func _ready():
	next_nucleotide()
	
func _process(delta):
	pass
	
func set_next_nucleotide(base) -> void:
	$backbone/next.texture = base_textures[base]
	$backbone/next.position = base_px_offsets[base] + Vector2(811, 0)
		
func next_nucleotide():
	current_base = Genome.pop_next_base()
	set_next_nucleotide(current_base)
	
	if $AnimationPlayer.is_playing():
		$AnimationPlayer.stop()
	
	$AnimationPlayer.play("next_nucleotide")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "next_nucleotide":
		$backbone.position.x = -465.0
		
		$backbone/current.texture = $backbone/next.texture
		$backbone/current.position = $backbone/next.position - Vector2(811, 0)
		$backbone/next.texture = null
		
		
