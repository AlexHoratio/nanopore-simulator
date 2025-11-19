extends Node

var save_data = ConfigFile.new()

var genome_data = """"""

var current_place = 0

var annotations_data = []
var gene_annotation = {
	"name": "unknown madness",
	"symbol": "???",
	"begin": 0,
	"next": 190,
}

func _ready():
	annotations_data = preload("res://Resources/ecoli_gene_annotations.csv").records
	load_progress()
	
	calculate_annotation()
	
func _process(delta):
	pass
	
func load_progress() -> void:
	load_genome_file()
	
	save_data.load("user://save_data.cfg")
	current_place = save_data.get_value("Progress", "current_place", 0)
	
func save_progress() -> void:
	save_data.set_value("Progress", "current_place", current_place)
	save_data.save("user://save_data.cfg")
	
func load_genome_file() -> void:
	var base_minimum = floor(current_place/80.0)*100
	var file = FileAccess.open("res://Resources/ecoli/" + str(int(base_minimum)) + "_" + str(int(base_minimum) + 100) + ".txt", FileAccess.READ)
	genome_data = file.get_as_text()

func calculate_annotation() -> void:
	var record_index = 0
	
	while current_place > int(annotations_data[record_index][1]):
		record_index += 1
		
	if int(annotations_data[record_index][0]) > current_place:
		gene_annotation["name"] = "MADNESS!!!!"
		gene_annotation["symbol"] = "???"
		gene_annotation["next"] = int(annotations_data[record_index][0])
		gene_annotation["begin"] = (int(annotations_data[record_index - 1][1])) if record_index >= 1 else 0
	else:
		gene_annotation["name"] = annotations_data[record_index][2]
		gene_annotation["symbol"] = annotations_data[record_index][3]
		gene_annotation["next"] = int(annotations_data[record_index][1])
		gene_annotation["begin"] = int(annotations_data[record_index][0])

func pop_next_base() -> String:
	var next_base = "X"
	
	next_base = genome_data[current_place - (floor(current_place/80.0)*100)]
	#genome_data = genome_data.erase(0)
	
	current_place += 1
	
	if current_place >= (floor(current_place/80.0)*100) + 800:
		load_genome_file()
	
	calculate_annotation()
	
	return next_base
