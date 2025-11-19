extends Control

@export var nucleotide_type = "X"

var base_px_offsets = {
	"A": Vector2(157, 696),
	"T": Vector2(296, 617),
	"C": Vector2(238, 592),
	"G": Vector2(267, 760),
	"X": Vector2(0, 0),
}

func _ready():
	set_base(nucleotide_type)

func _process(delta):
	pass

func set_base(letter) -> void:
	$base.play(letter)
	$base.position = base_px_offsets[letter]
