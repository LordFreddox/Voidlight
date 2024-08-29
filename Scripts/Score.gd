extends Node

# Variables para almacenar el puntaje actual y el mejor puntaje
var score: int = 0
var best_score: int = 0

# Referencias a los labels
@export var score_label: Label
@export var best_score_label: Label

func _ready():
	score_label.visible = false
	best_score_label.visible = false
	# Cargar el mejor puntaje del jugador si existe
	best_score = load_best_score()
	
	# Conectar a la señal de todos los enemigos que ya están en la escena
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		if enemy.has_signal("enemy_died"):
			enemy.connect("enemy_died", Callable(self, "_on_enemy_died"))

func _on_enemy_died(points: int):
	update_score(points)
	print("Score actualizado: %d" % score)

func update_score(points: int):
	score += points
	# Actualizar el texto del Label con el puntaje actual
	score_label.text = "Score: %d" % score
	print("Score: %d" % score)
	# Si el puntaje actual es mayor que el mejor puntaje, actualizarlo
	if score > best_score:
		best_score = score
		best_score_label.text = "Best Score: %d" % best_score
		save_best_score()

func save_best_score():
	# Guardar el mejor puntaje en un archivo o almacenamiento persistente
	var save_file = FileAccess.open("user://best_score.save", FileAccess.WRITE)
	save_file.store_string(str(best_score))
	save_file.close()

func load_best_score() -> int:
	# Cargar el mejor puntaje si el archivo existe
	if FileAccess.file_exists("user://best_score.save"):
		var load_file = FileAccess.open("user://best_score.save", FileAccess.READ)
		var loaded_score = int(load_file.get_line())
		load_file.close()
		return loaded_score
	return 0
