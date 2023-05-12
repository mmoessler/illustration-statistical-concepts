
#import os
from svgutils.compose import SVGFigure
from svgutils.compose import SVG

# Create a new SVGFigure object
fig = SVGFigure()

# Load the individual SVG files
fig1 = SVG("plot_01_b2-1_rho-2.svg")
fig2 = SVG("plot_01_b2-1_rho-4.svg")
fig3 = SVG("plot_01_b2-1_rho-6.svg")

# Add each individual SVG file to the new SVGFigure object
fig.append([fig1, fig2, fig3])

# Save the combined SVG file
#print(os.getcwd())
fig.save("combined.svg")
