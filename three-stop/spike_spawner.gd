extends Node3D

@export var spike_scene: PackedScene
@export var player: Node3D

@export var spawn_height: float = 8.0
@export var spikes_per_wave: int = 4

@export var front_distance: float = 4.0
@export var random_side: float = 3.0
@export var random_forward: float = 2.0

func _ready():
	randomize()
	spawn_loop()


func spawn_loop():
	while true:
		# Jeda antar gelombang
		await get_tree().create_timer(
			randf_range(1.0, 2.0)
		).timeout

		if player == null or spike_scene == null:
			continue

		# Spawn beberapa spike
		for i in range(spikes_per_wave):

			var spike = spike_scene.instantiate()
			get_tree().current_scene.add_child(spike)

			# Arah depan dan samping player
			var forward = -player.global_transform.basis.z
			var side = player.global_transform.basis.x

			# Posisi acak di depan player
			var front_position = player.global_position + forward * front_distance

			var offset_side = randf_range(
				-random_side,
				random_side
			)

			var offset_forward = randf_range(
				-random_forward,
				random_forward
			)

			var spawn_position = front_position \
				+ side * offset_side \
				+ forward * offset_forward

			# Naikkan posisi spike
			spawn_position.y += spawn_height

			spike.global_position = spawn_position

			# Hapus spike setelah 8 detik
			hapus_spike(spike)

			await get_tree().create_timer(0.15).timeout


func hapus_spike(spike):
	await get_tree().create_timer(8.0).timeout

	if is_instance_valid(spike):
		spike.queue_free()
