extends Control

var pages = [
	"[center][img=200]res://images/cadebox-logo-mini.png[/img][/center]\n\nParabéns por adquirir o seu CadeBox!\n\nVocê nunca mais precisará carregar um pesado computador para onde você for.\n\nTodas as facilidades de um computador agora em seu bolso!",
	"Seu dispositivo vem equipado com o interpretador Brainfire, uma poderosa tecnologia que permite que você mesmo programe o que seu pequeno computador de bolso fará.\n\nSomar números? Multiplicar números? Encontrar o último dígito de pi?\n\nO céu é o limite!",
	"Antes de tudo, você precisa se familiarizar com a arquitetura do CadeBox.\n\nVocê tem à sua disposição um registrador e uma fita. Enquanto no registrador você armazena apenas um valor por vez, na fita você pode colocar quantos valores quiser[color=red]*[/color], mas apenas um por célula.\n\n[color=red]*[/color][color=grey]Se quiser poucos valores[/color]",
	"Tanto o registrador como as células da fita podem armazenar valores de [color=black]-999[/color] até [color=black]999[/color]. Todas são inicializadas com o valor [color=black]0[/color] para sua conveniência.\n\nA fita é o grande diferencial do CadeBox, nela há um cursor no qual você pode movimentar para a esquerda e para a direita.",
	"O cursor indica com qual célula você está trabalhando no momento.\n\n[center][img]res://images/machine.png[/img][/center]\nAcima a célula atual é a primeira.\n\n[center][img]res://images/machine2.png[/img][/center]\nAgora é a terceira.",
	"O interpretador Brainfire funciona lendo cada caractere do seu código na ordem e respondendo de acordo.\n\nAqui cada caractere é poderoso! Chega de escrever longos códigos cheios de palavras!\n\nA seguir você verá quais são as funções de cada caractere.",
	"[color=red]~[/color] lê um valor da entrada\n  e coloca no\n  registrador.\n\n[color=red]^[/color] envia o valor do\n  registrador para a\n  saída.\n\n[color=red]#[/color] faz a leitura do código\n  voltar para o início.\n  Útil para fazer um loop\n  infinito!",
	"[color=red].[/color] copia o valor do\n  registrador para a\n  célula atual da fita.\n\n[color=red]:[/color] copia o valor da célula\n  atual da fita para o\n  registrador.\n\n[color=red]@[/color] troca o valor do\n  registrador pelo da\n  fita.",
	"[color=red]>[/color] movimenta o cursor para\n  a próxima célula. Caso\n  ele já esteja mais à\n  direita, o registrador\n  fica 0.\n\n[color=red]<[/color] movimenta o cursor para\n  a célula anterior. Caso\n  ele já esteja mais à\n  esquerda, o registrador\n  fica 0.",
	"[color=red]+[/color] soma a célula atual com\n  o registrador e coloca\n  o resultado no\n  registrador.\n\n[color=red]-[/color] subtrai a célula atual\n  do registrador e\n  coloca o resultado no\n  registrador.\n\n[color=red]/[/color] soma 1 ao registrador\n\n[color=red]\\[/color] subtrai 1 do\n  registrador.",
	"[color=red]![/color] verifica se o\n  registrador é 0. Se\n  for, o registrador fica\n  com o valor 1, caso\n  contrário fica com 0.\n\n[color=red]?[/color] verifica se o\n  registrador é negativo.\n  Se for, o registrador\n  fica com o valor 1,\n  caso contrário fica com\n  0.",
	"[color=red][[/color] e [color=red]][/color] são ainda mais especiais. Quando [color=red][[/color] ou [color=red]][/color] for lido pelo Brainfire, ele verá se o registrador é 0 ou não.\n\n- Se for [color=black]0[/color], ele simplesmente irá para a instrução após o [color=red]][/color] correspondente.\n\n- Caso seja [color=black]qualquer outro número[/color], ele irá executar tudo que estiver entre [color=red][[/color] e [color=red]][/color]. ",
	"Com isso você pode pular seções inteiras de código ou executar a mesma seção várias vezes.\n\nDá até mesmo para colocar vários [color=red][][/color] dentro de um [color=red][][/color]!\n\nAs possibilidades são infinitas!",
	"Para facilitar sua codificação, o CadeBox vem equipado com um teclado adaptado para Brainfire.\n\nVocê tem fácil acesso aos 16 símbolos, além de opções para copiar, colar, recortar, desfazer erros e refazê-los também!\n\nBasta acessar a aba TECLADO.",
	"Além destes 16 poderosos caracteres, você pode colocar espaços, quebras de linha (vulgo enter) e também letras do alfabeto.\n\nTudo para deixar o seu código mais organizado e mais compreensível para humanos.\n\nPara acessar as letras, toque em [img]res://images/shift-red.png[/img] no seu teclado.",
	"Recomendamos que você abuse destes recursos de embelezamento de código para que você não se perca no que estiver fazendo.\n\nVeja um exemplo:\n\n[color=red]/////[@/////@\\]@^[/color]\n\nDeu tontura só de ver?\n\nQue tal assim:",
	"[color=red]///// cinco\n[ inicio do loop\n  @ troca pela celula\n  ///// mais cinco\n  @ troca de novo\n  \\ menos um\n] fim do loop\n@ troca\n^ mostra vinte e cinco[/color]\n\nMuito melhor! Lembre-se que as letras são completamente ignoradas pelo Brainfire.",
	"Nada te impede de escrever tudo em uma linha só, mas saiba o que você está fazendo!\n\nPor último, a aba TESTAR é onde você pode testar se o seu código faz o que você quer ele que ele faça.\n\nToque no [url={\"data\"=\"play\"}]play[/url] e boa sorte!"
]

var secret = "Nada te impede de escrever tudo em uma linha só, mas saiba o que você está fazendo!\n\nPor último, a aba TESTAR é onde você pode testar se o seu código faz o que você quer ele que ele faça.\n\nToque no play e boa sorte!\n\n [shake rate=20 level=10][color=red]Não neste![/color][/shake]"
var actual_page = 0

func _on_Close_pressed():
	$Sound.play_sound("Manual")
	hide()

func _ready():
	update_page()

func _on_Left_pressed():
	if actual_page > 0:
		$Sound.play_sound("Page")
		actual_page -= 1
		update_page()


func _on_Right_pressed():
	if actual_page < pages.size()-1:
		$Sound.play_sound("Page")
		actual_page += 1
		update_page()

func update_page():
	$Manual/Panel/VBox/Body.bbcode_text = pages[actual_page]
	$Manual/Panel/VBox/Footer/Pagina.text = "%d/%d" % [actual_page+1, pages.size()]
	$Manual/Panel/VBox/Footer/Left.disabled = actual_page == 0
	$Manual/Panel/VBox/Footer/Right.disabled = actual_page == pages.size()-1


func _on_Body_meta_clicked(_meta):
	$Manual/Panel/VBox/Body.bbcode_text = secret
