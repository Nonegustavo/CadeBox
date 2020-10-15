extends Node

const title = "#14 - O PRODUTO FINAL"
const task = "A cada dois numeros lidos, multiplique um pelo outro e coloque o resultado na saida."
const mode = "level"
const cells = 8
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
		var a = rng.randi_range(0, 10)
		var b = rng.randi_range(0, 10)
		test.input.append(a)
		test.input.append(b)
		test.output.append(a*b)
	return test
