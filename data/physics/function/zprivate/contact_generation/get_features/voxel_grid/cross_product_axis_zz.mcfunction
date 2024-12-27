# Additional command that was skipped in the previous function
scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.zz Physics

# Get the object's feature (Edge that's closest to the world-geometry voxel)
# (Important): The edge is perpendicular to the axis with the minimum overlap, so it projects onto a single point. Meaning I only have to look at 1 corner point of each of the 4 candidate edges to see which one is closer to the world-geometry voxel's projection range.

# Get the world-geometry voxel's feature (Edge that's closest to the object)
# (Important): The edge is perpendicular to the axis with the minimum overlap, so it projects onto a single point. Meaning I only have to look at 1 corner point of each of the 4 candidate edges to see which one is closer to the object's projection range.
