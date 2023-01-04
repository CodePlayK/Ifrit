extends Area2D


func _ready():
	pass


func _on_EnvironmentKillRayChecker_body_entered(body):
	on_entered(body)
	pass
 


func _on_EnvironmentKillRayChecker_area_entered(area):
	on_entered(area)
	pass 

func on_entered(body):
	print("伤害单位："+str(body.get_name()))
	send_singal_by_group_name(body)
	var parant = body.get_parent()
	while parant !=null and parant.get_class() !="Node2D":
		parant = parant.get_parent()
	send_singal_by_group_name(parant)

func send_singal_by_group_name(body):
	if body.is_in_group("environment_damage"):
		print("环境伤害！")
		EventBus.emit_signal("player_is_dead")
		pass
	if body.is_in_group("enemy_damage"):
		print("NPC伤害！")
		EventBus.emit_signal("player_is_dead")
		pass
