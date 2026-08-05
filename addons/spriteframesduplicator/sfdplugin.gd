@tool
extends EditorPlugin

var dock

func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass


func _enter_tree() -> void:
	var dock_scene = preload("res://addons/spriteframesduplicator/sfd_dock.tscn").instantiate()
	dock = EditorDock.new()
	dock.add_child(dock_scene)
	dock.title="SFD"
	dock.default_slot = DOCK_SLOT_LEFT_UL
	dock.available_layouts = EditorDock.DOCK_LAYOUT_VERTICAL | EditorDock.DOCK_LAYOUT_FLOATING
	add_dock(dock)


func _exit_tree() -> void:
	remove_dock(dock)
	dock.queue_free()
