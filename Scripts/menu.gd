extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ParallaxBackground.scroll_offset.x += -100 * delta


func _on_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://mapa.tscn")
	

func _on_salir_pressed() -> void:
	get_tree().quit()
