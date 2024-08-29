extends Node2D

@export var enemy_scene_1 : PackedScene
@export var enemy_scene_2 : PackedScene
@export var player : NodePath # Aquí pasas la referencia al Player desde el Inspector
@export var spawn_time := 2.0 # Tiempo entre cada spawn
@export var screen_margin := 50 # Margen para el spawn fuera de pantalla

func _ready():
	while true:
		spawn_enemy()
		await get_tree().create_timer(spawn_time).timeout

func spawn_enemy():
	var enemy_scene = enemy_scene_1 if randf() < 0.5 else enemy_scene_2
	if enemy_scene:
		var enemy = enemy_scene.instantiate()
		enemy.set_player(get_node(player))  # Pasar el nodo del Player al enemigo
		var viewport_rect = get_viewport().get_visible_rect()

		# Generar una posición aleatoria fuera de los límites de la pantalla
		var x = randf() * (viewport_rect.size.x + 2 * screen_margin) - screen_margin
		var y = randf() * (viewport_rect.size.y + 2 * screen_margin) - screen_margin

		if x > 0 and x < viewport_rect.size.x:
			y = viewport_rect.size.y + screen_margin if y > viewport_rect.size.y / 2 else -screen_margin
		else:
			x = viewport_rect.size.x + screen_margin if x > viewport_rect.size.x / 2 else -screen_margin

		enemy.global_position = Vector2(x, y)
		add_child(enemy)
