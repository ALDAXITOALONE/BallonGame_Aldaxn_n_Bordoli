extends Control
var skin_seleccionada 

func _process(delta: float) -> void:
	$ParallaxBackground.scroll_offset.x += -100 * delta

func _on_button_pressed() -> void:
	skin_seleccionada = preload("res://Assets/ChatGPT Image 10 may 2025, 01_34_49 p.m..png")
	Global.skin  = skin_seleccionada
	print(Global.skin)


func _on_skin_1_pressed() -> void:
	skin_seleccionada = preload("res://Assets/Sprite-0013.png")
	Global.skin  = skin_seleccionada
	print(Global.skin)



func _on_skin_2_pressed() -> void:
	skin_seleccionada = preload("res://Assets/Sprite-0014.png")
	Global.skin  = skin_seleccionada


func _on_skin_3_pressed() -> void:
	skin_seleccionada = preload("res://Assets/Sprite-0015.png")
	Global.skin  = skin_seleccionada


func _on_skin_4_pressed() -> void:
	skin_seleccionada = preload("res://Assets/Sprite-0016.png")
	Global.skin  = skin_seleccionada


func _on_salir_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")
