extends Area2D

@export var speed: float = 400.0
@export var lifetime: float = 2.0
@export var enemy_type: String # Tipo de enemigo que esta bala puede destruir
@export var explosion_scene: PackedScene # Escena de la explosión
@export var explosion_lifetime: float = 1.0 # Tiempo de vida de la explosión en segundos
@onready var audio_player = $explosion
# Variables para almacenar el puntaje actual y el mejor puntaje
var score: int = 0



signal enemy_died()

func _ready() -> void:
	score= Global.parametro1
	# Destruye la bala después de que pase su tiempo de vida
	await get_tree().create_timer(lifetime).timeout
	queue_free()
	# Conecta la señal "area_entered" para detectar colisiones
	connect("area_entered", Callable(self, "_on_bullet_area_entered"))
	

func _process(delta: float) -> void:
	# Mueve la bala en la dirección en la que está mirando
	position += Vector2.RIGHT.rotated(rotation) * speed * delta

func _on_area_entered(area):
	#print("Colisión detectada con: ", area.name)
	#if area.is_in_group("Enemies"):
		#print("Colisión con un enemigo: ", area.name)

	# Comprueba si el área con la que colisionó es del tipo de enemigo que esta bala puede destruir
	if area.has_method("get_type"):
		#print("El área tiene un tipo: ", area.get_type())  # Debug: Verifica el tipo de enemigo

		if area.get_type() == enemy_type:
			#print("¡Colisionó con el enemigo correcto!")  # Debug: Confirma la colisión con el tipo correcto
			create_explosion(global_position)
			score= score+1
			Global.set_params1(score)
			area.queue_free()  # Destruye al enemigo
			queue_free()  # Destruye la bala
			if not audio_player.is_playing():
				audio_player.play()  # Reproduce el audio cuando se presiona el botón
			else:
				audio_player.stop() 
		

func create_explosion(position: Vector2) -> void:
		if explosion_scene:  # Verifica que la escena de explosión esté asignada
			var explosion = explosion_scene.instantiate() as Node2D  # Instancia la escena de la explosión
			explosion.global_position = position
			get_parent().add_child(explosion)
			 # Crea un temporizador para eliminar la explosión después de explosion_lifetime segundos
			await get_tree().create_timer(explosion_lifetime).timeout
			explosion.queue_free()

