extends CharacterBody2D

# === CAR HANDLING VARIABLES ===
@export var max_speed = 1000.0  # Maximum forward speed (pixels/sec). Increase for a faster car.
@export var max_turn_rate = 3.0  # Maximum rotation speed (radians/sec). Higher values yield sharper turns.
@export var acceleration = 500.0  # Forward acceleration. Higher makes the car accelerate faster.
@export var friction = 300.0  # Passive deceleration when no input is applied.
@export var braking_force = 800.0  # Deceleration when braking; should be stronger than friction.
@export var reverse_speed_limit = 300.0  # Maximum reverse speed (pixels/sec), typically slower than forward.

func _physics_process(delta: float) -> void:
	# Calculate the car's forward direction based on its rotation.
	var forward_vector = Vector2.UP.rotated(rotation)
	# Calculate the right (perpendicular) vector; used for lateral friction.
	var right_vector = forward_vector.rotated(PI/2)
	
	# === TURNING SYSTEM ===
	# Get steering input: positive for right, negative for left.
	var steering_input = Input.get_action_strength("turn_r") - Input.get_action_strength("turn_l")
	
	# turn_factor scales the steering responsiveness:
	# - At low speeds (velocity.length() is small), turn_factor is close to 1.0 → more responsive.
	# - At high speeds (velocity.length() near max_speed), turn_factor approaches the minimum (0.3) → less responsive.
	# TODO: Should I make these export variables?
	var turn_factor = clamp(1.0 - (velocity.length() / max_speed), 0.5, 1.0)
	
	# Calculate angular velocity from the steering input.
	var angular_velocity = steering_input * turn_factor * max_turn_rate
	
	if steering_input != 0:
		rotation += angular_velocity * delta

	# === ACCELERATION & BRAKING ===
	# Accelerate forward when "accelerate" is pressed.
	if Input.is_action_pressed("accelerate"):
		velocity += forward_vector * acceleration * delta
	
	# Braking:
	# - If the car is moving (speed > threshold), apply a strong braking force.
	# - If nearly stopped, allow for a slow reverse by accelerating backward.
	if Input.is_action_pressed("brake"):
		if velocity.length() > 10.0:
			velocity -= forward_vector * braking_force * delta
		else:
			velocity -= forward_vector * acceleration * delta * 0.5  # Reverse acceleration is weaker.
	
	# === PREVENT EXCEEDING REVERSE SPEED ===
	# If moving backward (dot product negative), cap the reverse speed.
	if velocity.dot(forward_vector) < 0:
		velocity = velocity.limit_length(reverse_speed_limit)
	
	# === TRACTION SYSTEM ===
	# Gradually align the velocity vector with the car's forward direction to reduce drift.
	velocity = velocity.lerp(forward_vector * velocity.length(), delta * 5.0)
	
	# === LATERAL FRICTION (Prevents Sideways Sliding) ===
	# Calculate lateral (sideways) speed and subtract it to simulate tire grip.
	var lateral_speed = velocity.dot(right_vector)
	velocity -= right_vector * lateral_speed * delta * 10.0
	
	# === SPEED LIMIT ===
	# Ensure the car's forward speed doesn't exceed the max_speed.
	velocity = velocity.limit_length(max_speed)
	
	move_and_slide()
