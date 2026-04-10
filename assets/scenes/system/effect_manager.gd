extends Node

@export var effects : Dictionary[String,PackedScene]
@onready var screen_effects = $ScreenEffects
@onready var world_effects=$WorldEffects

#Spawn something in the world
func spawn_world_effect(eff,pos):
	var new_eff = effects[eff].instantiate()
	world_effects.add_child(new_eff)
	new_eff.global_position = pos

#Spawn something on a canvas layer
func spawn_screen_effect(eff,pos):
	var new_eff = effects[eff].instantiate()
	screen_effects.add_child(new_eff)
	new_eff.global_position = pos
	
func clear_world_effects():
	for c in world_effects.get_children():
		world_effects.remove_child(c)
		c.queue_free()

func clear_screen_effects():
	for c in screen_effects.get_children():
		screen_effects.remove_child(c)
		c.queue_free()

func clear_all_effects():
	clear_world_effects()
	clear_screen_effects()
