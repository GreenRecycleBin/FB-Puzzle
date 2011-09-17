#!/usr/bin/python

import re
import collections

def bfs(graph, start):
  # Keep track of visited vertices
  visited = {start: True}

  # Group vertices into two groups
  group1 = {start: True}
  group2 = {}

  # Maintain a FIFO queue for traversal
  queue = collections.deque()
  queue.append(start)
  
  while len(queue) > 0:
    u = queue.popleft()

    for v in graph[u].iterkeys():
      if not v in visited:
        visited[v] = True

        # Mark the vertex to be in different group from neighbor
        if u in group2:
          group1[v] = True 

        if u in group1:
          group2[v] = True 

        queue.append(v)

  return [group1, group2]

'''
If Alice accuses Bob, then
data = {
  'Alice': { 'Bob': True },
}
'''

data = {}

# Get and format input
n = int(raw_input())

for i in range(n):
  input = re.split('\s+', raw_input())
  accuser = input[0]
  num_guilties = int(input[1])

  guilties = {}

  if num_guilties > 0:
    for i in range(num_guilties):
        guilty = raw_input()

        guilties[guilty] = True

    data[accuser] = guilties

# Treat edges as undirected
start = None
graph = {}

for u in data.iterkeys():
  start = u

  if not u in graph:
    graph[u] = {}

  for v in data[u].iterkeys():
    if not v in graph:
      graph[v] = {}

    graph[u][v] = graph[v][u] = True # u and v are connected

group1, group2 = bfs(graph, start)

if len(group1) > len(group2):
  print '%d %d' % (len(group1), len(group2))
else:
  print '%d %d' % (len(group2), len(group1))
