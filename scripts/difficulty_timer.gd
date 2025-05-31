extends Timer
class_name DifficultyTimer


func _on_timeout() -> void:
	get_tree().call_group("EnemySpawners", "reduce_spawn_timer_wait_time")
	
	if get_tree().get_first_node_in_group("EnemySpawners").get_spawn_speed_rate_maxed_out():
		self.stop()
		print("Stop difficulty!")
