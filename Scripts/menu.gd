extends Control

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	$ParallaxBackground.scroll_offset.x += -100 * delta

func _on_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/mapa.tscn")
	

func _on_salir_pressed() -> void:
	get_tree().quit()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/skins.tscn")
