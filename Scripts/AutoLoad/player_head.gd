extends Node

#----------------
#   HEART UI
#----------------
#variables
var _heart_ui : HeartUI

#functions
func is_heart_ui_connected() -> bool: #check if this script's heart ui variable is filled
	return _heart_ui != null

func connect_heart_ui(heart_ui : HeartUI): #fill this scripts heart ui variable
	_heart_ui = heart_ui

func get_heart_ui() -> HeartUI:
	return _heart_ui


#----------------
#     BODY(s)
#----------------
#variables
var _body_1 : Player
var _body_2 : Player

#functions
func is_body_connected(num) -> bool: #check if this script's body variable is filled
	if num == 1: return _body_1 != null
	if num == 2: return _body_2 != null
	return false

func connect_body(body : Player, num): #fill this scripts body variable
	if num == 1: _body_1 = body
	if num == 2: _body_2 = body

func get_body(num) -> Player:
	if num == 1: return _body_1
	if num == 2: return _body_2
	return null

#----------------
#     HEALTH
#----------------
#variables
const MAX_HEALTH = 6
var _health : float = MAX_HEALTH

#functions
func get_health() -> float:
	return _health

func take_damage(amount : float):
	_health -= amount
	_post_health_change()

func heal(amount : float):
	_health += amount
	_post_health_change()

func _post_health_change():
	if _health < 0: _health = 0
	if _health > MAX_HEALTH : _health = MAX_HEALTH
	_heart_ui.update_hearts()

func is_alive(): #poke player with stick and see if it moves
	return _health > 0
