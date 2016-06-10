class Astar

    START  = 0
    FLATLAND = 1
    FOREST = 2
    MOUNTAIN = 3
    WATER = nil
    attr_accessor :x, :y, :x_current, :y_curent

    terrain_hash = {"start" => "@","flatland" => ".", "forest" => "*", "mountain" => "^", "water" =>"~"}
    navigation_costs_hash = {"@" => "1", "." => "1", "*" => "2", "^" => "3", "X" => "1"} #travel cost mapping

    
    
    def initialize(start, goal)
        #create start and goal nodes
        @start_node = Astar_Node.new(start['x'], start['y'] , -1, -1,-1, -1)
        @goal_node = Astar_Node.new(goal['x'], goal['y'] , -1, -1,-1, -1)
        
        @open_nodes = [] #nodes available for inspection
        @closed_nodes = [] #already visted nodes
        
        @open_nodes.push(@start_node)
        
    end
        
    #method to calculate heuristic, using the Manhattan distance formula
    def determine_heuristic(current_node, next_node)
          return (Math.sqrt( ((current_node.x - next_node.x) **2 ) + ((current_node.y - next_node.y) **2))).floor      
    end
    
    #determine which cell is next
    def findBestMove()

    end
    
    
    def detertmineMovementCost(next_node)
        return navigation_costs_hash["next_node"] #map value of next node to the cost
    end

    #check whether you can move north, east, south or west
    def searchWalkable() 
        while @open_nodes.size > 0  do
             # grab the lowest f(x)
	       low_i = 0
            for i in 0..@open_nodes.size-1
                if @open_nodes[i].f < @open_nodes[low_i].f then
                    low_i = i
                end
            end
            best_node = low_i

        # set current node
        current_node = @open_nodes[best_node]

        # check if we've reached our goall
        if (current_node.x == @goal_node.x) and (current_node.y == @goal_node.y) then
            path = [@goal_node]

            # recreate the path
            while current_node.i != -1 do
                current_node = @closed_nodes[current_node.i]
                path.unshift(current_node)
            end

            return path
        end

        # remove the current node from open node list
        @open_nodes.delete_at(best_node)

        # and push onto the closed nodes list
        @closed_nodes.push(current_node)

       

        # if the new node is passable or our goal
            if ((current_node)!=terrain_hash["water"]? or (nx == @goal_node.x and ny == @goal_node.y)) then
            # check if the node is already in closed nodes list
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
            new_node.set_g(current_node.g + cost(current_node, new_node))
            new_node.set_h(heuristic(new_node, @goal_node))
            new_node.set_f(new_node.g + new_node.h)

            @open_nodes.push(new_node)
            end
            end
        end
        end
	
	   return [] # return empty path
                
    end
    
end

#node representation class 
class Astar_Node
    #full_cost = g+h
    #full_cost is the cost from start to goal going through cueent node
    #heurisric is the cost from currnt node to goal node, irrespective of the obstacles
    #g_cost is cost from start to current node
    attr_accessor :x, :y, :parent_index, :g_cost, :heuristic, :full_cost

    def initialize(x,y,parent_index,g_cost,heuristic, full_cost)
        @x = x
        @y = y
        @parent_index = parent_index
        @g_cost = g_cost
        @heuristic = heuristic
        @full_cost = full_cost
    end
end
            
