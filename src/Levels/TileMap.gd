extends TileMap

var last_infected
var old_infected
var last_tick = 0
var cures = 0
var rng = RandomNumberGenerator.new()
var zoom = Vector2(1, 1)
export var wait_time = 5
export var simulated = false
var last_tick_bad = false


func _ready():
	$Timer.connect("timeout", self, "on_tick")
	$Timer.wait_time = wait_time
	
	
func on_tick():
	if last_tick_bad:
		if not self.get_used_cells_by_id(3) and not simulated:
			print("Done!")
	last_tick_bad = true
	kill_infected(old_infected)
	old_infected = last_infected
	var infected_cells = self.get_used_cells_by_id(3)
	last_infected = infected_cells
	for infected_cell in infected_cells:
		var adjacent_cells = get_adjacent_cells(infected_cell)
		for adjacent_cell in adjacent_cells:
			var id = self.get_cell(adjacent_cell.x, adjacent_cell.y)
			if id == 2:
				last_tick_bad = false
				self.set_cellv(adjacent_cell, 3)
	get_parent().update_day()


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
			if self.get_cell(cell.x, cell.y) == 3:
				if rng.randi_range(1, 5) == 5 or get_parent().day == 4:
					last_tick_bad = false
					self.set_cellv(cell, 1)
				else:
					last_tick_bad = false
					self.set_cellv(cell, 4)


func _input(event):
	if event.is_action_pressed("click"):
		var mouse_pos = get_global_mouse_position()
		var tile_pos = self.world_to_map(mouse_pos)
		var tile_id = self.get_cell(tile_pos.x, tile_pos.y)
		if tile_id == 1:
			cures += 1
			get_parent().update_cure_counter(cures)
			self.set_cellv(tile_pos, 4)
		elif tile_id == 3:
			if cures > 0:
				self.set_cellv(tile_pos, 0)
				cures -= 1
				get_parent().update_cure_counter(cures)
	if event.is_action_pressed("ui_cancel") and not simulated:
		get_tree().change_scene("res://src/TitleScreen.tscn")
