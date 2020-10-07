extends HBoxContainer

func _on_Tab_pressed(arg : int):
	match arg:
		0:
			$Tarefa.disabled = true
			$Teclado.disabled = false
			$Testar.disabled = false
			$"../Panels/Tarefa".visible = true
			$"../Panels/Teclado".visible = false
			$"../Panels/Testar".visible = false
		1:
			$Tarefa.disabled = false
			$Teclado.disabled = true
			$Testar.disabled = false
			$"../Panels/Tarefa".visible = false
			$"../Panels/Teclado".visible = true
			$"../Panels/Testar".visible = false
		2:
			$Tarefa.disabled = false
			$Teclado.disabled = false
			$Testar.disabled = true
			$"../Panels/Tarefa".visible = false
			$"../Panels/Teclado".visible = false
			$"../Panels/Testar".visible = true
