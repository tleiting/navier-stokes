import math
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import matplotlib.ticker

def plot_density_grids(grids, bin_count = 20):
	figure = plt.figure()
	color_map = plt.get_cmap('pink')
	color_levels = matplotlib.ticker.MaxNLocator(nbins = bin_count).tick_values(0, max(cell for grid in grids for column in grid for cell in column))
	def animate(t):
		z = np.transpose(np.array(grids[t]))
		y, x = np.mgrid[slice(z.shape[1]), slice(z.shape[0])]
		return plt.contourf(x, y, z, levels = color_levels, cmap = color_map)
	loop = animation.FuncAnimation(figure, animate, frames = len(grids))
	plt.show()
