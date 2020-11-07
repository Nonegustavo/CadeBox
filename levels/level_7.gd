extends Node

const title = "#7 - INICIAR LANÇAMENTO"
const task = "Para cada número lido, retorne ele e todos os números anteriores a ele até chegar a 0, como em uma contagem regressiva.\n\nVocê precisará dos novos comandos [color=black][[/color] e [color=black]][/color]."
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
	for _i in range(5):
		var a = rng.randi_range(1, 10)
		test.input.append(a)
		for i in range(a, -1, -1):
			test.output.append(i)
	return test
