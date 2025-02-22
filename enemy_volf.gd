extends CharacterBody2D



var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D

var speed = 100

var attack = false
var alive = true

var chase = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	var player = $"../../Player"
	var direction = (player.position - self.position).normalized()
	if chase == true:
		velocity.x = direction.x * speed
		if attack == false and alive == true:
			anim.play("Run")
		
	else:
		velocity.x = 0
		anim.play("Idle")
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
		
	if attack == true and alive == true:
		anim.play("Attack")
	if alive == false:
		velocity.x = 0
		
	move_and_slide()

func _on_detector_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_detector_body_exited(body):
		if body.name == "Player":
			chase = false

func _on_attack_body_entered(body):
	if body.name == "Player":
		if body.dashing == false:
			$Attack2.play()
			body.health -= 20
			attack = true
			await anim.animation_finished
			attack = false
		
func death():
	$Death.play()
	$"../../Player".health += 10
	alive = false
	anim.play("Death")
	await anim.animation_finished
	queue_free()
