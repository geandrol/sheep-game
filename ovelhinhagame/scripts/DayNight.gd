extends CanvasModulate

var tempo=0


func _process(delta):

	tempo+=delta

	if tempo<30:

		color=Color(1,1,1)

	elif tempo<60:

		color=Color(
		0.4,
		0.4,
		0.7
		)

	else:

		tempo=0
