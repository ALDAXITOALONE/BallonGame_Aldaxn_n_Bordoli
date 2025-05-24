extends CharacterBody2D


var SPEED = 500.0
var ARRIBA = -300.0

var cuentaRegresiva = 3
@onready var km = $velocidad/km
@onready var cuenta = $Tiempo
@onready var perdedor = $CanvasLayer
@onready var sprite = $Sprite2D
@onready var tip = $CanvasLayer/Label2
@onready var LabelVida = $velocidad/Vida 
@onready var timerChocar = $Chocado
var puedeEmpezar = false
var vida = 1
var explotando = false
var velocidad_mostrada = 0.0
var yaArranco = false
var spaceTimer = true
var escalaBase = Vector2(0,0)
var skinDefualt = false
var multiplicacion = 30
var tamuerto

func _ready():
	tamuerto = false
	if Global.nivel != 1:
		vida = Global.vida
	actualizarVida()
	$EmpezasteNivel.visible = true
	$EmpezasteNivel.text = "Estas en el nivel " + str(Global.nivel)
	var skin_actual = Global.skin
	$Tiempo.text = str(cuentaRegresiva)
	get_tree().paused = false
	$CuentaRegresiva.start()
	$Space.start()
	if skin_actual != null:
		sprite.texture = skin_actual
	else:
		sprite.texture = preload("res://Assets/ChatGPT Image 10 may 2025, 01_34_49 p.m..png")
		skin_actual = sprite.texture
	
	if skin_actual != preload("res://Assets/ChatGPT Image 10 may 2025, 01_34_49 p.m..png"):
		escalaBase = Vector2(2.568, 2.63)
		skinDefualt = false
	else: 
		escalaBase = Vector2(0.083, 0.085)
		skinDefualt = true
	sprite.scale = escalaBase

func _physics_process(delta: float) -> void:
	Global.vida = vida
	if puedeEmpezar and !explotando:
		velocity.y = ARRIBA
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if  sprite.scale.x >= 0.03:
			if Input.is_key_pressed(KEY_SPACE):
				velocity.y = ARRIBA * 1.7
				sprite.scale -= Vector2(0.0003, 0.0003)
		else:
			sprite.scale += Vector2(0,0)

	elif explotando:
		velocity.y = 0
		velocity.x = 0
	
	var velocidad_real = velocity.length()
	velocidad_mostrada = lerp(velocidad_mostrada, velocidad_real, 5 * delta)
	km.text = "Velocidad: " + str(round(velocidad_mostrada)) + " km"
	if velocidad_mostrada >= 815:
		km.add_theme_color_override("font_color",  Color("#e10000"))
	elif velocidad_mostrada >= 800 and velocidad_mostrada < 850:
		km.add_theme_color_override("font_color", Color("e16d00"))
	elif velocidad_mostrada >= 785 and velocidad_mostrada < 800:
		km.add_theme_color_override("font_color", Color("949900"))
	elif velocidad_mostrada >= 650 and velocidad_mostrada < 785:
		km.add_theme_color_override("font_color", Color("4a9900"))
	elif velocidad_mostrada >= 375 and velocidad_mostrada < 400:
		km.add_theme_color_override("font_color", Color("75c800"))
	elif velocidad_mostrada >= 0 and velocidad_mostrada < 375:
		km.add_theme_color_override("font_color", Color("ffffff"))
	move_and_slide() 


func _on_cuenta_regresiva_timeout() -> void:
	cuentaRegresiva = cuentaRegresiva - 1
	cuenta.text = str(cuentaRegresiva)
	if cuentaRegresiva == 0:
		cuenta.text = "¡Empieza!"
	if cuentaRegresiva == -1:
		yaArranco = true
		cuenta.visible = false
		$CuentaRegresiva.stop()
		$Space.stop()
		$Label.visible = false
		puedeEmpezar = true
		$EmpezasteNivel.visible = false

func recibirDaño(daño):
	vida = vida - daño 
	actualizarVida() 
	if vida == 0:
		var numero = randi_range(1,8)
		ARRIBA = 0
		sprite.visible = false
		$perdedor.start()
		$Muerte.play("muerte")
		explotando = true
		$EmpezasteNivel.visible = false
		print("moriste")
		tamuerto = true
		match numero:
			1:
				tip.text = "TIP: evita los obstaculos \npara no EXPLOTAR💥💥"
				tip.add_theme_font_size_override("font_size", 15)
			2:
				tip.text = "¿Sabias que no todos los globos flotan? \nLos globos comunes con aire normal no flotan. "
				tip.add_theme_font_size_override("font_size", 13)
			3:
				tip.add_theme_font_size_override("font_size", 10)
				tip.text = "El calor hace que el aire o helio dentro del globo se expanda. \nSi hay mucha presión interna, ¡pum! explotan."
			4:
				tip.add_theme_font_size_override("font_size", 10)
				tip.text = "En ciencia, se usan globos meteorológicos que pueden \nascender más de 30 km en la atmósfera para estudiar el clima."
			5:
				tip.add_theme_font_size_override("font_size", 10)
				tip.text = "Hay competiciones de arte con globos donde crean  \ndragones, vestidos, castillos y más, ¡solo con globos inflables!"
			6:
				tip.add_theme_font_size_override("font_size", 10)
				tip.text = "El primer globo de goma fue inventado en 1824 por Michael \nFaraday, quien los usaba en experimentos científicos."
			7:
				tip.add_theme_font_size_override("font_size", 15)
				tip.text = "Tip: Agarra helio para evitar \nquedarte sin aire"
			8:
				tip.add_theme_font_size_override("font_size", 15)
				tip.text = "Este juego lo hizo Aldax y Bordoli a las 3AM."


func agarrarObjeto():
	ARRIBA = -300.0


func _on_perdedor_timeout() -> void:
	km.visible = false
	perdedor.visible = true


func _on_aumento_velocidad_timeout() -> void:
	ARRIBA += -5
	if yaArranco:
		if sprite.scale.x > 0.01:
			sprite.scale -= Vector2(0.0006, 0.0006)
		elif  sprite.scale.x <= 0.01:
			$perdedor.start(0.2)
			$CanvasLayer/Label2.text = "TIP: si te haces muy chico PERDES"


func agarrarHelio(valor):
	if !skinDefualt:
		valor = valor * multiplicacion
		multiplicacion += 20
	sprite.scale = escalaBase + Vector2(valor, valor)
	

func _on_space_timeout() -> void:
	if spaceTimer:
		$Label.visible = false
		$Space.start(1)
		spaceTimer = false
	else:
		$Label.visible = true
		$Space.start(1)
		spaceTimer = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	Global.nivel += 1
	print(Global.nivel)
	var path = "res://Escenas/Niveles/nivel" + str(Global.nivel) + ".tscn"
	if ResourceLoader.exists(path):
		get_tree().change_scene_to_file(path)
	else:
		get_tree().change_scene_to_file("res://Escenas/Ganador.tscn")

func _on_chocado_timeout() -> void:
	recibirDaño(1)
	if !tamuerto:
		timerChocar.start(3)

func actualizarVida():
	LabelVida.text = " "
	for i in range(vida):
		LabelVida.text += "❤️"
