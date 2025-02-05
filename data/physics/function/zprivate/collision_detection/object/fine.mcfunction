# Perform the Separating Axes Theorem to get whether there's a collision, the depth of the collision and what kind it is (Edge-Edge, Point-Face)
    # Check the different axes
    # (Important): This function is executed as ObjectB aka "Other"
    # (Important): I project the relative coordinates of the cornerpoints, so I only have to project 4 corners (The other 4 are sign-flipped). Then I project the center coordinate of the object and add that to the 8 corner projections. The mirror pairs are 0/7, 1/6, 2/5, 3/4.
    # (Important): I need every corner's CornerPosRelative for both objects for every axis I project them onto. But because there are early-outs, I DON'T use the "execute store" trick here.
    # (Important): In the voxel-collisions precalculations, I scaled down the individual corner projections directly. There it made sense, as it was a 1-time thing and avoided duplicate operations. But here, I have early-outs, so any extra work I do at the start may never be used. So I only scale down the min/max until I actually need the corner projections themselves for contact generation.
    # (Important): This overwrites the cross product axis scores. But it's not a problem, as those old ones are not used after that point.
        # x_this
            # Projection: This (Precalculated in integration)

            # Projection: Other
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.x Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.x Physics *= #Physics.ThisObject Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.z
                execute store result score #Physics.Projection.OtherObjectCorner7.ObjectAxis.x Physics store result score #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.x Physics = @s Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.x Physics *= #Physics.ThisObject Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.z
                execute store result score #Physics.Projection.OtherObjectCorner6.ObjectAxis.x Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.x Physics = @s Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.x Physics *= #Physics.ThisObject Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.z
                execute store result score #Physics.Projection.OtherObjectCorner5.ObjectAxis.x Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                # Corner 3
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.x Physics = @s Physics.Object.CornerPosRelative.3.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.x Physics *= #Physics.ThisObject Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.3.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.3.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.z
                execute store result score #Physics.Projection.OtherObjectCorner4.ObjectAxis.x Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                # Corner 4
                scoreboard players operation #Physics.Projection.OtherObjectCorner4.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics

                # Corner 5
                scoreboard players operation #Physics.Projection.OtherObjectCorner5.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics

                # Corner 6
                scoreboard players operation #Physics.Projection.OtherObjectCorner6.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics

                # Corner 7
                scoreboard players operation #Physics.Projection.OtherObjectCorner7.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner1.ObjectAxis.x Physics > #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics = #Physics.Projection.OtherObjectCorner1.ObjectAxis.x Physics
                execute if score #Physics.Projection.OtherObjectCorner2.ObjectAxis.x Physics > #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics = #Physics.Projection.OtherObjectCorner2.ObjectAxis.x Physics
                execute if score #Physics.Projection.OtherObjectCorner3.ObjectAxis.x Physics > #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics = #Physics.Projection.OtherObjectCorner3.ObjectAxis.x Physics
                execute if score #Physics.Projection.OtherObjectCorner4.ObjectAxis.x Physics > #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics = #Physics.Projection.OtherObjectCorner4.ObjectAxis.x Physics
                execute if score #Physics.Projection.OtherObjectCorner5.ObjectAxis.x Physics > #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics = #Physics.Projection.OtherObjectCorner5.ObjectAxis.x Physics
                execute if score #Physics.Projection.OtherObjectCorner6.ObjectAxis.x Physics > #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics = #Physics.Projection.OtherObjectCorner6.ObjectAxis.x Physics
                execute if score #Physics.Projection.OtherObjectCorner7.ObjectAxis.x Physics > #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics = #Physics.Projection.OtherObjectCorner7.ObjectAxis.x Physics
                execute store result score #Physics.Projection.OtherObject.ObjectAxis.x.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.x Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.x Physics *= #Physics.ThisObject Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.z
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.x Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Min Physics += #Physics.Projection.OtherObjectCenter.ObjectAxis.x Physics
                scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics += #Physics.Projection.OtherObjectCenter.ObjectAxis.x Physics

            # Overlap check
            execute unless score #Physics.ThisObject Physics.Object.ProjectionOwnAxis.x.Min <= #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.ObjectAxis.x.Min Physics <= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.x.Max run return 0

        # y_this
            # Projection: This (Precalculated in integration)

            # Projection: Other
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.y Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.y Physics *= #Physics.ThisObject Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.y.z
                execute store result score #Physics.Projection.OtherObjectCorner7.ObjectAxis.y Physics store result score #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.y Physics = @s Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.y Physics *= #Physics.ThisObject Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.y.z
                execute store result score #Physics.Projection.OtherObjectCorner6.ObjectAxis.y Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.y Physics = @s Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.y Physics *= #Physics.ThisObject Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.y.z
                execute store result score #Physics.Projection.OtherObjectCorner5.ObjectAxis.y Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                # Corner 3
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.y Physics = @s Physics.Object.CornerPosRelative.3.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.y Physics *= #Physics.ThisObject Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.3.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.3.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.y.z
                execute store result score #Physics.Projection.OtherObjectCorner4.ObjectAxis.y Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                # Corner 4
                scoreboard players operation #Physics.Projection.OtherObjectCorner4.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics

                # Corner 5
                scoreboard players operation #Physics.Projection.OtherObjectCorner5.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics

                # Corner 6
                scoreboard players operation #Physics.Projection.OtherObjectCorner6.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics

                # Corner 7
                scoreboard players operation #Physics.Projection.OtherObjectCorner7.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner1.ObjectAxis.y Physics > #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics = #Physics.Projection.OtherObjectCorner1.ObjectAxis.y Physics
                execute if score #Physics.Projection.OtherObjectCorner2.ObjectAxis.y Physics > #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics = #Physics.Projection.OtherObjectCorner2.ObjectAxis.y Physics
                execute if score #Physics.Projection.OtherObjectCorner3.ObjectAxis.y Physics > #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics = #Physics.Projection.OtherObjectCorner3.ObjectAxis.y Physics
                execute if score #Physics.Projection.OtherObjectCorner4.ObjectAxis.y Physics > #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics = #Physics.Projection.OtherObjectCorner4.ObjectAxis.y Physics
                execute if score #Physics.Projection.OtherObjectCorner5.ObjectAxis.y Physics > #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics = #Physics.Projection.OtherObjectCorner5.ObjectAxis.y Physics
                execute if score #Physics.Projection.OtherObjectCorner6.ObjectAxis.y Physics > #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics = #Physics.Projection.OtherObjectCorner6.ObjectAxis.y Physics
                execute if score #Physics.Projection.OtherObjectCorner7.ObjectAxis.y Physics > #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics = #Physics.Projection.OtherObjectCorner7.ObjectAxis.y Physics
                execute store result score #Physics.Projection.OtherObject.ObjectAxis.y.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.y Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.y Physics *= #Physics.ThisObject Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.y.z
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.y Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Min Physics += #Physics.Projection.OtherObjectCenter.ObjectAxis.y Physics
                scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics += #Physics.Projection.OtherObjectCenter.ObjectAxis.y Physics

            # Overlap check
            execute unless score #Physics.ThisObject Physics.Object.ProjectionOwnAxis.y.Min <= #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.ObjectAxis.y.Min Physics <= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.y.Max run return 0

        # z_this
            # Projection: This (Precalculated in integration)

            # Projection: Other
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.z Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.z Physics *= #Physics.ThisObject Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.z.z
                execute store result score #Physics.Projection.OtherObjectCorner7.ObjectAxis.z Physics store result score #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.z Physics = @s Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.z Physics *= #Physics.ThisObject Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.z.z
                execute store result score #Physics.Projection.OtherObjectCorner6.ObjectAxis.z Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.z Physics = @s Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.z Physics *= #Physics.ThisObject Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.z.z
                execute store result score #Physics.Projection.OtherObjectCorner5.ObjectAxis.z Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                # Corner 3
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.z Physics = @s Physics.Object.CornerPosRelative.3.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.z Physics *= #Physics.ThisObject Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.3.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.3.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.z.z
                execute store result score #Physics.Projection.OtherObjectCorner4.ObjectAxis.z Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                # Corner 4
                scoreboard players operation #Physics.Projection.OtherObjectCorner4.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics

                # Corner 5
                scoreboard players operation #Physics.Projection.OtherObjectCorner5.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics

                # Corner 6
                scoreboard players operation #Physics.Projection.OtherObjectCorner6.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics

                # Corner 7
                scoreboard players operation #Physics.Projection.OtherObjectCorner7.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner1.ObjectAxis.z Physics > #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics = #Physics.Projection.OtherObjectCorner1.ObjectAxis.z Physics
                execute if score #Physics.Projection.OtherObjectCorner2.ObjectAxis.z Physics > #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics = #Physics.Projection.OtherObjectCorner2.ObjectAxis.z Physics
                execute if score #Physics.Projection.OtherObjectCorner3.ObjectAxis.z Physics > #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics = #Physics.Projection.OtherObjectCorner3.ObjectAxis.z Physics
                execute if score #Physics.Projection.OtherObjectCorner4.ObjectAxis.z Physics > #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics = #Physics.Projection.OtherObjectCorner4.ObjectAxis.z Physics
                execute if score #Physics.Projection.OtherObjectCorner5.ObjectAxis.z Physics > #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics = #Physics.Projection.OtherObjectCorner5.ObjectAxis.z Physics
                execute if score #Physics.Projection.OtherObjectCorner6.ObjectAxis.z Physics > #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics = #Physics.Projection.OtherObjectCorner6.ObjectAxis.z Physics
                execute if score #Physics.Projection.OtherObjectCorner7.ObjectAxis.z Physics > #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics = #Physics.Projection.OtherObjectCorner7.ObjectAxis.z Physics
                execute store result score #Physics.Projection.OtherObject.ObjectAxis.z.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.z Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.z Physics *= #Physics.ThisObject Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.z.z
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.z Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Min Physics += #Physics.Projection.OtherObjectCenter.ObjectAxis.z Physics
                scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics += #Physics.Projection.OtherObjectCenter.ObjectAxis.z Physics

            # Overlap check
            execute unless score #Physics.ThisObject Physics.Object.ProjectionOwnAxis.z.Min <= #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.ObjectAxis.z.Min Physics <= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.z.Max run return 0

        # x_other
            # Projection: This
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.x Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.x Physics *= @s Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.z
                execute store result score #Physics.Projection.ObjectCorner7.OtherObjectAxis.x Physics store result score #Physics.Projection.Object.OtherObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.x Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.x Physics *= @s Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.z
                execute store result score #Physics.Projection.ObjectCorner6.OtherObjectAxis.x Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.x Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.x Physics *= @s Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.z
                execute store result score #Physics.Projection.ObjectCorner5.OtherObjectAxis.x Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                # Corner 3
                scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.x Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.3.x
                scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.x Physics *= @s Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.3.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.3.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.z
                execute store result score #Physics.Projection.ObjectCorner4.OtherObjectAxis.x Physics run scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                # Corner 4
                scoreboard players operation #Physics.Projection.ObjectCorner4.OtherObjectAxis.x Physics *= #Physics.Constants.-1 Physics

                # Corner 5
                scoreboard players operation #Physics.Projection.ObjectCorner5.OtherObjectAxis.x Physics *= #Physics.Constants.-1 Physics

                # Corner 6
                scoreboard players operation #Physics.Projection.ObjectCorner6.OtherObjectAxis.x Physics *= #Physics.Constants.-1 Physics

                # Corner 7
                scoreboard players operation #Physics.Projection.ObjectCorner7.OtherObjectAxis.x Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner1.OtherObjectAxis.x Physics > #Physics.Projection.Object.OtherObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner1.OtherObjectAxis.x Physics
                execute if score #Physics.Projection.ObjectCorner2.OtherObjectAxis.x Physics > #Physics.Projection.Object.OtherObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner2.OtherObjectAxis.x Physics
                execute if score #Physics.Projection.ObjectCorner3.OtherObjectAxis.x Physics > #Physics.Projection.Object.OtherObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner3.OtherObjectAxis.x Physics
                execute if score #Physics.Projection.ObjectCorner4.OtherObjectAxis.x Physics > #Physics.Projection.Object.OtherObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner4.OtherObjectAxis.x Physics
                execute if score #Physics.Projection.ObjectCorner5.OtherObjectAxis.x Physics > #Physics.Projection.Object.OtherObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner5.OtherObjectAxis.x Physics
                execute if score #Physics.Projection.ObjectCorner6.OtherObjectAxis.x Physics > #Physics.Projection.Object.OtherObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner6.OtherObjectAxis.x Physics
                execute if score #Physics.Projection.ObjectCorner7.OtherObjectAxis.x Physics > #Physics.Projection.Object.OtherObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner7.OtherObjectAxis.x Physics
                execute store result score #Physics.Projection.Object.OtherObjectAxis.x.Min Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.x Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.x Physics *= @s Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.z
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.x Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Min Physics += #Physics.Projection.ObjectCenter.OtherObjectAxis.x Physics
                scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Max Physics += #Physics.Projection.ObjectCenter.OtherObjectAxis.x Physics

            # Projection: Other (Precalculated in integration)

            # Overlap check
            execute unless score @s Physics.Object.ProjectionOwnAxis.x.Min <= #Physics.Projection.Object.OtherObjectAxis.x.Max Physics run return 0
            execute unless score #Physics.Projection.Object.OtherObjectAxis.x.Min Physics <= @s Physics.Object.ProjectionOwnAxis.x.Max run return 0

        # y_other
            # Projection: This
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.y Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.y Physics *= @s Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.z
                execute store result score #Physics.Projection.ObjectCorner7.OtherObjectAxis.y Physics store result score #Physics.Projection.Object.OtherObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.y Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.y Physics *= @s Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.z
                execute store result score #Physics.Projection.ObjectCorner6.OtherObjectAxis.y Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.y Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.y Physics *= @s Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.z
                execute store result score #Physics.Projection.ObjectCorner5.OtherObjectAxis.y Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                # Corner 3
                scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.y Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.3.x
                scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.y Physics *= @s Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.3.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.3.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.z
                execute store result score #Physics.Projection.ObjectCorner4.OtherObjectAxis.y Physics run scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                # Corner 4
                scoreboard players operation #Physics.Projection.ObjectCorner4.OtherObjectAxis.y Physics *= #Physics.Constants.-1 Physics

                # Corner 5
                scoreboard players operation #Physics.Projection.ObjectCorner5.OtherObjectAxis.y Physics *= #Physics.Constants.-1 Physics

                # Corner 6
                scoreboard players operation #Physics.Projection.ObjectCorner6.OtherObjectAxis.y Physics *= #Physics.Constants.-1 Physics

                # Corner 7
                scoreboard players operation #Physics.Projection.ObjectCorner7.OtherObjectAxis.y Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner1.OtherObjectAxis.y Physics > #Physics.Projection.Object.OtherObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner1.OtherObjectAxis.y Physics
                execute if score #Physics.Projection.ObjectCorner2.OtherObjectAxis.y Physics > #Physics.Projection.Object.OtherObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner2.OtherObjectAxis.y Physics
                execute if score #Physics.Projection.ObjectCorner3.OtherObjectAxis.y Physics > #Physics.Projection.Object.OtherObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner3.OtherObjectAxis.y Physics
                execute if score #Physics.Projection.ObjectCorner4.OtherObjectAxis.y Physics > #Physics.Projection.Object.OtherObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner4.OtherObjectAxis.y Physics
                execute if score #Physics.Projection.ObjectCorner5.OtherObjectAxis.y Physics > #Physics.Projection.Object.OtherObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner5.OtherObjectAxis.y Physics
                execute if score #Physics.Projection.ObjectCorner6.OtherObjectAxis.y Physics > #Physics.Projection.Object.OtherObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner6.OtherObjectAxis.y Physics
                execute if score #Physics.Projection.ObjectCorner7.OtherObjectAxis.y Physics > #Physics.Projection.Object.OtherObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner7.OtherObjectAxis.y Physics
                execute store result score #Physics.Projection.Object.OtherObjectAxis.y.Min Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.y Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.y Physics *= @s Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.z
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.y Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Min Physics += #Physics.Projection.ObjectCenter.OtherObjectAxis.y Physics
                scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Max Physics += #Physics.Projection.ObjectCenter.OtherObjectAxis.y Physics

            # Projection: Other (Precalculated in integration)

            # Overlap check
            execute unless score @s Physics.Object.ProjectionOwnAxis.y.Min <= #Physics.Projection.Object.OtherObjectAxis.y.Max Physics run return 0
            execute unless score #Physics.Projection.Object.OtherObjectAxis.y.Min Physics <= @s Physics.Object.ProjectionOwnAxis.y.Max run return 0

        # z_other
            # Projection: This
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.z Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.z Physics *= @s Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.z
                execute store result score #Physics.Projection.ObjectCorner7.OtherObjectAxis.z Physics store result score #Physics.Projection.Object.OtherObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.z Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.z Physics *= @s Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.z
                execute store result score #Physics.Projection.ObjectCorner6.OtherObjectAxis.z Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.z Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.z Physics *= @s Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.z
                execute store result score #Physics.Projection.ObjectCorner5.OtherObjectAxis.z Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                # Corner 3
                scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.z Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.3.x
                scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.z Physics *= @s Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.3.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.3.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.z
                execute store result score #Physics.Projection.ObjectCorner4.OtherObjectAxis.z Physics run scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                # Corner 4
                scoreboard players operation #Physics.Projection.ObjectCorner4.OtherObjectAxis.z Physics *= #Physics.Constants.-1 Physics

                # Corner 5
                scoreboard players operation #Physics.Projection.ObjectCorner5.OtherObjectAxis.z Physics *= #Physics.Constants.-1 Physics

                # Corner 6
                scoreboard players operation #Physics.Projection.ObjectCorner6.OtherObjectAxis.z Physics *= #Physics.Constants.-1 Physics

                # Corner 7
                scoreboard players operation #Physics.Projection.ObjectCorner7.OtherObjectAxis.z Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner1.OtherObjectAxis.z Physics > #Physics.Projection.Object.OtherObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner1.OtherObjectAxis.z Physics
                execute if score #Physics.Projection.ObjectCorner2.OtherObjectAxis.z Physics > #Physics.Projection.Object.OtherObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner2.OtherObjectAxis.z Physics
                execute if score #Physics.Projection.ObjectCorner3.OtherObjectAxis.z Physics > #Physics.Projection.Object.OtherObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner3.OtherObjectAxis.z Physics
                execute if score #Physics.Projection.ObjectCorner4.OtherObjectAxis.z Physics > #Physics.Projection.Object.OtherObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner4.OtherObjectAxis.z Physics
                execute if score #Physics.Projection.ObjectCorner5.OtherObjectAxis.z Physics > #Physics.Projection.Object.OtherObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner5.OtherObjectAxis.z Physics
                execute if score #Physics.Projection.ObjectCorner6.OtherObjectAxis.z Physics > #Physics.Projection.Object.OtherObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner6.OtherObjectAxis.z Physics
                execute if score #Physics.Projection.ObjectCorner7.OtherObjectAxis.z Physics > #Physics.Projection.Object.OtherObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner7.OtherObjectAxis.z Physics
                execute store result score #Physics.Projection.Object.OtherObjectAxis.z.Min Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.z Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.z Physics *= @s Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.z
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.z Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Min Physics += #Physics.Projection.ObjectCenter.OtherObjectAxis.z Physics
                scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Max Physics += #Physics.Projection.ObjectCenter.OtherObjectAxis.z Physics

            # Projection: Other (Precalculated in integration)

            # Overlap check
            execute unless score @s Physics.Object.ProjectionOwnAxis.z.Min <= #Physics.Projection.Object.OtherObjectAxis.z.Max Physics run return 0
            execute unless score #Physics.Projection.Object.OtherObjectAxis.z.Min Physics <= @s Physics.Object.ProjectionOwnAxis.z.Max run return 0

        # Cross Product: x_this x x_other
            # Calculation
            scoreboard players operation #Physics.CrossProductAxis.xx.x Physics = #Physics.ThisObject Physics.Object.Axis.x.y
            scoreboard players operation #Physics.CrossProductAxis.xx.x Physics *= @s Physics.Object.Axis.x.z
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.z
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.y
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.xx.x Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis.xx.y Physics = #Physics.ThisObject Physics.Object.Axis.x.z
            scoreboard players operation #Physics.CrossProductAxis.xx.y Physics *= @s Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.z
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.CrossProductAxis.xx.y Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis.xx.z Physics = #Physics.ThisObject Physics.Object.Axis.x.x
            scoreboard players operation #Physics.CrossProductAxis.xx.z Physics *= @s Physics.Object.Axis.x.y
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.y
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.x
            execute store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.CrossProductAxis.xx.z Physics -= #Physics.Maths.Value1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.Value1 Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value1 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value2 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.xx.x Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.xx.y Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.xx.z Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.xx.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis.xx.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis.xx.z Physics /= #Physics.Maths.SquareRoot.Output Physics

            # Projection: This
            # (Important): Because the cross product is perpendicular to this object's x axis, points along that axis have the same projection. Because of this: Corner 2 = Corner 0 / Corner 3 = Corner 1 / Corner 6 = Corner 4 / Corner 7 = Corner 5
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xx Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xx Physics *= #Physics.CrossProductAxis.xx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.z Physics
                execute store result score #Physics.Projection.ObjectCorner5.CrossProductAxis.xx Physics store result score #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics *= #Physics.CrossProductAxis.xx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.z Physics
                execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.xx Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.xx Physics *= #Physics.Constants.-1 Physics

                # Corner 5 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.xx Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics > #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics
                execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.xx Physics > #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.xx Physics
                execute if score #Physics.Projection.ObjectCorner5.CrossProductAxis.xx Physics > #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis.xx Physics
                execute store result score #Physics.Projection.Object.CrossProductAxis.xx.Min Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics *= #Physics.CrossProductAxis.xx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.z Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics

            # Projection: Other
            # (Important): Because the cross product is perpendicular to the other object's x axis, points along that axis have the same projection. Because of this: Corner 2 = Corner 0 / Corner 3 = Corner 1 / Corner 6 = Corner 4 / Corner 7 = Corner 5

            # Overlap check
