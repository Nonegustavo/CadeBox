extends Button


var colors = {success=Color("#67ff67"), sandbox=Color("#fffa6b")}

func _ready():
	pass # Replace with function body.

func set_title(text):
	$Title.text = text
	
func set_stats(a, b):
	$Stats.text = "COMANDOS: %d | TEMPO DE EXECUÇÃO: %d" % [a, b]

func set_color(text):
	set_modulate(colors[text])
