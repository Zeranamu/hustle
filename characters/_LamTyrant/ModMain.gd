extends Node

func _init(modLoader = ModLoader):
	  print("The Iceperor")
	  modLoader.installScriptExtension("res://_LamTyrant/CharacterSelect.gd")

func _ready():
	  print("Frozen")
