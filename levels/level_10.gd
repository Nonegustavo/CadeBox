extends Node

const title = "#10 - ACESSO VIP"
const task = "Leia todos os números e retorne apenas os números positivos.\n\nAgora você tem acesso aos comandos [color=black]![/color] e [color=black]?[/color]. Veja no manual o que eles fazem!"
const mode = "level"
const challenge = false
const cells = 4
const max_instructions = INF
const forbidden_cmd = []

var rng = RandomNumberGenerator.new()

func generate_test():
	var test = {
		input = [],
		output = [],
		cells = []
	}
	for _i in range(20):
		var a = rng.randi_range(-99, 99)
		test.input.append(a)
		if a > 0:
			test.output.append(a)
	if test.cells.size() == 0:
		var a = rng.randi_range(1, 99)
		test.input.append(a)
		test.output.append(a)
	return test
