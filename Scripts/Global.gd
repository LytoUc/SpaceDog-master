extends Node2D

var coins := 0 :
	set(val):
		coins = val
		if player != null:
			player.actualizaInterfazCoins()
	get:
		return coins

var player
