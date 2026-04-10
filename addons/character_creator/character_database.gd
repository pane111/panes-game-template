extends Node

var characters: Dictionary[String,CharacterContainer]
@export var character_directory="res://addons/character_creator/characters/"
func _ready():
	var dir = DirAccess.open(character_directory)
	if dir == null: printerr("Character directory missing!"); return
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var res := load(dir.get_current_dir() + "/" + file)
		characters[res.ref_name] = res
func get_character(ref_name):
	return characters[ref_name]		
		
func set_character(ref_name,newchar):
	characters[ref_name] = newchar
