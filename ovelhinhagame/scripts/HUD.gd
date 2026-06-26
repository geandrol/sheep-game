extends CanvasLayer


func _process(delta):

	$VidaBar.value=Globals.energia

	$FomeBar.value=Globals.fome

	$FelicidadeBar.value=Globals.felicidade

	$Dinheiro.text=str(
	Globals.moedas
	)

	$Versiculo.text=Globals.versiculos.pick_random()
