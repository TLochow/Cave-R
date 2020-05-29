extends Node

var CameraShake = 0.0

func map(value, minValue, maxValue, minResult, maxResult):
	return ((maxResult - minResult) * ((value - minValue) / (maxValue - minValue))) + minResult
