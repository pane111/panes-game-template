extends Area2D

@export var area: String
@export var direction = Vector2.ZERO
@export var door="default"
@export var dir_transition=false
func _ready() -> void:
	self.hide()
func _on_body_entered(body: Node2D) -> void:
	if body == GameManager.player:
		if GameManager.is_loading_scene:
			await GameManager.loading_finished
		$Sound.play()
		if direction != Vector2.ZERO:
			GameManager.load_new_scene(area,door,true,true,direction,dir_transition)
		else:
			GameManager.load_new_scene(area,door)
