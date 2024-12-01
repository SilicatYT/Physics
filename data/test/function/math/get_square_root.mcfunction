# Get the square root of a number (Method by Triton365)
# LOAD: {
#     scoreboard objectives add val dummy
#     scoreboard players set #c2 val 2
#     scoreboard players set #c141 val 141
#     scoreboard players set #c7775 val 7775
#     scoreboard players set #c100000 val 100000
# }

# INPUT: scoreboard players set #square_root.in val <x>

# NOTE: sqrt(49) = 7 here, but sqrt(48) = 6 (because it floors). You can scale it up, but only by increments of 100. So sqrt(490) is not desirable, but sqrt(4900) = 70 (Multiplying the input by 100 multiplies the output by 10)

execute store result score #temp.2 val run scoreboard players operation #temp.1 val = #square_root.in val
execute if score #square_root.in val matches 0..19310 run function physics:zprivate/math/get_square_root/0
execute if score #square_root.in val matches 19311..1705544 run function physics:zprivate/math/get_square_root/1
execute if score #square_root.in val matches 1705545..39400514 run function physics:zprivate/math/get_square_root/2
execute if score #square_root.in val matches 39400515..455779650 run function physics:zprivate/math/get_square_root/3
execute if score #square_root.in val matches 455779651..2147483647 run function physics:zprivate/math/get_square_root/4

scoreboard players operation #temp.2 val /= #square_root.out val
scoreboard players operation #square_root.out val += #temp.2 val
scoreboard players operation #square_root.out val /= #c2 val
scoreboard players operation #square_root.in val /= #square_root.out val
execute if score #square_root.out val > #square_root.in val run scoreboard players remove #square_root.out val 1

# OUTPUT: scoreboard players get #square_root.out val
