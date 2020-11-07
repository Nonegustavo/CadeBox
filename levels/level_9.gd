extends Node

const title = "#9 ZERO AQUI NÃO"
const task = "Retorne todos os números lidos para a saída, com exceção dos zeros."
const mode = "level"
const challenge = false
const cells = 4
const max_instructions = INF
const forbidden_cmd = ["?", "!"]

var rng = RandomNumberGenerator.new()

func generate_test():
	var test = {
		input = [],
		output = [],
		cells = []
	}
	var pool = [0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
	for _i in range(20):
		var a = pool[rng.randi_range(0, pool.size()-1)]
		test.input.append(a)
		if a != 0:
			test.output.append(a)
	if test.cells.size() == 0:
		var a = rng.randi_range(1,9)
		test.input.append(a)
		test.output.append(a)
	return test
