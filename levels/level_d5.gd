extends Node

const title = "#D5 - O PRODUTO FINAL(2)"
const task = "A cada dois numeros lidos, multiplique um pelo outro e coloque o resultado na saída. Agora você tem apenas 2 células para utilizar."
const mode = "level"
const challenge = true
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
		var a = rng.randi_range(0, 10)
		var b = rng.randi_range(0, 10)
		test.input.append(a)
		test.input.append(b)
		test.output.append(a*b)
	return test
