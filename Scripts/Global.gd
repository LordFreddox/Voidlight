# Global.gd
extends Node

var parametro1:int = 0
var parametro2 = false
var best_score: int
var loaded_score: int
func set_params1(p1):
	parametro1 = p1
	
	
func set_params2(p2):
	parametro2 = p2


func save_best_score():
	if loaded_score < parametro1:
		best_score=parametro1
		print("se guardo")
		# Guardar el mejor puntaje en un archivo o almacenamiento persistente
		var save_file = FileAccess.open("user://best_score.save", FileAccess.WRITE)
		save_file.store_string(str(best_score))
		save_file.close()

func load_best_score() -> int:
	print("se cargó")
	# Cargar el mejor puntaje si el archivo existe
	if FileAccess.file_exists("user://best_score.save"):
		var load_file = FileAccess.open("user://best_score.save", FileAccess.READ)
		loaded_score = int(load_file.get_line())
		load_file.close()
		print("existe",loaded_score)
		return loaded_score
	return 0
