extends Node

func salvar():

	var save=FileAccess.open(
	"user://save.dat",
	FileAccess.WRITE
	)

	var dados={

		"moedas":Globals.moedas,
		"fome":Globals.fome,
		"felicidade":Globals.felicidade,
		"higiene":Globals.higiene,
		"energia":Globals.energia
	}

	save.store_var(dados)


func carregar():

	if !FileAccess.file_exists("user://save.dat"):
		return

	var save=FileAccess.open(
	"user://save.dat",
	FileAccess.READ
	)

	var dados=save.get_var()

	Globals.moedas=dados["moedas"]
	Globals.fome=dados["fome"]
	Globals.felicidade=dados["felicidade"]
	Globals.higiene=dados["higiene"]
	Globals.energia=dados["energia"]
