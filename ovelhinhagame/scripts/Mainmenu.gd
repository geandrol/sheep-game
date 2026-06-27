extends Control

# ═══════════════════════════════════════════
# REFERÊNCIAS DOS NÓS
# ═══════════════════════════════════════════
@onready var nuvem1        = $Nuvem1
@onready var nuvem2        = $Nuvem2
@onready var nuvem3        = $Nuvem3
@onready var nuvem4        = $Nuvem4
@onready var nuvem5        = $Nuvem5
@onready var flores        = $Flores
@onready var btn_jogar     = $CenterContainer/VBoxContainer/BtnJogar
@onready var btn_continuar = $CenterContainer/VBoxContainer/BtnContinuar
@onready var btn_minijogos = $CenterContainer/VBoxContainer/BtnMiniJogos
@onready var label_versiculo = $CenterContainer/VBoxContainer/Versiculo

# ═══════════════════════════════════════════
# CONFIGURAÇÕES DE ANIMAÇÃO
# ═══════════════════════════════════════════
const VEL_NUVEM1 = 20.0   # pixels/segundo — lenta
const VEL_NUVEM2 = 35.0   # pixels/segundo — média
const VEL_NUVEM3 = 15.0   # pixels/segundo — mais lenta
const VEL_NUVEM4 = 15.0   # pixels/segundo — mais lenta
const VEL_NUVEM5 = 35.0   # pixels/segundo — média

const FLORES_AMPLITUDE  = 1.8   # graus de rotação máxima
const FLORES_VELOCIDADE = 0.6   # ciclos por segundo

# ═══════════════════════════════════════════
# VERSÍCULOS
# ═══════════════════════════════════════════
const VERSICULOS = [
	'"O Senhor é meu pastor; nada me faltará." — Sl 23:1',
	'"Posso tudo naquele que me fortalece." — Fp 4:13',
	'"Deus é amor." — 1 Jo 4:8',
	'"Sede bons uns para com os outros." — Ef 4:32',
	'"Confiai nele em todo o tempo." — Sl 62:8',
	'"Alegrai-vos sempre no Senhor." — Fp 4:4',
	'"A fé é a certeza daquilo que esperamos." — Hb 11:1',
	'"O amor é paciente, é bondoso." — 1 Co 13:4',
]

# ═══════════════════════════════════════════
# ESTADO INTERNO
# ═══════════════════════════════════════════
var _tempo: float = 0.0
var _largura: float = 720.0

# Posições Y originais das nuvens (para não mudar a altura)
var _y_nuvem1: float = 0.0
var _y_nuvem2: float = 0.0
var _y_nuvem3: float = 0.0
var _y_nuvem4: float = 0.0
var _y_nuvem5: float = 0.0

# ═══════════════════════════════════════════
# INICIALIZAÇÃO
# ═══════════════════════════════════════════
func _ready() -> void:
	_largura = get_viewport().get_visible_rect().size.x

	# Guarda posições Y originais das nuvens
	if nuvem1: _y_nuvem1 = nuvem1.position.y
	if nuvem2: _y_nuvem2 = nuvem2.position.y
	if nuvem3: _y_nuvem3 = nuvem3.position.y
	if nuvem4: _y_nuvem4 = nuvem4.position.y
	if nuvem5: _y_nuvem5 = nuvem5.position.y

	# Versículo aleatório
	if label_versiculo:
		label_versiculo.text = VERSICULOS[randi() % VERSICULOS.size()]

	# Botão Continuar só aparece se tiver save
	if btn_continuar:
		btn_continuar.visible = FileAccess.file_exists("user://save.dat")

	# Conecta botões
	if btn_jogar:     btn_jogar.pressed.connect(_on_btn_jogar_pressed)
	if btn_continuar: btn_continuar.pressed.connect(_on_btn_continuar_pressed)
	if btn_minijogos: btn_minijogos.pressed.connect(_on_btn_minijogos_pressed)

	# Estiliza botões e anima entrada
	_estilizar_botoes()
	_animar_entrada()

# ═══════════════════════════════════════════
# LOOP PRINCIPAL
# ═══════════════════════════════════════════
func _process(delta: float) -> void:
	_tempo += delta
	_mover_nuvens(delta)
	_balancar_flores()

