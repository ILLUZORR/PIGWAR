extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
var SPEED = 300.0
const JUMP_VELOCITY = -320.0



var dashDirection = Vector2(1, 0)
var dashing = false

var health = 100
var bust = self.scale.x * -100.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _physics_process(delta):
	dash()
	Quit()
	move_and_slide()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$jump.play()
		velocity.y = JUMP_VELOCITY + bust

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("A", "D")
	if direction:
		velocity.x = direction * SPEED
		anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if dashing == false:
			anim.play("Idle")
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
		$Area2D/CollisionShape2D.position.x = -24
	elif direction == 1:
		$AnimatedSprite2D.flip_h = false
		$Area2D/CollisionShape2D.position.x = 24
	
	$CanvasLayer/Label.text = "health: " + str(health)
	$CanvasLayer/Label3.text = "SIZE: " + str(int(self.scale.x))
	
	if health <= 0:
		velocity.x = 0
		anim.play("Death")
		await get_tree().create_timer(1).timeout
		queue_free()
		get_tree().change_scene_to_file("res://game_over_screen.tscn")
	
	

func Quit():
	if Input.is_action_just_pressed("M"):
		get_tree().change_scene_to_file("res://menu.tscn")

func dash():
	if Input.is_action_pressed("D"):
		dashDirection = Vector2(1, 0)
	if Input.is_action_pressed("A"):
		dashDirection = Vector2(-1, 0)
	if Input.is_action_pressed("E") and dashing == false:
		velocity = dashDirection.normalized() * 2500
		dashing = true
		anim.play("Dash")
		$dash.play()
		await get_tree().create_timer(0.5).timeout
		dashing = false



func _on_area_2d_body_entered(body):
	if dashing == true:
		if body.get_parent().name == "enemy":
			body.death()
			if body.alive == false:
				$".".scale.x += 0.25
				$".".scale.y += 0.25
