
class AstarPathfinder

	def initialize(start, goal)
	    # create start and destination nodes
	    @start_node = Astar_Node.new(start['x'],   start['y'],  -1, -1, -1, -1)
	    @goal_node  = Astar_Node.new(goal['x'], goal['y'], -1, -1, -1, -1)

	    @open_nodes   = [] # conatins all open nodes (nodes to be inspected)
	    @closed_nodes = [] # contains all closed nodes (node we've already inspected)

	    @open_nodes.push(@start_node) # push the start node
  	end

	  #define a terrain CONTANTS
	  START  = "S"
	  PLAINS = "."
	  FOREST = "*"
	  MOUNTAIN = "^"
	  WATER = "~"
	  #define a terrain cost hash
	  TERRAIN_COST = {
      '@' => :start, 'X' => :goal,
      '.' => 1, '*' => 2, '^' => 3
  	  }.freeze

  	#check if area is walkable 
	def walkable(testNodeValue)
		return  WATER != testNodeValue 
	end

	#calucualte the distance from the current node to the goal node
	#this value will decrease the closer we get to our goal

	def determineHeuristic(currentNode,goalNode )
		return ((currentNode.x - goalNode.x) + (currentNode.y - goalNode.y)).abs
	end

	#calculate total cost F= g+ h
	def determineFcost(newNode)
		return newNode.gCost + newNode.hCost
	end
	def goalReached(nx,ny)
		return nx == @goalNode.x && ny == @goalNode.y
	end

	# expand node in all 4 directions
	def getNeighbours(current_node)
		x   = current_node.x
		y   = current_node.y

		return [ [x, (y - 1)],  # north
	         [x, (y + 1)],  # south
	         [(x + 1), y],  # east
	         [(x - 1), y] ] # west
	end

	
	#method to draw the path travelled to reach goal node
	def drawPath(start_node,goalNode)
		path = []
		current_node = goalNode

		while current_node != start_node do
			path.unshift(current_node)
			current_node = current_node.parent
		end

		return path.reverse #reverse order of the elements in the array so that oyu can start path from the top
	end
	

	#create a while loop to run as long as we have nodes in our open set
	def findPath
		while @open_nodes.size > 0 do
			# grab the lowest f(x)
	      low_i = 0
	      for i in 0..@open_nodes.size-1
	        if @open_nodes[i].fCost < @open_nodes[low_i].fCost || (@open_nodes[i].fCost == open_nodes[low_i].fCost && @open_nodes[i].hCost == open_nodes[low_i].hCost) then
	          low_i = i
	        end
	      end
	      best_node = low_i

	      # set current node
	      current_node = @open_nodes[best_node]

	      # check if we've reached our destination
	      if goalReached(current_node.x ,current_node.y) then
	        path = drawPath(@start_node,@goalNode)
	        return path
	      end

	      #now we have to remove currnt node from open set and add it to closed se
	      @open_nodes.delete_at(best_node)
	      @closed_nodes.add(current_node)

	      #now we traverse all neighbour nodes that are not in the closed 
	      neighbours = getNeighbours(current_node) #array of neighbors
	      for n in 0..neighbours.size-1
	      	neighbor = neighbor_nodes[n]
	        nx       = neighbor[0] #grab the x value
	        ny       = neighbor[1] #grab the y value

	        if(walkable(nx,ny) && (!goalReached(nx,ny))
	        	in_closed = false
	          for j in 0..@closed_nodes.size-1
	            closed_node = @closed_nodes[j]
	            if nx == closed_node.x and ny == closed_node.y then
	              in_closed = true
	              break
	            end
	          end
	          next if in_closed

	          # check if the node is in the open nodes list
	          # if not, use it!
	          in_open = false
	          for j in 0..@open_nodes.size-1
	            open_node = @open_nodes[j]
	            if nx == open_node.x and ny == open_node.y then
	              in_open = true
	              break
	            end
	          end

	          unless in_open then
	            new_node = Astar_Node.new(nx, ny, @closed_nodes.size-1, -1, -1, -1)

	            # setup costs
	            new_node.gCost = current_node.gCost + cost(current_node, new_node)
	            new_node.hCost = determineHeuristic(new_node, @goalNode)
	            new_node.fCost = determineFcost(new_node)

	            @open_nodes.push(new_node)
	          end
	        end
	      end
		end
		return [] # return empty path
	end
	

end

#Class to represent each node
# Astar node representation
class Astar_Node

  #define getters and setters
  attr_accessor :x, :y, :parent, :gCost, :hCost, :fCost	
  # x = x-position
  # y = y-position
  # i = parent index
  # g = cost from start to current node
  # h = cost from current node to destination
  # f = cost from start to destination going through the current node
  def initialize(x, y, parent, gCost, hCost, fCost)
    @x = x
    @y = y
    @parent = parent
    @gCost = gCost
    @hCost = hCost
    @fCost = fCost
  end

end
