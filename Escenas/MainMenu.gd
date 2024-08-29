extends CanvasLayer

@export var mainMenu: CanvasLayer
@export var gameOver: CanvasLayer
@export var score: Label
@export var bestLabel: Label
var loadScore: int
var bestScore: int
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.load_best_score()
	bestScore = Global.loaded_score
	bestLabel.text=str(bestScore)
	print("best",bestScore)
	Engine.time_scale = 0.0
	var reload = Global.parametro2
	if reload:
		mainMenu.visible=false
		Engine.time_scale = 1.0

func _process(delta):
	loadScore= Global.parametro1
	score.text=str(loadScore)
	if loadScore > bestScore:
		bestLabel.text=str(loadScore)
		
		
	

func _on_play_pressed():
	Engine.time_scale = 1.0
	mainMenu.visible = false


func _on_reload_pressed():
	Global.set_params2(true)
	Global.set_params1(0)
	get_tree().reload_current_scene()
	
