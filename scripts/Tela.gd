extends Control

var cell = preload("res://DadoTabela.tscn")


var running = false
var running_mode = "stop" # run, test waiting_input, error
var end = false
var waiting_input = false
var cursor = {line=0, column=0}
var cursor_bak = {line=0, column=0}
var stack = [] # {line=int, column=int}

var input_cursor = 0
var last_input = null
var output_cursor = 0
var last_output = null
var inputs = []
var outputs = []
var outputs2 = []
var commands = ""
var error = false

signal show_message(msg)
signal show_success(size, executed)

func new_test(fixed=false):
	var test = Main.level.generate_test() if not fixed else fixed
	var input = $Panels/Testar/HBox/InOut/Entrada/Scroll/Valores.get_children()
	for v in input:
		v.queue_free()
	var output = $Panels/Testar/HBox/InOut/Saida/Scroll/Valores/Esperado.get_children()
	for v in output:
		v.queue_free()
	var output2 = $Panels/Testar/HBox/InOut/Saida/Scroll/Valores/Recebido.get_children()
	for v in output2:
		v.queue_free()
	inputs.clear()
	outputs.clear()
	outputs2.clear()
	last_input = null
	last_output = null
	input_cursor = 0
	output_cursor = 0
	$Machine.reset()
	$Machine.init(test.cells)
	for v in test.input:
		var new_cell = cell.instance()
		new_cell.text = str(v)
		inputs.append(new_cell)
		$Panels/Testar/HBox/InOut/Entrada/Scroll/Valores.add_child(new_cell)
	for v in test.output:
		var new_cell = cell.instance()
		new_cell.text = str(v)
		outputs.append(new_cell)
		$Panels/Testar/HBox/InOut/Saida/Scroll/Valores/Esperado.add_child(new_cell)
		new_cell = cell.instance()
		outputs2.append(new_cell)
		$Panels/Testar/HBox/InOut/Saida/Scroll/Valores/Recebido.add_child(new_cell)

func test_code():
	var code = $Code/Text.text
	var accept = ["<",">","+","-",":",".","/","\\","^","~","[","]","!","?","@","#"]
	var count = 0
	commands = ""
	var ok = false
	var enter = false
	for v in code:
		if v in accept:
			ok = true
			commands = commands + v
			match v:
				"[":
					count += 1
					enter = true
				"]":
					count -= 1
					if count < 0:
						emit_signal("show_message", "Seu codigo esta com erro de sintaxe. Verifique se fechou todos os colchetes.")
						return false
					if enter:
						emit_signal("show_message", "Eh preciso ter comandos entre os colchetes.")
						return false
				_:
					enter = false
	if not ok:
		emit_signal("show_message", "Voce precisa digitar algum codigo para poder processar alguma coisa!")
		return false
	if count != 0:
		emit_signal("show_message", "Seu codigo esta com erro de sintaxe. Verifique se fechou todos os colchetes.")
		return false
	return true


func start():
	if running:
		return true
	if test_code():
		if end:
			_on_Stop_pressed()
		running = true
		cursor.line = 0
		cursor.column = 0
		cursor_bak.line = $Code/Text.cursor_get_line()
		cursor_bak.column = $Code/Text.cursor_get_column()
		$Code/Text.caret_block_mode = true
		$Code/Text.cursor_set_column(0)
		$Code/Text.cursor_set_line(0)
		$Code/Text.grab_focus()
		return true
	else:
		return false

func end_program():
	end = true
	$Panels/Testar/HBox/Botoes/Play.disabled = false
	$Panels/Testar/HBox/Botoes/Fast.disabled = false
	$Panels/Testar/HBox/Botoes/Step.disabled = false
	$Panels/Testar/HBox/Botoes/Stop.disabled = true
	$Panels/Testar/HBox/TecladoNumerico.disable_keyboard(true)
	running = false
	waiting_input = false
	$Timer.stop()

func check_task():
	if output_cursor < outputs.size():
		emit_signal("show_message", "Seu programa precisa retornar mais dados!")
	else:
		var result = Main.internal_test(commands)
		if result[0]:
			emit_signal("show_success", commands.length(), result[1])
			Main.data.levels[Main.actual_level].success = true
			Main.data.levels[Main.actual_level].commands = commands.length()
			Main.data.levels[Main.actual_level].executed = result[1]
		else:
			emit_signal("show_message", "Seu programa passou neste teste, mas existe um teste no qual ele nao passa. Toque no play para ve-lo.")
			new_test(result[1])
			error = true

