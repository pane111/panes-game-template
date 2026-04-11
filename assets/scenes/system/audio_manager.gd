extends Node

@onready var layer1=$MusicLayer1
@onready var layer2=$MusicLayer2
var c_layer #Current Layer
var i_layer #Inactive Layer
signal fade_complete

func set_music(l1,l2):
	layer1.stream=l1
	layer2.stream=l2
	
func set_layer(val):
	var stored_vol_1 = c_layer.volume_linear
	var stored_vol_2 = i_layer.volume_linear
	if val:
		c_layer=layer1
		i_layer=layer2
	else:
		c_layer=layer2
		i_layer=layer1
	c_layer.volume_linear=stored_vol_1
	i_layer.volume_linear=stored_vol_2

func fade_music_in(dur=0.5):
	var t = get_tree().create_tween()
	t.tween_property(c_layer,"volume_linear",1.0,dur)
	await t.finished
	fade_complete.emit()

func fade_music_out(dur=0.5):
	var t = get_tree().create_tween()
	t.tween_property(c_layer,"volume_linear",0.0,dur)
	await t.finished
	fade_complete.emit()



func play_hud_sfx(sfx):
	$HudSFX.stream=sfx
	$HudSFX.play()
