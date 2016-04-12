#! /usr/bin/python

from __future__ import division
import copy
from fluid_visualization import plot_density_grids

time_limit = 20 # the number of time steps to simulate
size = 39 # the width and height of the simulation area in elements
fluid_diffusion_rate = 0.001 # how quickly the fluid spreads through its medium
flow_diffusion_rate = 0.001 # how quickly flows spread through the medium (a measure of viscosity)
stencil = [[2, 0], [0, 2], [-2, 0], [0, -2]]

# Compute the weighted average of start and end, with higher weights favoring end.
def interpolate(start, weight, end):
	return start * (1 - weight) + end * weight

# *** Define other functions here. ***
pass

# Initialize the fluid to be absent except for a constant supply on the lower border.
fluid = [[0 for y in range(size)] for x in range(size)]
for x in range(size):
	fluid[x][0] = 1

# Initialize the flow to spiral counterclockwise around the center.
x_flow = [[(size / 2 - y) / size / 1.5 for y in range(size)] for x in range(size)]
y_flow = [[(x - size / 2) / size / 1.5 for y in range(size)] for x in range(size)]

# Add a fairly strong source of the fluid at the center, but nowhere else.
fluid_sources = [[0 for y in range(size)] for x in range(size)]
fluid_sources[size // 2][size // 2] = 4

# Introduce counterclockwise stirring about the center to keep the spinning going.
x_flow_sources = [[(size / 2 - y) / size / 1.5 for y in range(size)] for x in range(size)]
y_flow_sources = [[(x - size / 2) / size / 1.5 for y in range(size)] for x in range(size)]

# The simulation.

results = [copy.deepcopy(fluid)] # a list of grids, one for each time step
for step in range(time_limit):
	# *** Put code to update the fluid, x_flow, and y_flow variables here. ***
	pass
	# Add a copy of the fluid grid to the result list.
	results.append(copy.deepcopy(fluid))

# Show all of the grids in an animation.
plot_density_grids(results)
