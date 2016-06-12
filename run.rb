#first we need to read the map and convert it to a 2D array
#module Run
	def loadMap(file)
		navigation_map = File.readlines(file)[0..-1].map do |line|
			line.chomp.split("").map(&:to_s)
		end 
	end
	nav_map = loadMap("large_map.txt")
	print nav_map


	
	#start = { x, 'y' }
	#goal = { 'x', 'y'  }
	#pathfinder  = Astar.new(start, goal)
	#result      = astar.findPath # returns path Array
#end