extends Node

const title = "#3 - AQUELE ALI"
const task = "Pegue o número que está na terceira célula e coloque-o na saída.\n\nAgora você tem acesso aos comandos [color=black]<[/color] e [color=black]>[/color]!"
const mode = "level"
const challenge = false
const cells = 4
const max_instructions = INF
const forbidden_cmd = ["@","+","-","/","\\", "[", "]", "?", "!"]

var rng = RandomNumberGenerator.new()

func generate_test():
	var test = {
		input = [],
		output = [],
		cells = []
	}
	var a = rng.randi_range(1, 99)
	test.cells = [0, 0, a]
	test.output.append(a)
	return test
