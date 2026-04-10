extends CharacterBody2D

#Note: "Character" is not meant to be used by itself.
#Make a new script that inherits from it!

@export var move_speed = 140.0
@export var anim: AnimatedSprite2D
@export var moving=false
signal move_completed
func _physics_process(_delta: float) -> void:
	if moving:
		move_and_slide()

#Move character for a specific amount of time in a direction
func move_char(dir,duration,speed_mult=1.0):
	var t = get_tree().create_timer(duration)
	velocity = dir.normalized() * move_speed * speed_mult
	moving=true
	animate(velocity,true,true)
	await t.timeout
	velocity = Vector2.ZERO
	animate(dir,false,true)
	moving = false
	move_completed.emit()

#Move character to a specific position
func move_char_to_position(pos,speed_mult=1.0):
	var t = get_tree().create_tween()
	var dir = pos-global_position
	var dist = dir.length()
	t.tween_property(self,"global_position",pos,dist/(move_speed*speed_mult))
	animate(dir.normalized(),true,true)
	await t.finished
	animate(dir.normalized(),false,true)
	move_completed.emit()

#Play specific animation
func set_anim(a_name):
	anim.play(a_name)

#Set movement/idle animation
func animate(dir: Vector2, move = false, setanim = false):
	var prefix = "idle_"
	if move: prefix="move_"
	var a_name=""
	
	var suffix=""
	
	if dir.x > 0:
		suffix="right"
	elif dir.x < 0:
		suffix="left"
		
	if dir.y < -0.35:
		suffix="up"
	elif dir.y > 0.35:
		suffix="down"

	a_name = prefix+suffix
		
	if setanim:
		anim.animation = a_name
		anim.play()
