# Summon hitbox
scoreboard players operation @s Physics.Player.ID = #Physics.NewHitbox Physics.Player.ID
scoreboard players operation @s Physics.Hitbox.Gametime = #Physics.Gametime Physics

# SET THE HITBOX SIZE AND THE POSITION IN A SINGLE DATA MODIFICATION, THEN ADD THE TAG AFTERWARDS

tag @s add Physics.Hitbox
