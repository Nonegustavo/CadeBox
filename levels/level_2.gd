extends Node

const title = "#2 - COM LICENÇA"
const task = "A cada dois numeros lidos, retorne-os em ordem inversa."
const mode = "level"
const cells = 4
const max_instructions = INF
const forbidden_cmd = ["+","-","/","\\", "[", "]", "?", "!"]

var rng = RandomNumberGenerator.new()

func generate_test():
	var test = {
		input = [],
		output = [],
		cells = []
	}
	for _i in range(5):
		var a = rng.randi_range(0, 99)
		var b = rng.randi_range(0, 99)
		test.input.append(a)
		test.input.append(b)
		test.output.append(b)
		test.output.append(a)
	return test
