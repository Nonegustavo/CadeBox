extends Node

const title = "#D6 - O PRODUTO FINAL(2) AGORA VAI"
const task = "A cada dois numeros lidos, multiplique um pelo outro e coloque o resultado na saida. Agora com números negativos também!"
const mode = "level"
const challenge = true
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
		var a = rng.randi_range(-10, 10)
		var b = rng.randi_range(-10, 10)
		test.input.append(a)
		test.input.append(b)
		test.output.append(a*b)
	return test
