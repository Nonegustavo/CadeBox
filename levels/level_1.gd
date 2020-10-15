extends Node

const title = "#1 - MAS SÃO TANTOS!"
const task = "Pegue TODOS os números da entrada e coloque-os na saída."
const mode = "level"
const cells = 4
const max_instructions = INF
const forbidden_cmd = ["<",">",".",":","@","+","-","/","\\", "[", "]", "?", "!"]

var rng = RandomNumberGenerator.new()

func generate_test():
	var test = {
		input = [],
		output = [],
		cells = []
	}
	for _i in range(rng.randi_range(8, 16)):
		var a = rng.randi_range(0, 99)
		var b = rng.randi_range(0, 99)
		test.input.append(a)
		test.output.append(a)
	return test
