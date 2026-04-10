extends Node

@export var flags: Dictionary[String,int]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func check_flag(f,val):
	if flags[f] == null:
		return false
	if flags[f] == val:
		return true
	
	return false

func set_flag(f,val):
	flags[f]=val

func reset_all_flags():
	flags.clear()
