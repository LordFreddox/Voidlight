extends Area2D

@export var speed := 100
@export var enemy_type: String # Tipo de este enemigo


var player_node : Node2D

func _process(delta):
	if player_node:
		var player_pos = player_node.global_position
		var direction = (player_pos - global_position).normalized()
		global_position += direction * speed * delta

func set_player(player):
	player_node = player

func get_type() -> String:
	return enemy_type
