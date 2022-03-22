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
#     BODY
#----------------
#variables
var _body : Player

#functions
func is_body_connected() -> bool: #check if this script's body variable is filled
	return _body != null

func connect_body(body : Player): #fill this scripts body variable
	_body = body

func get_body() -> Player:
	return _body

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
