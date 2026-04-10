extends Node2D

@export var area_name: String
@export var area_music: AudioStream
@export var doors: Dictionary[String,Node2D] #Basically all places where the player can enter/exit the scene
@export var default_door: String #If no door is provided when loading a scene, it will use this one

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