# ═══════════════════════════════════════════
# ANIMAÇÕES
# ═══════════════════════════════════════════
func _mover_nuvens(delta: float) -> void:
	if nuvem1:
		nuvem1.position.x += VEL_NUVEM1 * delta
		nuvem1.position.y = _y_nuvem1
		if nuvem1.position.x > _largura + 50:
			nuvem1.position.x = -nuvem1.size.x

	if nuvem2:
		nuvem2.position.x += VEL_NUVEM2 * delta
		nuvem2.position.y = _y_nuvem2
		if nuvem2.position.x > _largura + 50:
			nuvem2.position.x = -nuvem2.size.x

	if nuvem3:
		nuvem3.position.x += VEL_NUVEM3 * delta
		nuvem3.position.y = _y_nuvem3
		if nuvem3.position.x > _largura + 50:
			nuvem3.position.x = -nuvem3.size.x
			
	if nuvem4:
		nuvem4.position.x += VEL_NUVEM4 * delta
		nuvem4.position.y = _y_nuvem4
		if nuvem4.position.x > _largura + 50:
			nuvem4.position.x = -nuvem4.size.x
			
	if nuvem5:
		nuvem5.position.x += VEL_NUVEM5 * delta
		nuvem5.position.y = _y_nuvem5
		if nuvem5.position.x > _largura + 50:
			nuvem5.position.x = -nuvem5.size.x

func _balancar_flores() -> void:
	if not flores:
		return
	flores.pivot_offset = Vector2(flores.size.x / 2.0, flores.size.y)
	flores.rotation_degrees = sin(_tempo * FLORES_VELOCIDADE * TAU) * FLORES_AMPLITUDE

func _animar_entrada() -> void:
	modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.8)

# ═══════════════════════════════════════════
# ESTILO DOS BOTÕES
# ═══════════════════════════════════════════
func _estilizar_botoes() -> void:
	_aplicar_estilo_botao(btn_jogar,     Color("4CAF50"), Color("1B5E20"))
	_aplicar_estilo_botao(btn_continuar, Color("F5A623"), Color("7A4F00"))
	_aplicar_estilo_botao(btn_minijogos, Color("9C6DDB"), Color("3D1A78"))

func _aplicar_estilo_botao(botao: Button, cor_fundo: Color, cor_texto: Color) -> void:
	if not botao:
		return

	var estilo = StyleBoxFlat.new()
	estilo.bg_color = cor_fundo
	estilo.corner_radius_top_left     = 20
	estilo.corner_radius_top_right    = 20
	estilo.corner_radius_bottom_left  = 20
	estilo.corner_radius_bottom_right = 20
	estilo.border_width_left   = 3
	estilo.border_width_right  = 3
	estilo.border_width_top    = 3
	estilo.border_width_bottom = 3
	estilo.border_color  = Color(1, 1, 1, 0.6)
	estilo.shadow_color  = Color(0, 0, 0, 0.25)
	estilo.shadow_size   = 4
	estilo.shadow_offset = Vector2(0, 3)

	var estilo_hover = estilo.duplicate()
	estilo_hover.bg_color = cor_fundo.lightened(0.15)

	var estilo_press = estilo.duplicate()
	estilo_press.bg_color    = cor_fundo.darkened(0.15)
	estilo_press.shadow_size = 0

	botao.add_theme_stylebox_override("normal",  estilo)
	botao.add_theme_stylebox_override("hover",   estilo_hover)
	botao.add_theme_stylebox_override("pressed", estilo_press)
	botao.add_theme_color_override("font_color", cor_texto)
	botao.add_theme_font_size_override("font_size", 28)
	botao.custom_minimum_size = Vector2(280, 70)

# ═══════════════════════════════════════════
# NAVEGAÇÃO COM FADE OUT
# ═══════════════════════════════════════════
func _ir_para(caminho: String) -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.4)
	tween.tween_callback(func():
		get_tree().change_scene_to_file(caminho)
	)

func _on_btn_jogar_pressed() -> void:
	_ir_para("res://scenes/JogoPrincipal.tscn")

func _on_btn_continuar_pressed() -> void:
	_ir_para("res://scenes/JogoPrincipal.tscn")

func _on_btn_minijogos_pressed() -> void:
	_ir_para("res://scenes/ui/minigames.tscn")
