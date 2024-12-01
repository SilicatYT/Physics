# Tellraw
tellraw @a "Physics Engine >> Reloaded\nExternal help:\n-Triton365: Fast square root (If it's faster than the marker method, but I heavily assume so)\n-SuperSword: Fast magnitude"
tellraw @a "Fast square root is currently unused"

data modify storage physics:zprivate util.normalize.Pos set value [0.0d,0.0d,0.0d]
function physics:zprivate/util/get_magnitude/load
# Note: Also add the scores necessary for the triton sqrt
scoreboard players set #c1000 val 1000
