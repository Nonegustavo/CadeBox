extends TextEdit

const MAX_COLUMN = 15
var selected_line = 0
var selected_column = 0
var select_mode = false

signal deselect_text()

func _ready():
	grab_focus()
	add_keyword_color("_", Color("68c981"))
	text = Main.code[Main.actualCode]
	clear_undo_history()

# func chamada a cada alteraçao no texto
func save_code():
	# fazer undo e redo alimenta o historico de desfazer
	undo()
	redo()
	Main.code[Main.actualCode] = text
	Main.save_code()


func _on_Teclado_action_pressed(action):
	$"../../../Sound".play_sound("Keyboard")
	match action:
		"copy":
			if is_selection_active():
				copy()
		"cut":
			if is_selection_active():
				var column = get_selection_from_column()
				var line = get_selection_from_line()
				cut()
				save_code()
				cursor_set_column(column)
				cursor_set_line(line)
				emit_signal("deselect_text")
		"paste":
			paste()
			emit_signal("deselect_text")
			save_code()
		"undo":
			undo()
			emit_signal("deselect_text")
			save_code()
		"redo":
			redo()
			emit_signal("deselect_text")
			save_code()


func _on_Teclado_arrow_pressed(dir):
	# eh preciso calcular se o cursor precisa mudar de linha
	# uma mesma linha pode ocupar varias linhas visualmente
	# neste caso o cursor deve mudar de coluna
	# eh sensivel ao max de caracteres por linha
	$"../../../Sound".play_sound("Keyboard")
	var line = cursor_get_line()
	var column  = cursor_get_column()
	var lineStr = get_line(line)
	match dir:
		"up":
			if lineStr.length() > MAX_COLUMN and column > MAX_COLUMN:
				cursor_set_column(column-(MAX_COLUMN-1))
			elif line == 0:
				cursor_set_column(0)
			else:
				var upStr = get_line(line-1)
				if upStr.length() > MAX_COLUMN:
					var linesUp = upStr.length()/(MAX_COLUMN-1)
					cursor_set_line(line-1)
					cursor_set_column(linesUp*(MAX_COLUMN-1)+column)
				else:
					cursor_set_line(line-1)
		"down":
			if lineStr.length() > MAX_COLUMN:
				var lines = lineStr.length()/(MAX_COLUMN-1)
				if column < lines*(MAX_COLUMN-1):
					cursor_set_column(column+(MAX_COLUMN-1))
				else:
					cursor_set_column(column%(MAX_COLUMN-1))
					cursor_set_line(line+1)
			elif line == get_line_count()-1:
				cursor_set_column(lineStr.length())
			else:
				cursor_set_line(line+1)
		"left":
			if column == 0 and line > 0:
				cursor_set_line(line-1)
				cursor_set_column(get_line(cursor_get_line()).length())
			else:	
				cursor_set_column(column-1)
		"right":
			var lines = get_line_count()
			if line != lines-1 and column == lineStr.length():
				cursor_set_column(0)
				cursor_set_line(line+1)
			else:
				cursor_set_column(column+1)
	if select_mode:
		select(selected_line, selected_column, cursor_get_line(), cursor_get_column())


func _on_Teclado_backspace_pressed():
	$"../../../Sound".play_sound("Keyboard")
	# eh preciso lidar diretamente com o texto cru
	# tambem eh preciso saber onde o cursor esta em relaçao ao texto
	var text_selected = ""
	if is_selection_active():
		cursor_set_column(get_selection_from_column())
		cursor_set_line(get_selection_from_line())
		text_selected = get_selection_text()
		print(text_selected)
	var line = cursor_get_line()
	var column = cursor_get_column()
	if line == 0:
		if column == 0 and not is_selection_active():
			return
		var t = text
		if is_selection_active():
			t.erase(column, text_selected.length())
			text = t
			save_code()
			cursor_set_line(0)
			cursor_set_column(column)
		else:
			t.erase(column-1, 1)
			text = t
			save_code()
			cursor_set_line(0)
			cursor_set_column(column-1)
	else:
		var splited = text.split("\n")
		var count = 0
		for i in range(line):
			count += splited[i].length()+1
		count += column
		var t = text
		if is_selection_active():
			t.erase(count, text_selected.length())
			text = t
			save_code()
			cursor_set_line(line)
			cursor_set_column(column)
		else:
			t.erase(count-1, 1)
			text = t
			if column == 0:
				save_code()
				cursor_set_line(line-1)
				cursor_set_column(get_line(line-1).length())
			else:
				save_code()
				cursor_set_line(line)
				cursor_set_column(column-1)
	emit_signal("deselect_text")


func _on_Teclado_char_typed(key):
	$"../../../Sound".play_sound("Keyboard")
	$"../../../Sound".play_sound(key)
	insert_text_at_cursor(key)
	save_code()
	emit_signal("deselect_text")


func _on_Teclado_select_pressed(pressed):
	if pressed:
		$"../../../Sound".play_sound("Keyboard")
		select_mode = true
		selected_line = cursor_get_line()
		selected_column = cursor_get_column()
	else:
		select_mode = false
		selected_line = 0
		selected_column = 0
		deselect()
