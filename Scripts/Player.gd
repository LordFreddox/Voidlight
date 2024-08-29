extends Node2D

@export var speed: float = 200.0
@export var rotation_speed: float = 5.0
@export var bullet_black: PackedScene # Referencia a la escena de la bala
@export var bullet_white: PackedScene # Referencia a la escena de la bala
@onready var audio_player1 = $Blaster1
@onready var audio_player2 = $Blaster2
@onready var audio_player3 = $Death
@export var gameOver: CanvasLayer

var velocity: Vector2 = Vector2.ZERO


func _process(delta: float) -> void:
	velocity = Vector2.ZERO

	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1

	if velocity != Vector2.ZERO:
		velocity = velocity.normalized() * speed
		position += velocity * delta
		
		var target_rotation = velocity.angle()
		rotation = lerp_angle(rotation, target_rotation, rotation_speed * delta)

	# Disparar al presionar la tecla asignada
	if Input.is_action_just_pressed("dark"):
		if Engine.time_scale == 1:
			shootdark()
		 
	if Input.is_action_just_pressed("light"):
		if Engine.time_scale == 1:
			shootlight()

func shootdark() -> void:
	if bullet_black:
		var bullet1 = bullet_black.instantiate()
		bullet1.position = position
		bullet1.rotation = rotation
		get_parent().add_child(bullet1)
		modulate = Color(0.2, 0.2, 0.2, 1)
		if not audio_player1.is_playing():
			audio_player1.play()  # Reproduce el audio cuando se presiona el botón
		else:
			audio_player1.stop() 
		
		
func shootlight() -> void:
	if bullet_white:
		var bullet2 = bullet_white.instantiate()
		bullet2.position = position
		bullet2.rotation = rotation
		get_parent().add_child(bullet2)
		modulate = Color(1, 1, 1, 1)
		if not audio_player2.is_playing():
			audio_player2.play()  # Reproduce el audio cuando se presiona el botón
		else:
			audio_player2.stop() 
		


func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		audio_player3.play() 
		


func _on_death_finished():
	Global.save_best_score()
	Engine.time_scale = 0.0
	gameOver.visible = true
