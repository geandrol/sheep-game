extends Node2D # Ou CharacterBody2D se ela for andar

func _process(delta):
	# Diminui a felicidade e saúde bem devagar com o tempo
	Globals.felicidade -= 0.5 * delta
	Globals.saude -= 0.3 * delta
	
	# Garante que os valores fiquem sempre entre 0 e 100
	Globals.felicidade = clamp(Globals.felicidade, 0, 100)
	Globals.saude = clamp(Globals.saude, 0, 100)
