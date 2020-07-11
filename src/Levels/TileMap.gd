extends TileMap

var last_infected
var old_infected
var last_tick = 0
var cures = 0


func _ready():
	$Timer.connect("timeout", self, "on_tick")
	
func _process(_delta):
	pass

func on_tick():
	kill_infected(old_infected)
	old_infected = last_infected
	var infected_cells = self.get_used_cells_by_id(3)
	last_infected = infected_cells
	for infected_cell in infected_cells:
		var adjacent_cells = get_adjacent_cells(infected_cell)
		for adjacent_cell in adjacent_cells:
			var id = self.get_cell(adjacent_cell.x, adjacent_cell.y)
			if id == 2:
				self.set_cellv(adjacent_cell, 3)


func get_adjacent_cells(cell):
	var adjacent_cells = []
	adjacent_cells.append(Vector2(cell.x + 1, cell.y))
	adjacent_cells.append(Vector2(cell.x - 1, cell.y))
	adjacent_cells.append(Vector2(cell.x, cell.y + 1))
	adjacent_cells.append(Vector2(cell.x, cell.y - 1))
	return adjacent_cells


func kill_infected(cells):
	if cells:
		for cell in cells:
			self.set_cellv(cell, 1)


func _input(event):
	if event.is_action_pressed("click"):
		var mouse_pos = get_global_mouse_position()
		var tile_pos = self.world_to_map(mouse_pos)
		var tile_id = self.get_cell(tile_pos.x, tile_pos.y)
		if tile_id == 1:
			self.set_cellv(tile_pos, 4)
			cures += 1
		elif tile_id == 3:
			if cures > 0:
				self.set_cellv(tile_pos, 0)
				cures -= 1
