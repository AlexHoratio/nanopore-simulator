extends Node2D

signal pop

func _ready():
	randomize()
	$Sprite2D.rotation = randf()*2*PI

func _process(delta):
	pass

func _on_button_pressed():
	emit_signal("pop")
	queue_free()
