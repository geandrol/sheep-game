extends Control

@onready var barra_saude      = $HUD/BarraSaude
@onready var barra_felicidade = $HUD/BarraFelicidade

const DECAIMENTO_SAUDE      = 2.0
const DECAIMENTO_FELICIDADE = 1.5
const INTERVALO_DECAIMENTO  = 5.0

var timer_acumulado = 0.0

func _ready() -> void:
	barra_saude.max_value      = 100
	barra_felicidade.max_value = 100
	Save.carregar()
	_atualizar_barras()

func _process(delta: float) -> void:
	timer_acumulado += delta
	if timer_acumulado >= INTERVALO_DECAIMENTO:
		timer_acumulado = 0.0
		_on_decaimento()

func _atualizar_barras() -> void:
	barra_saude.value      = Globals.saude
	barra_felicidade.value = Globals.felicidade

func _on_decaimento() -> void:
	Globals.saude      = clamp(Globals.saude - DECAIMENTO_SAUDE, 0, 100)
	Globals.felicidade = clamp(Globals.felicidade - DECAIMENTO_FELICIDADE, 0, 100)
	_atualizar_barras()
	Save.salvar()

func _on_btn_alimentar_pressed() -> void:
	Globals.saude = clamp(Globals.saude + 10.0, 0, 100)
	_atualizar_barras()
	Save.salvar()

func _on_btn_banhar_pressed() -> void:
	Globals.saude      = clamp(Globals.saude + 5.0, 0, 100)
	Globals.felicidade = clamp(Globals.felicidade + 5.0, 0, 100)
	_atualizar_barras()
	Save.salvar()

func _on_btn_brincar_pressed() -> void:
	Globals.felicidade = clamp(Globals.felicidade + 10.0, 0, 100)
	_atualizar_barras()
	Save.salvar()

func _on_btn_minijogos_pressed() -> void:
	Save.salvar()
	get_tree().change_scene_to_file("res://scenes/ui/minigames.tscn")
