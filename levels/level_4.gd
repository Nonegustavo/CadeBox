extends Node

const title = "#4 - FUSÃO!"
const task = "Para cada dois números da entrada, retorne a soma e a subtração do primeiro número pelo segundo usando os comandos [color=black]+[/color] e [color=black]-[/color].\n\nVocê pode observar na aba TESTAR um exemplo de entradas e o que é esperado para a saída, seu programa deve retornar exatamente o que está alí, naquela ordem."
const mode = "level"
const challenge = false
const cells = 4
const max_instructions = INF
const forbidden_cmd = ["/","\\", "[", "]", "?", "!"]

var rng = RandomNumberGenerator.new()

func generate_test():
	var test = {
		input = [],
		output = [],
		cells = []
	}
	for _i in range(5):
		var a = rng.randi_range(0, 20)
		var b = rng.randi_range(0, 20)
		test.input.append(a)
		test.input.append(b)
		test.output.append(a+b)
		test.output.append(a-b)
	return test
