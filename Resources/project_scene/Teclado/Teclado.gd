extends Control

var select_mode : bool = false

signal char_typed(s)
signal arrow_pressed(s)
signal select_pressed(s)
signal backspace_pressed()
signal action_pressed(s)


func _on_Shift_pressed() -> void:
	$Principal.visible = not $Principal.visible
	$Alfabeto.visible = not $Alfabeto.visible


func _on_Select_pressed() -> void:
	select_mode = not select_mode
	$Geral/Select.pressed = select_mode
	emit_signal("select_pressed", select_mode)


func _on_Char_pressed(arg):
	arg = "\n" if arg == "*" else arg
	emit_signal("char_typed", arg)


func _on_Arrow_pressed(arg):
	emit_signal("arrow_pressed", arg)


func _on_Backspace_pressed():
	emit_signal("backspace_pressed")


func _on_Action_pressed(arg):
	emit_signal("action_pressed", arg)


func _on_Text_deselect_text():
	select_mode = false
	$Geral/Select.pressed = false
	emit_signal("select_pressed", false)
