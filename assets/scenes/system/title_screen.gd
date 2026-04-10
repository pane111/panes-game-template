extends Node

#ALWAYS ALWAYS reference scenes that need to be loaded/unloaded a lot via strings
@export var starter_scene: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameManager.cur_scene == null:
		GameManager.cur_scene=self


func _on_play_btn_pressed() -> void:
	GameManager.load_new_scene(starter_scene)


func _on_settings_btn_pressed() -> void:
	HudManager.set_settings(true)


func _on_quit_btn_pressed() -> void:
	get_tree().quit()
