extends Node2D
@export var explosion_lifetime: float = 1.0 # Tiempo de vida de la explosión en segundos

func _ready() -> void:
	# Deshabilita el nodo después de explosion_lifetime segundos
	await get_tree().create_timer(explosion_lifetime).timeout
	queue_free()
