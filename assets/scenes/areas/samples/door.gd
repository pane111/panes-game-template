extends "res://assets/scenes/areas/samples/hide_on_ready.gd"
@export var door_name: String = "default"

func _ready() -> void:
	super._ready()
	get_parent().doors[door_name]=self
