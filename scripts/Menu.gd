extends Control

var button_level = preload("res://Level.tscn")

var levels = [
	{name="00 - DESCOBERTA", mode="level", need=-1, file="level_0.gd"},
	{name="01 - MAS SÃO TANTOS!", mode="level", need=0, file="level_1.gd"},
	{name="02 - COM LICENÇA", mode="level", need=1, file="level_2.gd"},
	{name="03 - AQUELE ALI", mode="level", need=2, file="level_3.gd"},
	{name="04 - FUSÃO!", mode="level", need=3, file="level_4.gd"},
	{name="05 - ALÔ, VIZINHOS!", mode="level", need=4, file="level_5.gd"},
	{name="06 - POTENCIALIZADOR", mode="level", need=5, file="level_6.gd"},
	{name="D0 - MÁXIMA POTÊNCIA", mode="level", need=6, file="level_d0.gd"},
	{name="07 - LANÇAMENTO", mode="level", need=6, file="level_7.gd"},
	{name="D1 - DENTRO DA CAIXA", mode="level", need=8, file="level_d1.gd"},
	{name="08 - MAPA DO TESOURO", mode="level", need=8, file="level_8.gd"},
	{name="09 - ZERO AQUI NÃO", mode="level", need=10, file="level_9.gd"},
	{name="10 - ACESSO VIP", mode="level", need=11, file="level_10.gd"},
	{name="D2 - POSITIVIDADE ABSOLUTA", mode="level", need=12, file="level_d2.gd"},
	{name="MODO LIVRE", mode="sandbox", need=12, file="sandbox.gd"},
	{name="11 - SOMA, SOMA, SOMA", mode="level", need=12, file="level_11.gd"},
	{name="12 - DE TRÁS PARA FRENTE", mode="level", need=15, file="level_12.gd"},
	{name="D3 - EMPILHANDO", mode="level", need=16, file="level_d3.gd"},
	{name="13 - SOBREVIVÊNCIA DO MAIOR", mode="level", need=16, file="level_13.gd"},
	{name="D4 - AGULHA NO PALHEIRO", mode="level", need=18, file= "level_d4.gd"},
	{name="14 - MULTIPLICANDO", mode="level", need=18, file="level_14.gd"},
	{name="D5 - PRODUTO OTIMIZADO", mode="level", need=20, file="level_d5.gd"},
	{name="D6 - O PRODUTO FINAL", mode="level", need=21, file="level_d6.gd"},
	{name="15 - DIVIDINDO PROBLEMAS", mode="level", need=20, file="level_15.gd"},
	{name="D7 - PODE SOLETRAR?", mode="level", need=23, file="level_d7.gd"},
	{name="D8 - REUNIÃO DE FAMÍLIA", mode="level", need=24, file="level_d8.gd"},
	{name="16 - CONTANDO O REBANHO", mode="level", need=23, file="level_16.gd"},
	{name="17 - SEM REPETIR", mode="level", need=26, file="level_17.gd"},
	{name="18 - NÚMERO.ZIP", mode="level", need=27, file="level_18.gd"},
	{name="D9 - ESTOURO DE MEMÓRIA", mode="level", need=28, file="level_d9.gd"},
	{name="19 - DANDO UMA ARRUMADA", mode="level", need=29, file="level_19.gd"},
]

func _ready():
	if Main.actual_level != -1:
		_on_Play_pressed()
	for i in levels.size():
		var new_button = button_level.instance()
		if levels[i].need == -1 or Main.data.levels[levels[i].need].success:
			new_button.set_title(levels[i].name)
			if levels[i].mode == "sandbox":
				new_button.set_color("sandbox")
			elif Main.data.levels[i].success:
				new_button.set_color("success")
				new_button.set_stats(Main.data.levels[i].commands, Main.data.levels[i].executed)
			new_button.connect("pressed", self, "_on_Level_pressed", [i])
		else:
			new_button.disabled = true
		$Fases/Center/Scroll/VBox.add_child(new_button)
		if i < Main.actual_level + 2:
			yield(get_tree(), "idle_frame")
			new_button.grab_focus()
		pass

func _on_Level_pressed(level):
	Main.level = load("res://levels/" + levels[level].file).new()
	Main.mode = Main.level.mode
	Main.actual_level = level
	Main.code = ["", "", ""]
	get_tree().change_scene("res://Resources/project_scene/Main.tscn")


func _on_Back_pressed():
	$Fases.hide()
	$Menu.show()


func _on_Play_pressed():
	$Menu.hide()
	$Fases.show()
