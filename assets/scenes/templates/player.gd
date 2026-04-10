extends "res://character.gd"

var lastdir: Vector2
@export var sprintspeed = 2.0
@export var sprint_enabled=true #Disable this if you want no sprinting
@onready var cam_pivot=$CameraPivot #The camera will follow this
@export_range(0.0,256.0) var max_cam_offset = 128.0
@export var cam_speed=0.5
@onready var icast = $InteractionCast
@export_range(0.0,256.0) var max_interaction_range = 32.0
var handle_input = true : set = _set_input
var can_inter = false
var cur_inter
var speedmult = 1.0
signal input_enabled

func _set_input(val):
	handle_input = val
	input_enabled.emit()

func _ready() -> void:
	_set_input(true)
	lastdir = Vector2.DOWN

func _process(delta: float) -> void:
	if velocity.length() > 0:
		cam_pivot.position = lerp(cam_pivot.position,Vector2.ZERO+velocity.normalized()*max_cam_offset,cam_speed*delta)

func _unhandled_input(_event: InputEvent) -> void:
	if !handle_input:
		return
	var inp = Input.get_vector("left","right","up","down")
	
	if Input.is_action_pressed("sprint") and sprint_enabled:
		speedmult = sprintspeed
	else:
		speedmult=1.0
	
	velocity = inp.normalized() * move_speed * speedmult
	icast.target_position = lastdir.normalized()*max_interaction_range
	anim.speed_scale = speedmult
	if inp.length() > 0:
		lastdir = inp.normalized()
		moving=true
		animate(velocity,true,true)
	else:
		moving=false
		animate(lastdir,false,true)

	if Input.is_action_just_pressed("ok") && can_inter && cur_inter!=null:
		cur_inter.on_interact()
		velocity = Vector2.ZERO
		animate(lastdir,false,true)
	
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if icast.is_colliding():
		var col = icast.get_collider()
		if col.is_in_group("interactable"):
			can_inter=true
			cur_inter=col
		else:
			can_inter=false
	else:
		can_inter=false
	global_position = global_position.clamp(Vector2.ZERO,Vector2(99999,99999))