func execute():
	if waiting_input or end:
		return
	var executed = true
	var command = next_command(cursor.line, cursor.column)
	if command:
		$Code/Text.cursor_set_line(command[0])
		$Code/Text.cursor_set_column(command[1])
		cursor.line = command[0]
		cursor.column = command[1]
		match command[2]:
			">":
				$Machine.move_right()
				$Code/Text.grab_focus()
			"<":
				$Machine.move_left()
				$Code/Text.grab_focus()
			":":
				$Machine.copy()
			".":
				$Machine.store()
			"+":
				$Machine.add()
			"-":
				$Machine.sub()
			"/":
				$Machine.up()
			"\\":
				$Machine.down()
			"!":
				$Machine.if_zero()
			"?":
				$Machine.if_negative()
			"@":
				$Machine.swap()
			"~":
				if Main.mode == "sandbox":
					waiting_input = true
					executed = false
					$Panels/Testar/HBox/TecladoNumerico.disable_keyboard(false)
				else:
					if input_cursor >= inputs.size():
						end_program()
						check_task()
					else:
						inputs[input_cursor].black()
						$Machine.read(int(inputs[input_cursor].text))
						inputs[input_cursor].grab_focus()
						$Code/Text.grab_focus()
						input_cursor += 1
			"^":
				if Main.mode == "sandbox":
					var num = $Machine.write()
					var new_cell = cell.instance()
					new_cell.text = str(num)
					$Panels/Testar/HBox/VBox/Scroll/Saida.add_child(new_cell)
					yield(get_tree(), "idle_frame")
					new_cell.grab_focus()
					$Code/Text.grab_focus()
				else:
					if output_cursor >= outputs.size():
						end_program() # retornou mais dados que o necessario
						emit_signal("show_message", "Seu programa retornou mais dados que o necessário!")
					else:
						var num = $Machine.write()
						outputs2[output_cursor].text = str(num)
						outputs[output_cursor].black()
						outputs[output_cursor].grab_focus()
						$Code/Text.grab_focus()
						if outputs2[output_cursor].text == outputs[output_cursor].text:
							outputs2[output_cursor].black()
						else:
							outputs2[output_cursor].red()
							emit_signal("show_message", "Seu programa retornou [color=#dd0000]%s[/color], mas o teste pedia [color=#dd0000]%s[/color]" % [outputs2[output_cursor].text, outputs[output_cursor].text])
							end_program() # retornou valor errado
						output_cursor += 1
						
			"[":
				stack.append([cursor.line, cursor.column])
				if $Machine.get_register() == 0:
					var init = stack.back()
					var temp_command = next_command(command[0], command[1]+1)
					while temp_command:
						temp_command = next_command(temp_command[0], temp_command[1]+1)
						match temp_command[2]:
							"[":
								stack.append([temp_command[0], temp_command[1]])
							"]":
								var last = stack.pop_back()
								if last == init:
									cursor.line = temp_command[0]
									cursor.column = temp_command[1]
									break
			"]":
				if $Machine.get_register() == 0:
					stack.pop_back()
				else:
					var last = stack.back()
					cursor.line = last[0]
					cursor.column = last[1]
			"#":
				cursor.line = 0
				cursor.column = -1
	else:
		end_program()
		check_task()
	if executed:
		cursor.column += 1
	
func next_command(line, column):
	var accept = ["<",">","+","-",":",".","/","\\","^","~","[","]","!","?","@","#"]
	var lines = $Code/Text.get_line_count()
	while true:
		var text = $Code/Text.get_line(line)
		while column < text.length():
			if text[column] in accept:
				return [line, column, text[column]]
			column += 1
		line += 1
		column = 0
		if line >= lines:
			return false
	pass

func _on_Tab_pressed(arg):
	if running:
		return
	Main.actualCode = arg
	match arg:
		0:
			$Top/HBox/Files/Tabs/File1.disabled = true
			$Top/HBox/Files/Tabs/File2.disabled = false
			$Top/HBox/Files/Tabs/File3.disabled = false
		1:
			$Top/HBox/Files/Tabs/File1.disabled = false
			$Top/HBox/Files/Tabs/File2.disabled = true
			$Top/HBox/Files/Tabs/File3.disabled = false
		2:
			$Top/HBox/Files/Tabs/File1.disabled = false
			$Top/HBox/Files/Tabs/File2.disabled = false
			$Top/HBox/Files/Tabs/File3.disabled = true
	$Code/Text.text = Main.code[Main.actualCode]


func _on_Play_pressed():
	if not start():
		return
	$Panels/Testar/HBox/Botoes/Play.disabled = true
	$Panels/Testar/HBox/Botoes/Fast.disabled = false
	$Panels/Testar/HBox/Botoes/Step.disabled = true
	$Panels/Testar/HBox/Botoes/Stop.disabled = false
	$Timer.wait_time = Main.normal_speed
	execute()
	$Timer.start()


func _on_Fast_pressed():
	if not start():
		return
	$Panels/Testar/HBox/Botoes/Play.disabled = false
	$Panels/Testar/HBox/Botoes/Fast.disabled = true
	$Panels/Testar/HBox/Botoes/Step.disabled = true
	$Panels/Testar/HBox/Botoes/Stop.disabled = false
	$Timer.wait_time = Main.fast_speed
	execute()
	$Timer.start()


func _on_Step_pressed():
	if not start():
		return
	$Panels/Testar/HBox/Botoes/Stop.disabled = false
	execute()


func _on_Stop_pressed():
	$Panels/Testar/HBox/Botoes/Play.disabled = false
	$Panels/Testar/HBox/Botoes/Fast.disabled = false
	$Panels/Testar/HBox/Botoes/Step.disabled = false
	$Panels/Testar/HBox/Botoes/Stop.disabled = true
	$Panels/Testar/HBox/TecladoNumerico.disable_keyboard(true)
	running = false
	end = false
	running_mode = "stop"
	waiting_input = false
	$Timer.stop()
	$Code/Text.caret_block_mode = false
	$Code/Text.cursor_set_column(cursor_bak.column)
	$Code/Text.cursor_set_line(cursor_bak.line)
	$Machine.reset()
	$Code/Text.grab_focus()
	if Main.mode == "sandbox":
		var list = $Panels/Testar/HBox/VBox/Scroll/Saida.get_children()
		for v in list:
			v.queue_free()
	else:
		if not error:
			new_test()
	error = false


func _on_TecladoNumerico_newEntry(num):
	waiting_input = false
	$Machine.read(num)
	cursor.column += 1


func _on_Timer_timeout():
	execute()


func _on_PanelTab_pressed(tab):
	match tab:
		"task", "keyboard":
			if running or end:
				_on_Stop_pressed()
		"test":
			if Main.mode == "level":
				new_test()
	$Code/Text.grab_focus()


func _on_Menu_pressed():
	get_tree().change_scene("res://Menu.tscn")


func _on_HelpButton_pressed():
	get_parent().get_node("Help").show()
	Main.data.help = true
