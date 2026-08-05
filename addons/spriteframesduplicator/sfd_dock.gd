@tool
extends Control

var sf: SpriteFrames
var sheet: Texture2D
var file_dialog: EditorFileDialog
	
func _ready() -> void:
	file_dialog = EditorFileDialog.new()
	file_dialog.file_mode = EditorFileDialog.FILE_MODE_SAVE_FILE
	file_dialog.add_filter("*.tres", "SpriteFrames Resource")
	file_dialog.add_filter("*.res", "SpriteFrames Resource")
	file_dialog.file_selected.connect(_on_file_selected)
	add_child(file_dialog)

func _on_tex_selector_resource_changed(resource: Resource) -> void:
	sheet = resource as Texture2D

func _on_sf_selector_resource_changed(resource: Resource) -> void:
	sf = resource as SpriteFrames

func duplicate_sf():
	if sf == null or sheet == null: return
	var new_sf = sf.duplicate(true)
	for anim_name in new_sf.get_animation_names():
		for i in range(new_sf.get_frame_count(anim_name)):
			var frame_duration = new_sf.get_frame_duration(anim_name,i)
			var frame_tex = new_sf.get_frame_texture(anim_name, i)
			
			if frame_tex is AtlasTexture:
				var new_atlas = frame_tex.duplicate(true) as AtlasTexture
				new_atlas.atlas = sheet
				new_sf.set_frame(anim_name, i, new_atlas, frame_duration)
			
	file_dialog.set_meta("pending_sf", new_sf)
	file_dialog.popup_centered_ratio(0.5)
	
func _on_export_pressed() -> void:
	duplicate_sf()

func _on_file_selected(path: String)-> void:
	var new_sf = file_dialog.get_meta("pending_sf") as SpriteFrames
	if new_sf:
		var err = ResourceSaver.save(new_sf, path)
		if err == OK:
			EditorInterface.get_resource_filesystem().reimport_files([path])
			print("Exported SpriteFrames successfully!")
		else:
			print("Error exporting SpriteFrames!")
