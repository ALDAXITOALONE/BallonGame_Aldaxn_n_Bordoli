extends Area2D
var valor = randi_range(1, 10)
var aumento
@onready var sprite = $Sprite2D

func _ready() -> void:
	if valor >= 1 and valor < 6:
		aumento = 0.04
		sprite.texture = preload("res://Assets/ChatGPT Image 16 may 2025, 06_58_44 p.m..png")
	elif valor > 6 and valor < 9:
		aumento = 0.056
		sprite.texture = preload("res://Assets/ChatGPT Image 16 may 2025, 08_03_45 p.m..png")
	else:
		sprite.texture = preload("res://Assets/ChatGPT Image 16 may 2025, 08_27_10 p.m..png")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		if valor >= 1 and valor < 9:
			body.agarrarHelio(aumento)
		else:
			body.vida += 1
	queue_free()
