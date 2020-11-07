extends Node

const title = "#2 - COM LICENÇA"
const task = "Leia dois números da entrada e retorne-os ao contrário para a saída. Repida até acabar os números da entrada.\n\nAgora você tem os comandos [color=black].[/color], [color=black]:[/color] e [color=black]@[/color]. Veja no manual o que eles fazem!"
const mode = "level"
const challenge = false
const cells = 4
const max_instructions = INF
const forbidden_cmd = ["<",">","+","-","/","\\", "[", "]", "?", "!"]

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
