extends Node2D

const N = 1
const E = 2
const S = 4
const W = 8

var cell_walls = {
	Vector2i(0, -1): N, 
	Vector2i(1, 0): E, 
	Vector2i(0, 1): S, 
	Vector2i(-1, 0): W
}

var wall_data = {}

var layer = 0
var source_id = 1 #???
var atlus_coords = [
	Vector2i(2,1),
	Vector2i(1,0),
	Vector2i(2,0),
	Vector2i(3,0),
	Vector2i(0,1),
	Vector2i(1,1),
	Vector2i(0,0),
	Vector2i(3,1),
	Vector2i(0,2),
	Vector2i(1,2),
	Vector2i(2,2),
	Vector2i(3,2),
	Vector2i(0,3),
	Vector2i(1,3),
	Vector2i(2,3),
	Vector2i(3,3),
]

var tile_size = 64  # tile size (in pixels)
var width  # width of map (in tiles)
var height  # height of map (in tiles)

# get a reference to the map for convenience
@onready var Map = $TileMapLayer
@onready var addons = get_parent().get_node("MazeAddon")
@onready	 var main = get_parent()
func _ready():
	randomize()
	tile_size = Map.tile_set.tile_size
	await addons.ready
	await main.updated

	width = Global.maze_size # width of map (in tiles)
	height = Global.maze_size # height of map (in tiles)
	make_maze()

func check_neighbors(cell, unvisited):
	# returns an array of cell's unvisited neighbors
	var list = []
	for n in cell_walls.keys():
		if cell + n in unvisited:
			list.append(cell + n)
	return list
	
func make_maze():
	var unvisited = []  # array of unvisited tiles
	var stack = []
	wall_data.clear()
	# fill the map with solid tiles
	Map.clear()
	for x in range(width):
		for y in range(1, height+1):
			var pos = Vector2i(x, y)
			unvisited.append(pos)
			Map.set_cell(pos, source_id, atlus_coords[15])
			wall_data[pos] = 15
	var current = Global.player_pos
	unvisited.erase(current)
	# execute recursive backtracker algorithm
	while unvisited:
		var neighbors = check_neighbors(current, unvisited)
		if neighbors.size() > 0:
			var next = neighbors[randi() % neighbors.size()]
			stack.append(current)
			# remove walls from *both* cells
			var dir = next - current
			wall_data[current] &= ~cell_walls[dir]
			wall_data[next] &= ~cell_walls[-dir]
			Map.set_cell(current, source_id, atlus_coords[wall_data[current]])
			Map.set_cell(next, source_id, atlus_coords[wall_data[next]])
	
			current = next
			unvisited.erase(current)
		elif stack:
			current = stack.pop_back()
		#await get_tree().process_frame
