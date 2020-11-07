extends Node

const title = "#11 - SOMA, SOMA, SOMA"
const task = "Para cada lista terminada em zero, retorne a soma de todos os elementos.\n\nO que é uma lista terminada em zero? É um conjunto de números lidos até encontrar um zero. Por exemplo, se forem lidos os valores 3, 2, 9, 0, 7, 1 e 0, nesta ordem, temos duas listas [3, 2, 9] e [7, 1]."
const mode = "level"
const challenge = false
const cells = 3
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
		var total = 0
		for i in range(0, rng.randi_range(3, 10)):
			var a = rng.randi_range(1, 10)
			total += a
			test.input.append(a)
		test.input.append(0)
		test.output.append(total)
	return test
