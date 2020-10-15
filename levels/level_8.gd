extends Node

const title = "#8 - MAPA DO TESOURO"
const task = "Para cada número lido, retorne o número que está na célula correspondente.\n\nA contagem inicia em zero."
const mode = "level"
const cells = 12
const max_instructions = INF
const forbidden_cmd = ["?", "!"]

var rng = RandomNumberGenerator.new()

func generate_test():
	var test = {
		input = [],
		output = [],
		cells = []
	}
	for _i in range(10):
		test.cells.append(rng.randi_range(1, 99))
	for _i in range(10):
		var a = rng.randi_range(0, 9)
		test.input.append(a)
		test.output.append(test.cells[a])
	return test
