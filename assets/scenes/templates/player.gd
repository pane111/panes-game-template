extends "res://character.gd"

var lastdir: Vector2
@export var inter_range = 30.0
@export var sprintspeed = 2.0
@export var sprint_enabled=true #Disable this if you want no sprinting
@onready var cam_pivot=$CameraPivot #The camera will follow this
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

func _unhandled_input(_event: InputEvent) -> void:
	if !handle_input:
		return
	var inp = Input.get_vector("left","right","up","down")
	
	if Input.is_action_pressed("sprint") and sprint_enabled:
		speedmult = sprintspeed
	else:
		speedmult=1.0
	
	velocity = inp.normalized() * move_speed * speedmult
	anim.speed_scale = speedmult
	if inp.length() > 0:
		lastdir = inp.normalized()
		moving=true
		animate(velocity,true,true)
	else:
		moving=false
		animate(lastdir,false,true)

	if Input.is_action_just_pressed("ok") && can_inter && cur_inter!=null:
		cur_inter.onInteract()
		velocity = Vector2.ZERO
		animate(lastdir,false,true)
	
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	position = position.clamp(Vector2.ZERO,Vector2(99999,99999))
