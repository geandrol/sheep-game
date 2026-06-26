extends Node

# Status da Ovelhinha
var felicidade: float = 100.0
var saude: float = 100.0
var lã_cor: Color = Color.WHITE

# Progresso
var total_ovelhas_rebanho: int = 1
var versiculos_desbloqueados: Array = []

# Lista de versículos para o Ciclo Dia/Noite
var versiculos_dia = [
	"O Senhor é o meu pastor, nada me faltará. - Salmo 23:1",
	"De manhã ouves, Senhor, o meu clamor. - Salmo 5:3"
]
var versiculos_noite = [
	"Em paz me deito e logo adormeço, pois só tu, Senhor... - Salmo 4:8",
	"Não temerás o terror da noite... - Salmo 91:5"
]
