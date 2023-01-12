# Here's your task. Write Ruby code that:

# Converts this string ("Supercalifragilisticexpialidocious") into an array, where all the elements are alphabetically ordered
# Removes duplicate characters (e.g. "aba" => "ab")
# Converts the array back into a string

"Supercalifragilisticexpialidocious".downcase.chars.sort.uniq.join 
=> "acdefgiloprstux"

