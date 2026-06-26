extends Control

# Criando referências para as barras da cena
@onready var barra_saude = $HUD/BarraSaude
@onready var barra_felicidade = $HUD/BarraFelicidade

func _ready() -> void:
	# Define o valor máximo das barras como 100
	barra_saude.max_value = 100
	barra_felicidade.max_value = 100

func _process(delta: float) -> void:
	# Faz o visual das barras seguir exatamente os valores globais
	barra_saude.value = Globals.saude
	barra_felicidade.value = Globals.felicidade

# Conectado do BtnAlimentar
func _on_btn_alimentar_pressed() -> void:
	Globals.saude += 10.0
	# Impede que passe de 100
	Globals.saude = clamp(Globals.saude, 0, 100)
	print("Ovelhinha alimentada! Saúde: ", Globals.saude)

# Conectado do BtnBanhar
func _on_btn_banhar_pressed() -> void:
	Globals.saude += 5.0
	Globals.felicidade += 5.0
	Globals.saude = clamp(Globals.saude, 0, 100)
	Globals.felicidade = clamp(Globals.felicidade, 0, 100)
	print("Ovelhinha de banho tomado!")

# Conectado do BtnBrincar
func _on_btn_brincar_pressed() -> void:
	Globals.felicidade += 10.0
	Globals.felicidade = clamp(Globals.felicidade, 0, 100)
	print("Ovelhinha brincou! Felicidade: ", Globals.felicidade)
	
