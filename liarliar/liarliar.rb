#!/usr/bin/ruby

def bfs(graph, start)
  # Keep track of visited vertices
  visited = {start => true}

  # Group vertices into two groups
  group1 = {start => true}
  group2 = {}

  # Maintain a FIFO queue for traversal
  queue = [start]
  
  while not queue.empty?
    u = queue.shift
    graph[u].keys.each {|v|
      unless visited[v]
        visited[v] = true

        # Mark the vertex to be in different group from neighbor
        group1[v] = true if group2[u]
        group2[v] = true if group1[u]
        queue.push(v)
      end
    }
  end

  [group1, group2]
end

=begin
If Alice accuses Bob, then
data = {
  'Alice' => { 'Bob' => true },
}
=end

data = {}

# Get and format input
n = gets.chomp.to_i

n.times {
  input = gets.chomp.split(/\s+/)
  accuser = input[0]
  num_guilties = input[1].to_i

  guilties = {}

  if num_guilties > 0
    num_guilties.times {
      guilty = gets.chomp

      guilties[guilty] = true
    }
  end

  data[accuser] = guilties
}

# Treat edges as undirected
start = nil
graph = {}

data.each_key {|u|
  start = u
  graph[u] ||= {}
  
  data[u].each_key {|v|
    graph[v] ||= {}
    graph[u][v] = graph[v][u] = true # u and v are connected
  }
}

group1, group2 = bfs(graph, start)
if group1.size > group2.size
  puts "#{group1.size} #{group2.size}"
else
  puts "#{group2.size} #{group1.size}"
end
