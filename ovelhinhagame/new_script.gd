extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
extends Control

const CENA_JOGO = "res://ovelhinha.tscn"

var versiculos = [
	"O Senhor é meu pastor — Salmo 23:1",
	"Tudo posso naquele que me fortalece — Filipenses 4:13",
	"Entrega teu caminho ao Senhor — Salmo 37:5",
	"Se Deus é por nós, quem será contra nós? — Romanos 8:31"
]

@onready var titulo = $CenterContainer/VBoxContainer/Titulo
@onready var subtitulo = $CenterContainer/VBoxContainer/SubTitulo
@onready var versiculo = $CenterContainer/VBoxContainer/VerVersiculo

@onready var btn_jogar = $CenterContainer/VBoxContainer/BtnJogar
@onready var btn_continuar = $CenterContainer/VBoxContainer/BtnContinuar
@onready var btn_sobre = $CenterContainer/VBoxContainer/BtnSobre


func _ready():

	randomize()

	titulo.text = "A Ovelhinha de Deus"

	subtitulo.text = "Bem-vindo"

	versiculo.text = versiculos.pick_random()

	if !FileAccess.file_exists("user://save.dat"):
		btn_continuar.visible=false

	btn_jogar.pressed.connect(iniciar_jogo)
	btn_continuar.pressed.connect(continuar)
	btn_sobre.pressed.connect(sobre)


func iniciar_jogo():

	get_tree().change_scene_to_file(
		CENA_JOGO
	)


func continuar():

	print("Continuando...")


func sobre():

	var popup = AcceptDialog.new()

	add_child(popup)

	popup.dialog_text="A Ovelhinha de Deus\nJogo educativo cristão"

	popup.popup_centered()
