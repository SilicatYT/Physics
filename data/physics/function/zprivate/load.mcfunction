# Init
scoreboard objectives add Physics dummy
execute unless score #Physics.Init Physics matches 1 run function physics:zprivate/init

# Summon root display entity
summon minecraft:block_display ~ ~ ~ {UUID:[I;0,0,0,0],Tags:["Physics.Root"]}

# Tellraw
#tellraw @a ["",{"text":"Physics >> ","color":"#99EAD6"},{"text":"Made by CMDred","clickEvent":{"action":"open_url","value":"https://www.youtube.com/BluesProductionTeam"},"hoverEvent":{"action":"show_text","contents":[{"text":"YouTube: ","color":"dark_aqua"},{"text":"CMDred","color":"white"}]}},"\n",{"text":"Physics >> ","color":"#99EAD6"},"Get the latest updates: ",{"text":"Modrinth","color":"#5491F7","clickEvent":{"action":"open_url","value":"https://modrinth.com/datapack/placeholder"},"hoverEvent":{"action":"show_text","contents":["Open page"]}},", ",{"text":"GitHub","color":"#5491F7","clickEvent":{"action":"open_url","value":"https://github.com/CMDred/Placeholder"},"hoverEvent":{"action":"show_text","contents":["Open page"]}}]
tellraw @a ["",{"text":"Physics >> ","color":"#99EAD6"},{"text":"Made by CMDred","clickEvent":{"action":"open_url","value":"https://www.youtube.com/BluesProductionTeam"},"hoverEvent":{"action":"show_text","contents":[{"text":"YouTube: ","color":"dark_aqua"},{"text":"CMDred","color":"white"}]}},"\n",{"text":"Physics >> ","color":"#99EAD6"},"PLACEHOLDER: ",{"text":"Modrinth","color":"#5491F7","clickEvent":{"action":"open_url","value":"https://modrinth.com/datapack/placeholder"},"hoverEvent":{"action":"show_text","contents":["Open page"]}},", ",{"text":"GitHub","color":"#5491F7","clickEvent":{"action":"open_url","value":"https://github.com/CMDred/Placeholder"},"hoverEvent":{"action":"show_text","contents":["Open page"]}}]
