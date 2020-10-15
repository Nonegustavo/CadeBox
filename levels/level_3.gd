extends Node

const title = "#3 - AQUELE ALI"
const task = "Pegue o número que está na terceira célula e coloque-o na saída."
const mode = "level"
const cells = 4
const max_instructions = INF
const forbidden_cmd = ["~",".","@","+","-","/","\\", "[", "]", "?", "!"]

var rng = RandomNumberGenerator.new()

func generate_test():
	var test = {
		input = [],
		output = [],
		cells = []
	}
	var a = rng.randi_range(0, 99)
	test.cells = [0, 0, a]
	test.output.append(a)
	return test
