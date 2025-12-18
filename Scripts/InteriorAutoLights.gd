extends TileMap

var windows = get_used_cells_by_id(0,0,Vector2(1,0))
var source:TileSetAtlasSource = tile_set.get_source(0) as TileSetAtlasSource
var rect = source.get_tile_texture_region(Vector2(1,0))
var image:Image = source.get_texture().get_image()
var tile_image:Image = image.get_region(rect)
func _ready() -> void:
	for i in tile_image.get_height():
		for i2 in tile_image.get_width():
			if tile_image.get_pixel(i2,i) == Color.TRANSPARENT:
				tile_image.set_pixel(i2,i,Color.WHITE)
			else:
				tile_image.set_pixel(i2,i,Color.TRANSPARENT)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	for vec in windows:
		for i in range(-8,8):
			var worldPos = (map_to_local(vec)) + Vector2(-8,-8)
			draw_texture(ImageTexture.create_from_image(tile_image),worldPos)
