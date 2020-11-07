extends Node

const title = "#18 - NÚMERO.ZIP"
const task = "Para cada lista terminada em -1, retorne-a como um único número. Por exemplo, se for [3, 2, 2, -1], retorne 322.\n\nO velho conhecido 0 foi trocado para -1 por motivos de: não conseguiríamos ler um número com dígito 0."
const mode = "level"
const challenge = false
const cells = 2
const max_instructions = INF
const forbidden_cmd = []

var rng = RandomNumberGenerator.new()

func generate_test():
	var test = {
		input = [],
		output = [],
		cells = []
	}
	for _i in range(5):
		var res = 0
		for i in range(rng.randi_range(1, 3)):
			var a = rng.randi_range(0, 9)
			res = res*10 + a
			test.input.append(a)
		test.input.append(-1)
		test.output.append(res)
	return test
