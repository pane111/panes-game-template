extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func save_data(file_num: int):
	var save_file = FileAccess.open("user//:savegame"+str(file_num)+".sav",FileAccess.WRITE)
	var sf_temp = SaveFileTemplate.new()
	sf_temp.flags = FlagManager.flags
	var json_file = JSON.stringify(sf_temp)
	save_file.store_string(json_file)
	
	save_file.close()

func load_data(file_num: int):
	if not FileAccess.file_exists("user//:savegame"+str(file_num)+".sav"):
		print_debug("Invalid savegame name!")
		return
		
	var save_file = FileAccess.open("user//:savegame"+str(file_num)+".sav",FileAccess.READ)
	var sf_temp = JSON.parse_string(save_file.get_as_text()).data
	
	save_file.close()
