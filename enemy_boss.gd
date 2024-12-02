extends CharacterBody2D



var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D

var speed = 160

var attack = false
var alive = true

var chase = false

func _physics_process(delta):
	var player = $"../../Player"
	var direction = (player.position - self.position).normalized()
	if chase == true and alive == true:
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
		if attack == false and alive == true:
			anim.play("Idle") #run
	else:
		velocity.x = 0
		anim.play("Idle")
		
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
			$Attack.play()
			body.health -= 35
			attack = true
			await anim.animation_finished
			attack = false
		
func death():
	if $"../../Player".scale.x >= 5:
		get_tree().change_scene_to_file("res://end.tscn")
