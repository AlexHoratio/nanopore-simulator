extends Node2D

var read_length = 0

var time = 0

var move_speed = 120
var fade_speed = 0.05

func _ready():
	$Label2.text = str(int(read_length)) + " b.p."
	time = randi()

func _process(delta):
	time += delta
	
	position.x += sin(time * 4) 
	position.y -= move_speed * delta
	
	modulate.a -= delta * fade_speed
	
	if modulate.a <= 0:
		queue_free()
