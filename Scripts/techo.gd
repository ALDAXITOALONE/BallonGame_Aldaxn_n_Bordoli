extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		body.timerChocar.start(3)
		body.km.text = "km: 0"
		print ("entraste")
		

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		body.timerChocar.stop()
		print ("saliste")
