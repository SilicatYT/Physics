# Open the settings menu
execute store result storage physics:temp data.Settings.DefaultGravity short 1 run scoreboard players get #Physics.Settings.DefaultGravity Physics
execute store result storage physics:temp data.Settings.LinearDamping byte 1 run scoreboard players get #Physics.Settings.LinearDamping Physics
execute store result storage physics:temp data.Settings.AngularDamping byte 1 run scoreboard players get #Physics.Settings.AngularDamping Physics
execute store result storage physics:temp data.Settings.MinPenetrationDepth short 1 run scoreboard players get #Physics.Settings.MinPenetrationDepth Physics

function physics:zprivate/settings/open with storage physics:temp data.Settings
