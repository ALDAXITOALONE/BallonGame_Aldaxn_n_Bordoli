extends Node2D

func _ready() -> void:
	get_tree().paused = false

func _process(delta: float) -> void:
	$Camera2D.global_position.y = $Jugador.global_position.y
