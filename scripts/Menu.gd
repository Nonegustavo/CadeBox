extends Control

var button_level = preload("res://Level.tscn")
var screen = "main"

var levels = [
	{name="00 - Descoberta", mode="level", need=-1, file="level_0.gd"},
	{name="01 - De novo e de novo", mode="level", need=0, file="level_1.gd"},
	{name="02 - Com licença", mode="level", need=1, file="level_2.gd"},
	{name="03 - Aquele alí", mode="level", need=2, file="level_3.gd"},
	{name="04 - Somar e subtrair", mode="level", need=3, file="level_4.gd"},
	{name="05 - Vizinhança", mode="level", need=4, file="level_5.gd"},
	{name="06 - Amplificar", mode="level", need=5, file="level_6.gd"},
	{name="D0 - Alta potência", mode="level", need=6, file="level_d0.gd"},
	{name="07 - Lançamento", mode="level", need=6, file="level_7.gd"},
	{name="D1 - Sequenciamento", mode="level", need=8, file="level_d1.gd"},
	{name="08 - Mapa do tesouro", mode="level", need=8, file="level_8.gd"},
	{name="09 - Removedor de zeros", mode="level", need=10, file="level_9.gd"},
	{name="10 - Acesso VIP", mode="level", need=11, file="level_10.gd"},
	{name="D2 - Positividade absoluta", mode="level", need=12, file="level_d2.gd"},
	{name="Modo Livre", mode="sandbox", need=12, file="sandbox.gd"},
	{name="11 - Somar grupos", mode="level", need=12, file="level_11.gd"},
	{name="12 - De trás para frente", mode="level", need=15, file="level_12.gd"},
	{name="D3 - Empilhando", mode="level", need=16, file="level_d3.gd"},
	{name="13 - Sobrevivência do maior", mode="level", need=16, file="level_13.gd"},
	{name="D4 - Agulha no palheiro", mode="level", need=18, file= "level_d4.gd"},
	{name="14 - Multiplicador", mode="level", need=18, file="level_14.gd"},
	{name="D5 - Produto otimizado", mode="level", need=20, file="level_d5.gd"},
	{name="D6 - O produto final", mode="level", need=21, file="level_d6.gd"},
	{name="15 - Dividindo problemas", mode="level", need=20, file="level_15.gd"},
	{name="D7 - Pode soletrar?", mode="level", need=23, file="level_d7.gd"},
	{name="D8 - Reunião de família", mode="level", need=24, file="level_d8.gd"},
	{name="16 - Contar o estoque", mode="level", need=23, file="level_16.gd"},
	{name="17 - Sem repetir", mode="level", need=26, file="level_17.gd"},
	{name="18 - Número.zip", mode="level", need=27, file="level_18.gd"},
	{name="D9 - Estouro de memória", mode="level", need=28, file="level_d9.gd"},
	{name="19 - Tudo em ordem", mode="level", need=29, file="level_19.gd"},
]

func _ready():
	update_sound_button()
	if Main.data.sound:
		$Song.play()
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
		if i < Main.actual_level + 4:
			yield(get_tree(), "idle_frame")
			new_button.grab_focus()
			new_button.focus_mode = Control.FOCUS_NONE
		pass

func _on_Level_pressed(level):
	Main.level = load("res://levels/" + levels[level].file).new()
	Main.mode = Main.level.mode
	Main.actual_level = level
	Main.actualCode = 0
	Main.load_code(level)
	$Sound.play_sound("Keyboard")
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Resources/project_scene/Main.tscn")


func _on_Back_pressed():
	$Sound.play_sound("Keyboard")
	screen = "main"
	$Fases.hide()
	$Options.hide()
	$Credits.hide()
	$Menu.show()


func _on_Play_pressed():
	$Sound.play_sound("Keyboard")
	screen = "play"
	$Menu.hide()
	$Fases.show()


func _on_Credits_pressed():
	$Sound.play_sound("Keyboard")
	screen = "credits"
	$Menu.hide()
	$Credits.show()


func _on_Options_pressed():
	$Sound.play_sound("Keyboard")
	screen = "options"
	$Menu.hide()
	$Options.show()


func _on_Sound_pressed():
	Main.data.sound = not Main.data.sound
	Main.save_data()
	update_sound_button()
	if Main.data.sound:
		$Sound.play_sound("Keyboard")
		$Song.play()
	else:
		$Song.stop()


func update_sound_button():
	$Options/Center/VBox/Sound.text = "Sons: " + ("Ligado" if Main.data.sound else "Desligado")

func _on_Reset_pressed():
	$Sound.play_sound("Keyboard")
	screen = "reset"
	$Options.hide()
	$Reset.show()


func _on_Nope_pressed():
	$Sound.play_sound("Keyboard")
	screen = "options"
	$Reset.hide()
	$Options.show()


func _on_Yes_pressed():
	$Sound.play_sound("Keyboard")
	screen = "main"
	Main.reset_data()
	Main.actual_level = -1
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
	
func _notification(what):
	if what in [MainLoop.NOTIFICATION_WM_QUIT_REQUEST, MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST]:
		match screen:
			"main":
				get_tree().quit()
			"reset":
				_on_Nope_pressed()
			_:
				_on_Back_pressed()


func _on_Text_meta_clicked(meta):
	OS.shell_open(meta)
