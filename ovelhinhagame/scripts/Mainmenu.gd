extends Control

func _on_btn_jogar_pressed() -> void:
	# O Godot diferencia maiúsculas de minúsculas! 
	# Garanta que está exatamente "JogoPrincipal.tscn" com J e P maiúsculos se for o caso
	get_tree().change_scene_to_file("res://scenes/JogoPrincipal.tscn")
