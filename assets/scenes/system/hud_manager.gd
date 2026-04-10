extends Node

signal fade_midpoint
signal fade_ended
@export var fade_from_black_at_launch=false
func _ready() -> void:
	if fade_from_black_at_launch:
		fade_black_out()
	close_all_popups()

func close_all_popups():
	for c in $PopupMenus.get_children():
		c.hide()

func fade_to_black(cont=false):
	$Overlays/FadeBlackAnim.play("fade_to_black")
	await $Overlays/FadeBlackAnim.animation_finished
	fade_midpoint.emit()
	if cont:
		fade_black_out()

func fade_black_out():
	$Overlays/FadeBlackAnim.play("fade_black_out")
	await $Overlays/FadeBlackAnim.animation_finished
	fade_ended.emit()

func set_settings(val):
	if val:
		$PopupMenus/SettingsMenu.show()
	else:
		GameManager.save_config()
		$PopupMenus/SettingsMenu.hide()

func _on_close_settings_pressed() -> void:
	set_settings(false)
