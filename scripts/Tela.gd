extends Control

var cell = preload("res://DadoTabela.tscn")

var running = false
var running_mode = "stop" # run, test waiting_input, error
var waiting_input = false
var cursor = {line=0, column=0}
var cursor_bak = {line=0, column=0}
var stack = [] # {line=int, column=int}

# $Code/Text
# $Machine

func test_code():
	var code = $Code/Text.text
	var count = 0
	for v in code:
		match v:
			"[":
				count += 1
			"]":
				count -= 1
				if count < 0:
					return false
	return count == 0

func show_error(text):
	pass

func start():
	if running:
		return true
	if test_code():
		running = true
		cursor.line = 0
		cursor.column = 0
		cursor_bak.line = $Code/Text.cursor_get_line()
		cursor_bak.column = $Code/Text.cursor_get_column()
		$Code/Text.caret_block_mode = true
		$Code/Text.cursor_set_column(0)
		$Code/Text.cursor_set_line(0)
		return true
	else:
		show_error("Erro de sintaxe.")
		return false

func execute():
	if waiting_input:
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
			"\"":
				if Main.mode == "sandbox":
					waiting_input = true
					executed = false
					$Panels/Testar/HBox/TecladoNumerico.disable_keyboard(false)
			"'":
				if Main.mode == "sandbox":
					var num = $Machine.write()
					var new_cell = cell.instance()
					new_cell.text = str(num)
					$Panels/Testar/HBox/VBox/Scroll/Saida.add_child(new_cell)
					var scroll = $Panels/Testar/HBox/VBox/Scroll
					yield(get_tree(), "idle_frame")
					new_cell.grab_focus()
					$Code/Text.grab_focus()
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
	else:
		executed = false
	if executed:
		cursor.column += 1
	
func next_command(line, column):
	var accept = ["<",">","+","-",":",".","/","\\","'","\"","[","]","!","?","@"]
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
	running_mode = "stop"
	waiting_input = false
	$Timer.stop()
	$Code/Text.caret_block_mode = false
	$Code/Text.cursor_set_column(cursor_bak.column)
	$Code/Text.cursor_set_line(cursor_bak.line)
	$Machine.reset()
	$Code/Text.grab_focus()
	var list = $Panels/Testar/HBox/VBox/Scroll/Saida.get_children()
	for v in list:
		v.queue_free()


func _on_TecladoNumerico_newEntry(num):
	waiting_input = false
	$Machine.read(num)
	cursor.column += 1


func _on_Timer_timeout():
	execute()
