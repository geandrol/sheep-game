extends Node

# ═══════════════════════════════════════════
# Save.gd — Autoload
# Adicione em: Project > Project Settings > Autoload
# Nome: Save | Caminho: res://scripts/Save.gd
# ═══════════════════════════════════════════

const CAMINHO_SAVE = "user://save.dat"

func salvar() -> void:
	var dados = {
		"saude":      Globals.saude,
		"felicidade": Globals.felicidade,
	}
	var arquivo = FileAccess.open(CAMINHO_SAVE, FileAccess.WRITE)
	if arquivo:
		arquivo.store_var(dados)
		arquivo.close()

func carregar() -> void:
	if not FileAccess.file_exists(CAMINHO_SAVE):
		# Primeiro acesso — valores padrão
		Globals.saude      = 80.0
		Globals.felicidade = 80.0
		return

	var arquivo = FileAccess.open(CAMINHO_SAVE, FileAccess.READ)
	if arquivo:
		var dados = arquivo.get_var()
		arquivo.close()
		if dados is Dictionary:
			Globals.saude      = dados.get("saude",      80.0)
			Globals.felicidade = dados.get("felicidade", 80.0)

func deletar_save() -> void:
	if FileAccess.file_exists(CAMINHO_SAVE):
		DirAccess.remove_absolute(CAMINHO_SAVE)
