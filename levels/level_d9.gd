extends Node

const title = "#D9 - ESTOURO DE MEMÓRIA"
const task = "Leia duas listas terminadas em -1, processe-as como dois números, some-os e retorne cada um dos dígitos do resultado.\n\nExemplo, se forem lidos 2, 1, -1, 1, 0, 1, -1, você deve retornar 1, 2, 2. \n\nInfelizmente os números são muito maiores do que esse exemplo."
const mode = "level"
const challenge = true
const cells = 30
const max_instructions = INF
const forbidden_cmd = []

var rng = RandomNumberGenerator.new()

func generate_test():
	var test = {
		input = [],
		output = [],
		cells = []
	}
	var a = rng.randi_range(1,9)
	var b = rng.randi_range(1,9)
	test.input.append(a)
	a = str(a)
	for _i in range(rng.randi_range(3, 8)):
		var temp = rng.randi_range(0, 9)
		test.input.append(temp)
		a = a + str(temp)
	test.input.append(-1)
	test.input.append(b)
	b = str(b)
	for _i in range(rng.randi_range(3, 8)):
		var temp = rng.randi_range(0, 9)
		test.input.append(temp)
		b = b + str(temp)
	test.input.append(-1)
	var total = int(a) + int(b)
	for v in str(total):
		test.output.append(int(v))
	return test
