extends Window

var board: Array
var solved_case: Array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0]
var tiles: Array
var empty_pos: int
var freeze: bool = true
var start_pos: Vector2 = Vector2(9, 11)

var tile_path = preload("res://Scenes/scn_tile.tscn")

func _ready():
	start()

func start():
	board = solved_case.duplicate()
	board.shuffle()
	await set_tiles()
	await get_tree().create_timer(1).timeout
	for i in board.size()-1:
		if board[i] == 0:
			swap(i, 15)
			break
	await get_tree().create_timer(1).timeout

	check_parity()
	empty_pos = 15
	freeze = false
	print_board()

func check_parity():
	var count = 0
	for i in 15:
		for j in range(i+1, 16):
			if board[i] != 0 and board[j] != 0 and board[i] > board [j]:
				count += 1
	
	if count % 2 != 0:
		swap(0, 1)

func set_tiles():
	for i in range(0, 16):
		if board[i] == 0:
			var empty_tile = Node2D.new()
			add_child(empty_tile)
			tiles.append(empty_tile)
			continue
		
		var tile = tile_path.instantiate()
		add_child(tile)
		tiles.append(tile)

		tile.get_child(0).text = str("[center]", board[i], "[/center]")
		tile.position = start_pos + Vector2(i%4, i/4)*11


func _process(_delta):
	if freeze:
		return

	if Input.is_action_just_pressed("slider_left"):
		slider_left()
	elif Input.is_action_just_pressed("slider_right"):
		slider_right()
	elif Input.is_action_just_pressed("slider_up"):
		slider_up()
	elif Input.is_action_just_pressed("slider_down"):
		slider_down()

	if board == solved_case:
		solve()

func slider_up():
	if empty_pos >= 12:
		return

	swap(empty_pos, empty_pos+4)
	print_board()

func slider_down():
	if empty_pos <= 3:
		return

	swap(empty_pos, empty_pos-4)
	print_board()

func slider_right():
	if empty_pos % 4 == 0:
		return

	swap(empty_pos, empty_pos-1)
	print_board()

func slider_left():
	if empty_pos % 4 == 3:
		return

	swap(empty_pos, empty_pos+1)
	print_board()

func swap(x, y):
	var temp = board[x]
	board[x] = board[y]
	board[y] = temp

	temp = tiles[x]
	tiles[x] = tiles[y]
	tiles[y] = temp
	tiles[y].position = start_pos + Vector2(y%4, y/4)*11
	tiles[x].position = start_pos + Vector2(x%4, x/4)*11


	empty_pos = y

func print_board():
	var line: String = ""
	for i in board.size():
		line += str(board[i], ", ")
		if i % 4 == 3:
			line +="\n"
	print(line)

func solve():
	print("solved")
	freeze = true
