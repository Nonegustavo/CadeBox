extends Control

var select_mode = false


func _on_Shift_pressed() -> void:
	$Principal.visible = not $Principal.visible
	$Alfabeto.visible = not $Alfabeto.visible


func _on_Select_pressed() -> void:
	select_mode = not select_mode
	$Principal/Select.pressed = select_mode
	$Alfabeto/Select.pressed = select_mode
