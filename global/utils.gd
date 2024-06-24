extends Node

## Returns a string with the array elements formatted according to the format string.
func format_array(array: Array, format: String) -> String:
	var result = "["
	format = format.strip_edges()

	for i in range(array.size()):
		result += format % array[i]
		if i < array.size() - 1:
			result += ", "
	result += "]"

	return result
