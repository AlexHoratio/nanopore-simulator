extends Panel

func _ready():
	pass
	
func _process(delta):
	$current.text = str(Genome.current_place) #  "Current: " + 
	
	$name.text = Genome.gene_annotation["name"] + " (" + Genome.gene_annotation["symbol"] + ")"
	$next.text = str(Genome.gene_annotation["next"]) # "Next: " + 
	
	$progress.min_value = Genome.gene_annotation["begin"]
	$progress.value = Genome.current_place
	$progress.max_value = Genome.gene_annotation["next"]
	
	#print($progress.min_value)
