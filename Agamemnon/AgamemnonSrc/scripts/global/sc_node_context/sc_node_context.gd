extends Node

var player_name:String = "LosAngelous"
var player_rank:int = 1456
var player_tier:String="无段位"
var server_region:String="亚服"
var server_latency:int = 30
var season_name:String="1"
var season_left_days:int=50
func _ready() -> void:
	print("[ScNodeContext] ready, player = %s" % player_name)
