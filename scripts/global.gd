extends Node

signal player_taken_damage

var player_position = Vector2.ZERO

var player_max_hp = 100
var player_current_hp = player_max_hp

var weapon_damage_strenght: float
