extends Control

var enabled = true
var num = 0
var negative = false

signal newEntry(numero)

func disable_keyboard(arg : bool):
	$Zero.disabled = arg
	$Um.disabled = arg
	$Dois.disabled = arg
	$Tres.disabled = arg
	$Quatro.disabled = arg
	$Cinco.disabled = arg
	$Seis.disabled = arg
	$Sete.disabled = arg
	$Oito.disabled = arg
	$Nove.disabled = arg
	$Negativo.disabled = arg
	$Limpar.disabled = arg
	$Backspace.disabled = arg
	$Enter.disabled = arg
	$Tela/Label.text = "AGUARDANDO" if arg else "DIGITE"
	num = 0


func _on_Num_pressed(arg):
	if num <= -100 or num >= 100:
		return
	num = num * 10 + arg
	$Sound.play_sound("Numeric")
	updateLabel()


func _on_Neg_pressed():
	negative = not negative
	$Sound.play_sound("Numeric")
	updateLabel()


func _on_Clear_pressed():
	num = 0
	negative = false
	$Sound.play_sound("Numeric")
	updateLabel()


func _on_Backspace_pressed():
	num = num/10
	$Sound.play_sound("Numeric")
	updateLabel()


func _on_Enter_pressed():
	var neg = -1 if negative else 1
	emit_signal("newEntry", neg*num)
	num = 0
	negative = false
	$Sound.play_sound("Numeric")
	disable_keyboard(true)


func updateLabel():
	var symbol = "-" if negative else ""
	$Tela/Label.text = symbol + str(num)
