#first we need to read the map and convert it to a 2D array
#module Run
require_relative "AstarPathfinder"

	def loadMap(file)
		navigation_map = File.readlines(file)[0..-1].map do |line|
			line.chomp.split("").map(&:to_s)
		end 
	end
	nav_map = loadMap("large_map.txt")
	print nav_map

	
	start       = { 'x' => 0, 'y' => 0}
	goal = { 'x' => nav_map.length-1, 'y' => nav_map.length-1 }
	pathfinder  = AstarPathfinder.new(start, goal)
	result      = pathfinder.findPath     #returns path Array
	print result
#end