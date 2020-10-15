extends Control

func _ready():
	if Main.data.help:
		hide()

func _on_Button_pressed():
	hide()
	$Center/Panel.hide()
	$Center/Sucesso.hide()

func _on_Tela_show_message(msg):
	$Center/Panel/VBox/Label.bbcode_text = msg
	$Center/Panel.show()
	show()


func _on_Tela_show_success(size, executed):
	var text = "Parabens, seu programa passou no teste!\n\n" \
	+ "Tamanho do codigo: [color=#dd0000]%s[/color]\n" \
	+ "Comandos executados*: [color=#dd0000]%s[/color]\n\n" \
	+ "*Em uma media de 250 testes aleatorios"
	$Center/Sucesso/VBox/Label.bbcode_text = text % [size, executed]
	$Center/Sucesso.show()
	show()
