extends CanvasLayer

func _on_reiniciar_pressed() -> void:
	get_tree().reload_current_scene()

func _on_salir_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")
