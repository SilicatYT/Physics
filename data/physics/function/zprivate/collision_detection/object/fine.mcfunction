# Perform the Separating Axes Theorem to get whether there's a collision, the depth of the collision and what kind it is (Edge-Edge, Point-Face)
    # Check the different axes
    # (Important): This function is executed as ObjectB aka "Other"
    # (Important): I project the relative coordinates of the cornerpoints, so I only have to project 4 corners (The other 4 are sign-flipped). Then I project the center coordinate of the object and add that to the 8 corner projections. The mirror pairs are 0/7, 1/6, 2/5, 3/4.
    # (Important): I need every corner's CornerPosRelative for both objects for every axis I project them onto. But because there are early-outs, I DON'T use the "execute store" trick here.
    # (Important): In the world collision precalculations, I scaled down the individual corner projections directly. There it made sense, as it was a 1-time thing and avoided duplicate operations. But here, I have early-outs, so any extra work I do at the start may never be used. So I only scale down the min/max until I actually need the corner projections themselves for contact generation.
    # (Important): This overwrites the cross product axis scores. But it's not a problem, as those old ones are not used after that point.
    # (Important): In order to prevent the world cross product axis and its projections from getting overwritten, I use CrossProductAxis2 here. These always refer to cross product axes between two objects, instead of an object and a regular block.
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
            scoreboard players operation #Physics.CrossProductAxis2.xx.x Physics = #Physics.ThisObject Physics.Object.Axis.x.y
            scoreboard players operation #Physics.CrossProductAxis2.xx.x Physics *= @s Physics.Object.Axis.x.z
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.z
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.y
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis2.xx.x Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis2.xx.y Physics = #Physics.ThisObject Physics.Object.Axis.x.z
            scoreboard players operation #Physics.CrossProductAxis2.xx.y Physics *= @s Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.z
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.CrossProductAxis2.xx.y Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis2.xx.z Physics = #Physics.ThisObject Physics.Object.Axis.x.x
            scoreboard players operation #Physics.CrossProductAxis2.xx.z Physics *= @s Physics.Object.Axis.x.y
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.y
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.x
            execute store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.CrossProductAxis2.xx.z Physics -= #Physics.Maths.Value1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis2.xx.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis2.xx.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis2.xx.z Physics /= #Physics.Maths.SquareRoot.Output Physics

            # Projection: This
            # (Important): Because the cross product is perpendicular to this object's x axis, points along that axis have the same projection. Because of this: Corner 2 = Corner 0 / Corner 3 = Corner 1 / Corner 6 = Corner 4 / Corner 7 = Corner 5
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.xx Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.xx Physics *= #Physics.CrossProductAxis2.xx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xx.z Physics
                execute store result score #Physics.Projection.ObjectCorner5.CrossProductAxis2.xx Physics store result score #Physics.Projection.Object.CrossProductAxis2.xx.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.xx Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.xx Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.xx Physics *= #Physics.CrossProductAxis2.xx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xx.z Physics
                execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis2.xx Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.xx Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis2.xx Physics *= #Physics.Constants.-1 Physics

                # Corner 5 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis2.xx Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis2.xx Physics > #Physics.Projection.Object.CrossProductAxis2.xx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xx.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis2.xx Physics
                execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis2.xx Physics > #Physics.Projection.Object.CrossProductAxis2.xx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xx.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis2.xx Physics
                execute if score #Physics.Projection.ObjectCorner5.CrossProductAxis2.xx Physics > #Physics.Projection.Object.CrossProductAxis2.xx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xx.Max Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis2.xx Physics
                execute store result score #Physics.Projection.Object.CrossProductAxis2.xx.Min Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xx.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xx.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.xx Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.xx Physics *= #Physics.CrossProductAxis2.xx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xx.z Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.xx Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xx.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis2.xx Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xx.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis2.xx Physics

            # Projection: Other
            # (Important): Because the cross product is perpendicular to the other object's x axis, points along that axis have the same projection. Because of this: Corner 2 = Corner 0 / Corner 3 = Corner 1 / Corner 6 = Corner 4 / Corner 7 = Corner 5
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.xx Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.xx Physics *= #Physics.CrossProductAxis2.xx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xx.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xx.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner5.CrossProductAxis2.xx Physics store result score #Physics.Projection.OtherObject.CrossProductAxis2.xx.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.xx Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.xx Physics = @s Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.xx Physics *= #Physics.CrossProductAxis2.xx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xx.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xx.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.xx Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.xx Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.xx Physics *= #Physics.Constants.-1 Physics

                # Corner 5 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.OtherObjectCorner5.CrossProductAxis2.xx Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.xx Physics > #Physics.Projection.OtherObject.CrossProductAxis2.xx.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xx.Max Physics = #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.xx Physics
                execute if score #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.xx Physics > #Physics.Projection.OtherObject.CrossProductAxis2.xx.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xx.Max Physics = #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.xx Physics
                execute if score #Physics.Projection.OtherObjectCorner5.CrossProductAxis2.xx Physics > #Physics.Projection.OtherObject.CrossProductAxis2.xx.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xx.Max Physics = #Physics.Projection.OtherObjectCorner5.CrossProductAxis2.xx Physics
                execute store result score #Physics.Projection.OtherObject.CrossProductAxis2.xx.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xx.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xx.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xx Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xx Physics *= #Physics.CrossProductAxis2.xx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xx.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xx.z Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xx Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xx.Min Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xx Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xx.Max Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xx Physics

            # Overlap check
            execute unless score #Physics.Projection.Object.CrossProductAxis2.xx.Min Physics <= #Physics.Projection.OtherObject.CrossProductAxis2.xx.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.CrossProductAxis2.xx.Min Physics <= #Physics.Projection.Object.CrossProductAxis2.xx.Max Physics run return 0

        # Cross Product: x_this x y_other
            # Calculation
            scoreboard players operation #Physics.CrossProductAxis2.xy.x Physics = #Physics.ThisObject Physics.Object.Axis.x.y
            scoreboard players operation #Physics.CrossProductAxis2.xy.x Physics *= @s Physics.Object.Axis.y.z
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.z
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.y
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis2.xy.x Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis2.xy.y Physics = #Physics.ThisObject Physics.Object.Axis.x.z
            scoreboard players operation #Physics.CrossProductAxis2.xy.y Physics *= @s Physics.Object.Axis.y.x
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.z
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.CrossProductAxis2.xy.y Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis2.xy.z Physics = #Physics.ThisObject Physics.Object.Axis.x.x
            scoreboard players operation #Physics.CrossProductAxis2.xy.z Physics *= @s Physics.Object.Axis.y.y
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.y
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.x
            execute store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.CrossProductAxis2.xy.z Physics -= #Physics.Maths.Value1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis2.xy.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis2.xy.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis2.xy.z Physics /= #Physics.Maths.SquareRoot.Output Physics

            # Projection: This
            # (Important): Because the cross product is perpendicular to this object's x axis, points along that axis have the same projection. Because of this: Corner 2 = Corner 0 / Corner 3 = Corner 1 / Corner 6 = Corner 4 / Corner 7 = Corner 5
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.xy Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.xy Physics *= #Physics.CrossProductAxis2.xy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xy.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.xy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xy.z Physics
                execute store result score #Physics.Projection.ObjectCorner5.CrossProductAxis2.xy Physics store result score #Physics.Projection.Object.CrossProductAxis2.xy.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.xy Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.xy Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.xy Physics *= #Physics.CrossProductAxis2.xy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xy.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.xy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xy.z Physics
                execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis2.xy Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.xy Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis2.xy Physics *= #Physics.Constants.-1 Physics

                # Corner 5 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis2.xy Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis2.xy Physics > #Physics.Projection.Object.CrossProductAxis2.xy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xy.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis2.xy Physics
                execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis2.xy Physics > #Physics.Projection.Object.CrossProductAxis2.xy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xy.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis2.xy Physics
                execute if score #Physics.Projection.ObjectCorner5.CrossProductAxis2.xy Physics > #Physics.Projection.Object.CrossProductAxis2.xy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xy.Max Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis2.xy Physics
                execute store result score #Physics.Projection.Object.CrossProductAxis2.xy.Min Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xy.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xy.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.xy Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.xy Physics *= #Physics.CrossProductAxis2.xy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xy.y Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.xy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xy.z Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.xy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.xy Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xy.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis2.xy Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xy.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis2.xy Physics

            # Projection: Other
            # (Important): Because the cross product is perpendicular to the other object's y axis, points along that axis have the same projection. Because of this: Corner 4 = Corner 0 / Corner 5 = Corner 1 / Corner 6 = Corner 2 / Corner 7 = Corner 3
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.xy Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.xy Physics *= #Physics.CrossProductAxis2.xy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xy.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.xy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xy.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner3.CrossProductAxis2.xy Physics store result score #Physics.Projection.OtherObject.CrossProductAxis2.xy.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.xy Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.xy Physics = @s Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.xy Physics *= #Physics.CrossProductAxis2.xy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xy.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.xy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xy.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.xy Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.xy Physics += #Physics.Maths.Value1 Physics

                # Corner 2 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.xy Physics *= #Physics.Constants.-1 Physics

                # Corner 3 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.CrossProductAxis2.xy Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.xy Physics > #Physics.Projection.OtherObject.CrossProductAxis2.xy.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xy.Max Physics = #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.xy Physics
                execute if score #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.xy Physics > #Physics.Projection.OtherObject.CrossProductAxis2.xy.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xy.Max Physics = #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.xy Physics
                execute if score #Physics.Projection.OtherObjectCorner3.CrossProductAxis2.xy Physics > #Physics.Projection.OtherObject.CrossProductAxis2.xy.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xy.Max Physics = #Physics.Projection.OtherObjectCorner3.CrossProductAxis2.xy Physics
                execute store result score #Physics.Projection.OtherObject.CrossProductAxis2.xy.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xy.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xy.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xy Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xy Physics *= #Physics.CrossProductAxis2.xy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xy.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xy.z Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xy Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xy.Min Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xy Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xy.Max Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xy Physics

            # Overlap check
            execute unless score #Physics.Projection.Object.CrossProductAxis2.xy.Min Physics <= #Physics.Projection.OtherObject.CrossProductAxis2.xy.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.CrossProductAxis2.xy.Min Physics <= #Physics.Projection.Object.CrossProductAxis2.xy.Max Physics run return 0

        # Cross Product: x_this x z_other
            # Calculation
            scoreboard players operation #Physics.CrossProductAxis2.xz.x Physics = #Physics.ThisObject Physics.Object.Axis.x.y
            scoreboard players operation #Physics.CrossProductAxis2.xz.x Physics *= @s Physics.Object.Axis.z.z
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.z
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.y
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis2.xz.x Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis2.xz.y Physics = #Physics.ThisObject Physics.Object.Axis.x.z
            scoreboard players operation #Physics.CrossProductAxis2.xz.y Physics *= @s Physics.Object.Axis.z.x
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.z
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.CrossProductAxis2.xz.y Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis2.xz.z Physics = #Physics.ThisObject Physics.Object.Axis.x.x
            scoreboard players operation #Physics.CrossProductAxis2.xz.z Physics *= @s Physics.Object.Axis.z.y
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.y
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.x
            execute store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.CrossProductAxis2.xz.z Physics -= #Physics.Maths.Value1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis2.xz.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis2.xz.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis2.xz.z Physics /= #Physics.Maths.SquareRoot.Output Physics

            # Projection: This
            # (Important): Because the cross product is perpendicular to this object's x axis, points along that axis have the same projection. Because of this: Corner 2 = Corner 0 / Corner 3 = Corner 1 / Corner 6 = Corner 4 / Corner 7 = Corner 5
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.xz Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.xz Physics *= #Physics.CrossProductAxis2.xz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xz.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.xz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xz.z Physics
                execute store result score #Physics.Projection.ObjectCorner5.CrossProductAxis2.xz Physics store result score #Physics.Projection.Object.CrossProductAxis2.xz.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.xz Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.xz Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.xz Physics *= #Physics.CrossProductAxis2.xz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xz.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.xz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xz.z Physics
                execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis2.xz Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.xz Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis2.xz Physics *= #Physics.Constants.-1 Physics

                # Corner 5 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis2.xz Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis2.xz Physics > #Physics.Projection.Object.CrossProductAxis2.xz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xz.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis2.xz Physics
                execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis2.xz Physics > #Physics.Projection.Object.CrossProductAxis2.xz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xz.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis2.xz Physics
                execute if score #Physics.Projection.ObjectCorner5.CrossProductAxis2.xz Physics > #Physics.Projection.Object.CrossProductAxis2.xz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xz.Max Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis2.xz Physics
                execute store result score #Physics.Projection.Object.CrossProductAxis2.xz.Min Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xz.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xz.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.xz Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.xz Physics *= #Physics.CrossProductAxis2.xz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xz.y Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.xz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xz.z Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.xz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.xz Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xz.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis2.xz Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.xz.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis2.xz Physics

            # Projection: Other
            # (Important): Because the cross product is perpendicular to the other object's z axis, points along that axis have the same projection. Because of this: Corner 1 = Corner 0 / Corner 3 = Corner 2 / Corner 5 = Corner 4 / Corner 7 = Corner 6
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.xz Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.xz Physics *= #Physics.CrossProductAxis2.xz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xz.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.xz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xz.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner6.CrossProductAxis2.xz Physics store result score #Physics.Projection.OtherObject.CrossProductAxis2.xz.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.xz Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.xz Physics = @s Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.xz Physics *= #Physics.CrossProductAxis2.xz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xz.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.xz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xz.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.xz Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.xz Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 2)
                scoreboard players operation #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.xz Physics *= #Physics.Constants.-1 Physics

                # Corner 6 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.OtherObjectCorner6.CrossProductAxis2.xz Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.xz Physics > #Physics.Projection.OtherObject.CrossProductAxis2.xz.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xz.Max Physics = #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.xz Physics
                execute if score #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.xz Physics > #Physics.Projection.OtherObject.CrossProductAxis2.xz.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xz.Max Physics = #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.xz Physics
                execute if score #Physics.Projection.OtherObjectCorner6.CrossProductAxis2.xz Physics > #Physics.Projection.OtherObject.CrossProductAxis2.xz.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xz.Max Physics = #Physics.Projection.OtherObjectCorner6.CrossProductAxis2.xz Physics
                execute store result score #Physics.Projection.OtherObject.CrossProductAxis2.xz.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xz.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xz.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xz Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xz Physics *= #Physics.CrossProductAxis2.xz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xz.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.xz.z Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xz Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xz.Min Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xz Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.xz.Max Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis2.xz Physics

            # Overlap check
            execute unless score #Physics.Projection.Object.CrossProductAxis2.xz.Min Physics <= #Physics.Projection.OtherObject.CrossProductAxis2.xz.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.CrossProductAxis2.xz.Min Physics <= #Physics.Projection.Object.CrossProductAxis2.xz.Max Physics run return 0

        # Cross Product: y_this x x_other
            # Calculation
            scoreboard players operation #Physics.CrossProductAxis2.yx.x Physics = #Physics.ThisObject Physics.Object.Axis.y.y
            scoreboard players operation #Physics.CrossProductAxis2.yx.x Physics *= @s Physics.Object.Axis.x.z
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.y.z
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.y
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis2.yx.x Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis2.yx.y Physics = #Physics.ThisObject Physics.Object.Axis.y.z
            scoreboard players operation #Physics.CrossProductAxis2.yx.y Physics *= @s Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.y.x
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.z
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.CrossProductAxis2.yx.y Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis2.yx.z Physics = #Physics.ThisObject Physics.Object.Axis.y.x
            scoreboard players operation #Physics.CrossProductAxis2.yx.z Physics *= @s Physics.Object.Axis.x.y
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.y.y
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.x
            execute store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.CrossProductAxis2.yx.z Physics -= #Physics.Maths.Value1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis2.yx.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis2.yx.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis2.yx.z Physics /= #Physics.Maths.SquareRoot.Output Physics

            # Projection: This
            # (Important): Because the cross product is perpendicular to this object's y axis, points along that axis have the same projection. Because of this: Corner 4 = Corner 0 / Corner 5 = Corner 1 / Corner 6 = Corner 2 / Corner 7 = Corner 3
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.yx Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.yx Physics *= #Physics.CrossProductAxis2.yx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.yx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yx.z Physics
                execute store result score #Physics.Projection.ObjectCorner3.CrossProductAxis2.yx Physics store result score #Physics.Projection.Object.CrossProductAxis2.yx.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.yx Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.yx Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.yx Physics *= #Physics.CrossProductAxis2.yx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.yx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yx.z Physics
                execute store result score #Physics.Projection.ObjectCorner2.CrossProductAxis2.yx Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.yx Physics += #Physics.Maths.Value1 Physics

                # Corner 2 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis2.yx Physics *= #Physics.Constants.-1 Physics

                # Corner 3 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis2.yx Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis2.yx Physics > #Physics.Projection.Object.CrossProductAxis2.yx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yx.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis2.yx Physics
                execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis2.yx Physics > #Physics.Projection.Object.CrossProductAxis2.yx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yx.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis2.yx Physics
                execute if score #Physics.Projection.ObjectCorner3.CrossProductAxis2.yx Physics > #Physics.Projection.Object.CrossProductAxis2.yx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yx.Max Physics = #Physics.Projection.ObjectCorner3.CrossProductAxis2.yx Physics
                execute store result score #Physics.Projection.Object.CrossProductAxis2.yx.Min Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yx.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yx.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.yx Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.yx Physics *= #Physics.CrossProductAxis2.yx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.yx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yx.z Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.yx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.yx Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yx.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis2.yx Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yx.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis2.yx Physics

            # Projection: Other
            # (Important): Because the cross product is perpendicular to the other object's x axis, points along that axis have the same projection. Because of this: Corner 2 = Corner 0 / Corner 3 = Corner 1 / Corner 6 = Corner 4 / Corner 7 = Corner 5
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.yx Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.yx Physics *= #Physics.CrossProductAxis2.yx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yx.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.yx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yx.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner5.CrossProductAxis2.yx Physics store result score #Physics.Projection.OtherObject.CrossProductAxis2.yx.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.yx Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.yx Physics = @s Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.yx Physics *= #Physics.CrossProductAxis2.yx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yx.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.yx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yx.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.yx Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.yx Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.yx Physics *= #Physics.Constants.-1 Physics

                # Corner 5 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.OtherObjectCorner5.CrossProductAxis2.yx Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.yx Physics > #Physics.Projection.OtherObject.CrossProductAxis2.yx.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yx.Max Physics = #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.yx Physics
                execute if score #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.yx Physics > #Physics.Projection.OtherObject.CrossProductAxis2.yx.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yx.Max Physics = #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.yx Physics
                execute if score #Physics.Projection.OtherObjectCorner5.CrossProductAxis2.yx Physics > #Physics.Projection.OtherObject.CrossProductAxis2.yx.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yx.Max Physics = #Physics.Projection.OtherObjectCorner5.CrossProductAxis2.yx Physics
                execute store result score #Physics.Projection.OtherObject.CrossProductAxis2.yx.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yx.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yx.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yx Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yx Physics *= #Physics.CrossProductAxis2.yx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yx.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yx.z Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yx Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yx.Min Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yx Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yx.Max Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yx Physics

            # Overlap check
            execute unless score #Physics.Projection.Object.CrossProductAxis2.yx.Min Physics <= #Physics.Projection.OtherObject.CrossProductAxis2.yx.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.CrossProductAxis2.yx.Min Physics <= #Physics.Projection.Object.CrossProductAxis2.yx.Max Physics run return 0

        # Cross Product: y_this x y_other
            # Calculation
            scoreboard players operation #Physics.CrossProductAxis2.yy.x Physics = #Physics.ThisObject Physics.Object.Axis.y.y
            scoreboard players operation #Physics.CrossProductAxis2.yy.x Physics *= @s Physics.Object.Axis.y.z
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.y.z
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.y
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis2.yy.x Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis2.yy.y Physics = #Physics.ThisObject Physics.Object.Axis.y.z
            scoreboard players operation #Physics.CrossProductAxis2.yy.y Physics *= @s Physics.Object.Axis.y.x
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.y.x
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.z
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.CrossProductAxis2.yy.y Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis2.yy.z Physics = #Physics.ThisObject Physics.Object.Axis.y.x
            scoreboard players operation #Physics.CrossProductAxis2.yy.z Physics *= @s Physics.Object.Axis.y.y
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.y.y
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.x
            execute store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.CrossProductAxis2.yy.z Physics -= #Physics.Maths.Value1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis2.yy.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis2.yy.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis2.yy.z Physics /= #Physics.Maths.SquareRoot.Output Physics

            # Projection: This
            # (Important): Because the cross product is perpendicular to this object's y axis, points along that axis have the same projection. Because of this: Corner 4 = Corner 0 / Corner 5 = Corner 1 / Corner 6 = Corner 2 / Corner 7 = Corner 3
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.yy Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.yy Physics *= #Physics.CrossProductAxis2.yy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yy.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.yy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yy.z Physics
                execute store result score #Physics.Projection.ObjectCorner3.CrossProductAxis2.yy Physics store result score #Physics.Projection.Object.CrossProductAxis2.yy.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.yy Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.yy Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.yy Physics *= #Physics.CrossProductAxis2.yy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yy.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.yy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yy.z Physics
                execute store result score #Physics.Projection.ObjectCorner2.CrossProductAxis2.yy Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.yy Physics += #Physics.Maths.Value1 Physics

                # Corner 2 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis2.yy Physics *= #Physics.Constants.-1 Physics

                # Corner 3 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis2.yy Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis2.yy Physics > #Physics.Projection.Object.CrossProductAxis2.yy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yy.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis2.yy Physics
                execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis2.yy Physics > #Physics.Projection.Object.CrossProductAxis2.yy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yy.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis2.yy Physics
                execute if score #Physics.Projection.ObjectCorner3.CrossProductAxis2.yy Physics > #Physics.Projection.Object.CrossProductAxis2.yy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yy.Max Physics = #Physics.Projection.ObjectCorner3.CrossProductAxis2.yy Physics
                execute store result score #Physics.Projection.Object.CrossProductAxis2.yy.Min Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yy.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yy.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.yy Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.yy Physics *= #Physics.CrossProductAxis2.yy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yy.y Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.yy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yy.z Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.yy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.yy Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yy.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis2.yy Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yy.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis2.yy Physics

            # Projection: Other
            # (Important): Because the cross product is perpendicular to the other object's y axis, points along that axis have the same projection. Because of this: Corner 4 = Corner 0 / Corner 5 = Corner 1 / Corner 6 = Corner 2 / Corner 7 = Corner 3
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.yy Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.yy Physics *= #Physics.CrossProductAxis2.yy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yy.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.yy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yy.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner3.CrossProductAxis2.yy Physics store result score #Physics.Projection.OtherObject.CrossProductAxis2.yy.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.yy Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.yy Physics = @s Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.yy Physics *= #Physics.CrossProductAxis2.yy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yy.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.yy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yy.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.yy Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.yy Physics += #Physics.Maths.Value1 Physics

                # Corner 2 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.yy Physics *= #Physics.Constants.-1 Physics

                # Corner 3 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.CrossProductAxis2.yy Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.yy Physics > #Physics.Projection.OtherObject.CrossProductAxis2.yy.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yy.Max Physics = #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.yy Physics
                execute if score #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.yy Physics > #Physics.Projection.OtherObject.CrossProductAxis2.yy.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yy.Max Physics = #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.yy Physics
                execute if score #Physics.Projection.OtherObjectCorner3.CrossProductAxis2.yy Physics > #Physics.Projection.OtherObject.CrossProductAxis2.yy.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yy.Max Physics = #Physics.Projection.OtherObjectCorner3.CrossProductAxis2.yy Physics
                execute store result score #Physics.Projection.OtherObject.CrossProductAxis2.yy.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yy.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yy.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yy Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yy Physics *= #Physics.CrossProductAxis2.yy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yy.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yy.z Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yy Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yy.Min Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yy Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yy.Max Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yy Physics

            # Overlap check
            execute unless score #Physics.Projection.Object.CrossProductAxis2.yy.Min Physics <= #Physics.Projection.OtherObject.CrossProductAxis2.yy.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.CrossProductAxis2.yy.Min Physics <= #Physics.Projection.Object.CrossProductAxis2.yy.Max Physics run return 0

        # Cross Product: y_this x z_other
            # Calculation
            scoreboard players operation #Physics.CrossProductAxis2.yz.x Physics = #Physics.ThisObject Physics.Object.Axis.y.y
            scoreboard players operation #Physics.CrossProductAxis2.yz.x Physics *= @s Physics.Object.Axis.z.z
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.y.z
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.y
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis2.yz.x Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis2.yz.y Physics = #Physics.ThisObject Physics.Object.Axis.y.z
            scoreboard players operation #Physics.CrossProductAxis2.yz.y Physics *= @s Physics.Object.Axis.z.x
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.y.x
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.z
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.CrossProductAxis2.yz.y Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis2.yz.z Physics = #Physics.ThisObject Physics.Object.Axis.y.x
            scoreboard players operation #Physics.CrossProductAxis2.yz.z Physics *= @s Physics.Object.Axis.z.y
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.y.y
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.x
            execute store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.CrossProductAxis2.yz.z Physics -= #Physics.Maths.Value1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis2.yz.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis2.yz.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis2.yz.z Physics /= #Physics.Maths.SquareRoot.Output Physics

            # Projection: This
            # (Important): Because the cross product is perpendicular to this object's y axis, points along that axis have the same projection. Because of this: Corner 4 = Corner 0 / Corner 5 = Corner 1 / Corner 6 = Corner 2 / Corner 7 = Corner 3
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.yz Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.yz Physics *= #Physics.CrossProductAxis2.yz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yz.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.yz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yz.z Physics
                execute store result score #Physics.Projection.ObjectCorner3.CrossProductAxis2.yz Physics store result score #Physics.Projection.Object.CrossProductAxis2.yz.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.yz Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.yz Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.yz Physics *= #Physics.CrossProductAxis2.yz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yz.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.yz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yz.z Physics
                execute store result score #Physics.Projection.ObjectCorner2.CrossProductAxis2.yz Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis2.yz Physics += #Physics.Maths.Value1 Physics

                # Corner 2 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis2.yz Physics *= #Physics.Constants.-1 Physics

                # Corner 3 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis2.yz Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis2.yz Physics > #Physics.Projection.Object.CrossProductAxis2.yz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yz.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis2.yz Physics
                execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis2.yz Physics > #Physics.Projection.Object.CrossProductAxis2.yz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yz.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis2.yz Physics
                execute if score #Physics.Projection.ObjectCorner3.CrossProductAxis2.yz Physics > #Physics.Projection.Object.CrossProductAxis2.yz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yz.Max Physics = #Physics.Projection.ObjectCorner3.CrossProductAxis2.yz Physics
                execute store result score #Physics.Projection.Object.CrossProductAxis2.yz.Min Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yz.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yz.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.yz Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.yz Physics *= #Physics.CrossProductAxis2.yz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yz.y Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.yz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yz.z Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.yz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.yz Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yz.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis2.yz Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.yz.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis2.yz Physics

            # Projection: Other
            # (Important): Because the cross product is perpendicular to the other object's z axis, points along that axis have the same projection. Because of this: Corner 1 = Corner 0 / Corner 3 = Corner 2 / Corner 5 = Corner 4 / Corner 7 = Corner 6
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.yz Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.yz Physics *= #Physics.CrossProductAxis2.yz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yz.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.yz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yz.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner6.CrossProductAxis2.yz Physics store result score #Physics.Projection.OtherObject.CrossProductAxis2.yz.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.yz Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.yz Physics = @s Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.yz Physics *= #Physics.CrossProductAxis2.yz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yz.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.yz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yz.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.yz Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.yz Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 2)
                scoreboard players operation #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.yz Physics *= #Physics.Constants.-1 Physics

                # Corner 6 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.OtherObjectCorner6.CrossProductAxis2.yz Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.yz Physics > #Physics.Projection.OtherObject.CrossProductAxis2.yz.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yz.Max Physics = #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.yz Physics
                execute if score #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.yz Physics > #Physics.Projection.OtherObject.CrossProductAxis2.yz.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yz.Max Physics = #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.yz Physics
                execute if score #Physics.Projection.OtherObjectCorner6.CrossProductAxis2.yz Physics > #Physics.Projection.OtherObject.CrossProductAxis2.yz.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yz.Max Physics = #Physics.Projection.OtherObjectCorner6.CrossProductAxis2.yz Physics
                execute store result score #Physics.Projection.OtherObject.CrossProductAxis2.yz.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yz.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yz.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yz Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yz Physics *= #Physics.CrossProductAxis2.yz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yz.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.yz.z Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yz Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yz.Min Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yz Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.yz.Max Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis2.yz Physics

            # Overlap check
            execute unless score #Physics.Projection.Object.CrossProductAxis2.yz.Min Physics <= #Physics.Projection.OtherObject.CrossProductAxis2.yz.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.CrossProductAxis2.yz.Min Physics <= #Physics.Projection.Object.CrossProductAxis2.yz.Max Physics run return 0

        # Cross Product: z_this x x_other
            # Calculation
            scoreboard players operation #Physics.CrossProductAxis2.zx.x Physics = #Physics.ThisObject Physics.Object.Axis.z.y
            scoreboard players operation #Physics.CrossProductAxis2.zx.x Physics *= @s Physics.Object.Axis.x.z
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.z.z
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.y
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis2.zx.x Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis2.zx.y Physics = #Physics.ThisObject Physics.Object.Axis.z.z
            scoreboard players operation #Physics.CrossProductAxis2.zx.y Physics *= @s Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.z.x
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.z
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.CrossProductAxis2.zx.y Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis2.zx.z Physics = #Physics.ThisObject Physics.Object.Axis.z.x
            scoreboard players operation #Physics.CrossProductAxis2.zx.z Physics *= @s Physics.Object.Axis.x.y
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.z.y
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.x
            execute store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.CrossProductAxis2.zx.z Physics -= #Physics.Maths.Value1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis2.zx.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis2.zx.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis2.zx.z Physics /= #Physics.Maths.SquareRoot.Output Physics

            # Projection: This
            # (Important): Because the cross product is perpendicular to this object's z axis, points along that axis have the same projection. Because of this: Corner 1 = Corner 0 / Corner 3 = Corner 2 / Corner 5 = Corner 4 / Corner 7 = Corner 6
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.zx Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.zx Physics *= #Physics.CrossProductAxis2.zx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.zx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zx.z Physics
                execute store result score #Physics.Projection.ObjectCorner6.CrossProductAxis2.zx Physics store result score #Physics.Projection.Object.CrossProductAxis2.zx.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.zx Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis2.zx Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis2.zx Physics *= #Physics.CrossProductAxis2.zx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis2.zx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zx.z Physics
                execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis2.zx Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis2.zx Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 2)
                scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis2.zx Physics *= #Physics.Constants.-1 Physics

                # Corner 6 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis2.zx Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis2.zx Physics > #Physics.Projection.Object.CrossProductAxis2.zx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zx.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis2.zx Physics
                execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis2.zx Physics > #Physics.Projection.Object.CrossProductAxis2.zx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zx.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis2.zx Physics
                execute if score #Physics.Projection.ObjectCorner6.CrossProductAxis2.zx Physics > #Physics.Projection.Object.CrossProductAxis2.zx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zx.Max Physics = #Physics.Projection.ObjectCorner6.CrossProductAxis2.zx Physics
                execute store result score #Physics.Projection.Object.CrossProductAxis2.zx.Min Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zx.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zx.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.zx Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.zx Physics *= #Physics.CrossProductAxis2.zx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.zx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zx.z Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.zx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.zx Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zx.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis2.zx Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zx.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis2.zx Physics

            # Projection: Other
            # (Important): Because the cross product is perpendicular to the other object's x axis, points along that axis have the same projection. Because of this: Corner 2 = Corner 0 / Corner 3 = Corner 1 / Corner 6 = Corner 4 / Corner 7 = Corner 5
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.zx Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.zx Physics *= #Physics.CrossProductAxis2.zx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zx.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.zx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zx.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner5.CrossProductAxis2.zx Physics store result score #Physics.Projection.OtherObject.CrossProductAxis2.zx.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.zx Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.zx Physics = @s Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.zx Physics *= #Physics.CrossProductAxis2.zx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zx.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.zx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zx.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.zx Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.zx Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.zx Physics *= #Physics.Constants.-1 Physics

                # Corner 5 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.OtherObjectCorner5.CrossProductAxis2.zx Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.zx Physics > #Physics.Projection.OtherObject.CrossProductAxis2.zx.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zx.Max Physics = #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.zx Physics
                execute if score #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.zx Physics > #Physics.Projection.OtherObject.CrossProductAxis2.zx.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zx.Max Physics = #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.zx Physics
                execute if score #Physics.Projection.OtherObjectCorner5.CrossProductAxis2.zx Physics > #Physics.Projection.OtherObject.CrossProductAxis2.zx.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zx.Max Physics = #Physics.Projection.OtherObjectCorner5.CrossProductAxis2.zx Physics
                execute store result score #Physics.Projection.OtherObject.CrossProductAxis2.zx.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zx.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zx.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zx Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zx Physics *= #Physics.CrossProductAxis2.zx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zx.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zx.z Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zx Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zx.Min Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zx Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zx.Max Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zx Physics

            # Overlap check
            execute unless score #Physics.Projection.Object.CrossProductAxis2.zx.Min Physics <= #Physics.Projection.OtherObject.CrossProductAxis2.zx.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.CrossProductAxis2.zx.Min Physics <= #Physics.Projection.Object.CrossProductAxis2.zx.Max Physics run return 0

        # Cross Product: z_this x y_other
            # Calculation
            scoreboard players operation #Physics.CrossProductAxis2.zy.x Physics = #Physics.ThisObject Physics.Object.Axis.z.y
            scoreboard players operation #Physics.CrossProductAxis2.zy.x Physics *= @s Physics.Object.Axis.y.z
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.z.z
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.y
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis2.zy.x Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis2.zy.y Physics = #Physics.ThisObject Physics.Object.Axis.z.z
            scoreboard players operation #Physics.CrossProductAxis2.zy.y Physics *= @s Physics.Object.Axis.y.x
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.z.x
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.z
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.CrossProductAxis2.zy.y Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis2.zy.z Physics = #Physics.ThisObject Physics.Object.Axis.z.x
            scoreboard players operation #Physics.CrossProductAxis2.zy.z Physics *= @s Physics.Object.Axis.y.y
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.z.y
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.x
            execute store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.CrossProductAxis2.zy.z Physics -= #Physics.Maths.Value1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis2.zy.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis2.zy.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis2.zy.z Physics /= #Physics.Maths.SquareRoot.Output Physics

            # Projection: This
            # (Important): Because the cross product is perpendicular to this object's z axis, points along that axis have the same projection. Because of this: Corner 1 = Corner 0 / Corner 3 = Corner 2 / Corner 5 = Corner 4 / Corner 7 = Corner 6
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.zy Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.zy Physics *= #Physics.CrossProductAxis2.zy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zy.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.zy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zy.z Physics
                execute store result score #Physics.Projection.ObjectCorner6.CrossProductAxis2.zy Physics store result score #Physics.Projection.Object.CrossProductAxis2.zy.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.zy Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis2.zy Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis2.zy Physics *= #Physics.CrossProductAxis2.zy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zy.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis2.zy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zy.z Physics
                execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis2.zy Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis2.zy Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 2)
                scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis2.zy Physics *= #Physics.Constants.-1 Physics

                # Corner 6 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis2.zy Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis2.zy Physics > #Physics.Projection.Object.CrossProductAxis2.zy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zy.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis2.zy Physics
                execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis2.zy Physics > #Physics.Projection.Object.CrossProductAxis2.zy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zy.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis2.zy Physics
                execute if score #Physics.Projection.ObjectCorner6.CrossProductAxis2.zy Physics > #Physics.Projection.Object.CrossProductAxis2.zy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zy.Max Physics = #Physics.Projection.ObjectCorner6.CrossProductAxis2.zy Physics
                execute store result score #Physics.Projection.Object.CrossProductAxis2.zy.Min Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zy.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zy.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.zy Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.zy Physics *= #Physics.CrossProductAxis2.zy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zy.y Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.zy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zy.z Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.zy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.zy Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zy.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis2.zy Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zy.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis2.zy Physics

            # Projection: Other
            # (Important): Because the cross product is perpendicular to the other object's y axis, points along that axis have the same projection. Because of this: Corner 4 = Corner 0 / Corner 5 = Corner 1 / Corner 6 = Corner 2 / Corner 7 = Corner 3
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.zy Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.zy Physics *= #Physics.CrossProductAxis2.zy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zy.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.zy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zy.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner3.CrossProductAxis2.zy Physics store result score #Physics.Projection.OtherObject.CrossProductAxis2.zy.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.zy Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.zy Physics = @s Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.zy Physics *= #Physics.CrossProductAxis2.zy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zy.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.zy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zy.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.zy Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.zy Physics += #Physics.Maths.Value1 Physics

                # Corner 2 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.zy Physics *= #Physics.Constants.-1 Physics

                # Corner 3 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.CrossProductAxis2.zy Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.zy Physics > #Physics.Projection.OtherObject.CrossProductAxis2.zy.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zy.Max Physics = #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.zy Physics
                execute if score #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.zy Physics > #Physics.Projection.OtherObject.CrossProductAxis2.zy.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zy.Max Physics = #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.zy Physics
                execute if score #Physics.Projection.OtherObjectCorner3.CrossProductAxis2.zy Physics > #Physics.Projection.OtherObject.CrossProductAxis2.zy.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zy.Max Physics = #Physics.Projection.OtherObjectCorner3.CrossProductAxis2.zy Physics
                execute store result score #Physics.Projection.OtherObject.CrossProductAxis2.zy.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zy.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zy.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zy Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zy Physics *= #Physics.CrossProductAxis2.zy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zy.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zy.z Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zy Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zy.Min Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zy Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zy.Max Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zy Physics

            # Overlap check
            execute unless score #Physics.Projection.Object.CrossProductAxis2.zy.Min Physics <= #Physics.Projection.OtherObject.CrossProductAxis2.zy.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.CrossProductAxis2.zy.Min Physics <= #Physics.Projection.Object.CrossProductAxis2.zy.Max Physics run return 0

        # Cross Product: z_this x z_other
            # Calculation
            scoreboard players operation #Physics.CrossProductAxis2.zz.x Physics = #Physics.ThisObject Physics.Object.Axis.z.y
            scoreboard players operation #Physics.CrossProductAxis2.zz.x Physics *= @s Physics.Object.Axis.z.z
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.z.z
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.y
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis2.zz.x Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis2.zz.y Physics = #Physics.ThisObject Physics.Object.Axis.z.z
            scoreboard players operation #Physics.CrossProductAxis2.zz.y Physics *= @s Physics.Object.Axis.z.x
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.z.x
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.z
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.CrossProductAxis2.zz.y Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis2.zz.z Physics = #Physics.ThisObject Physics.Object.Axis.z.x
            scoreboard players operation #Physics.CrossProductAxis2.zz.z Physics *= @s Physics.Object.Axis.z.y
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.z.y
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.x
            execute store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.CrossProductAxis2.zz.z Physics -= #Physics.Maths.Value1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis2.zz.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis2.zz.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis2.zz.z Physics /= #Physics.Maths.SquareRoot.Output Physics
            # Projection: This
            # (Important): Because the cross product is perpendicular to this object's z axis, points along that axis have the same projection. Because of this: Corner 1 = Corner 0 / Corner 3 = Corner 2 / Corner 5 = Corner 4 / Corner 7 = Corner 6
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.zz Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.zz Physics *= #Physics.CrossProductAxis2.zz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zz.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.zz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zz.z Physics
                execute store result score #Physics.Projection.ObjectCorner6.CrossProductAxis2.zz Physics store result score #Physics.Projection.Object.CrossProductAxis2.zz.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.zz Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis2.zz Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis2.zz Physics *= #Physics.CrossProductAxis2.zz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zz.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis2.zz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zz.z Physics
                execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis2.zz Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis2.zz Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 2)
                scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis2.zz Physics *= #Physics.Constants.-1 Physics

                # Corner 6 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis2.zz Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis2.zz Physics > #Physics.Projection.Object.CrossProductAxis2.zz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zz.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis2.zz Physics
                execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis2.zz Physics > #Physics.Projection.Object.CrossProductAxis2.zz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zz.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis2.zz Physics
                execute if score #Physics.Projection.ObjectCorner6.CrossProductAxis2.zz Physics > #Physics.Projection.Object.CrossProductAxis2.zz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zz.Max Physics = #Physics.Projection.ObjectCorner6.CrossProductAxis2.zz Physics
                execute store result score #Physics.Projection.Object.CrossProductAxis2.zz.Min Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zz.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zz.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.zz Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.zz Physics *= #Physics.CrossProductAxis2.zz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zz.y Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.zz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zz.z Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.zz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis2.zz Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zz.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis2.zz Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis2.zz.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis2.zz Physics

            # Projection: Other
            # (Important): Because the cross product is perpendicular to the other object's z axis, points along that axis have the same projection. Because of this: Corner 1 = Corner 0 / Corner 3 = Corner 2 / Corner 5 = Corner 4 / Corner 7 = Corner 6
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.zz Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.zz Physics *= #Physics.CrossProductAxis2.zz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zz.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.zz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zz.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner6.CrossProductAxis2.zz Physics store result score #Physics.Projection.OtherObject.CrossProductAxis2.zz.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.zz Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.zz Physics = @s Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.zz Physics *= #Physics.CrossProductAxis2.zz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zz.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.zz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zz.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.zz Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.zz Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 2)
                scoreboard players operation #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.zz Physics *= #Physics.Constants.-1 Physics

                # Corner 6 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.OtherObjectCorner6.CrossProductAxis2.zz Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.zz Physics > #Physics.Projection.OtherObject.CrossProductAxis2.zz.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zz.Max Physics = #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.zz Physics
                execute if score #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.zz Physics > #Physics.Projection.OtherObject.CrossProductAxis2.zz.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zz.Max Physics = #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.zz Physics
                execute if score #Physics.Projection.OtherObjectCorner6.CrossProductAxis2.zz Physics > #Physics.Projection.OtherObject.CrossProductAxis2.zz.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zz.Max Physics = #Physics.Projection.OtherObjectCorner6.CrossProductAxis2.zz Physics
                execute store result score #Physics.Projection.OtherObject.CrossProductAxis2.zz.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zz.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zz.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zz Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zz Physics *= #Physics.CrossProductAxis2.zz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zz.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis2.zz.z Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zz Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zz.Min Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zz Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis2.zz.Max Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis2.zz Physics

            # Overlap check
            execute unless score #Physics.Projection.Object.CrossProductAxis2.zz.Min Physics <= #Physics.Projection.OtherObject.CrossProductAxis2.zz.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.CrossProductAxis2.zz.Min Physics <= #Physics.Projection.Object.CrossProductAxis2.zz.Max Physics run return 0

# HERE ITS WRONG. MIN AND MAX ARE OVERFLOWING?

# Store the other object's ID for later
execute store result storage physics:temp data.B int 1 run scoreboard players get @s Physics.Object.ID

# Get how much each axis is overlapping & get the least overlap
# (Important): If two axes are exactly parallel to each other (Like if the objects are resting ontop of each other), their cross product is [0,0,0]. I'm unsure if discarding cross products with an overlap of 0 or with a value of [0,0,0] is more stable, so I'll revisit it once the resolver is done. For now, I discard cross products with an overlap of 0.
    # x_this
    scoreboard players operation #Physics.Overlap.ObjectAxis.x Physics = #Physics.ThisObject Physics.Object.ProjectionOwnAxis.x.Max
    scoreboard players operation #Physics.Overlap.ObjectAxis.x Physics -= #Physics.Projection.OtherObject.ObjectAxis.x.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.x.Min
    execute if score #Physics.Overlap.ObjectAxis.x Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.ObjectAxis.x Physics = #Physics.Maths.Value1 Physics

    scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.x Physics

    # y_this
    scoreboard players operation #Physics.Overlap.ObjectAxis.y Physics = #Physics.ThisObject Physics.Object.ProjectionOwnAxis.y.Max
    scoreboard players operation #Physics.Overlap.ObjectAxis.y Physics -= #Physics.Projection.OtherObject.ObjectAxis.y.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.y.Min
    execute if score #Physics.Overlap.ObjectAxis.y Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.ObjectAxis.y Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.ObjectAxis.y Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.y Physics

    # z_this
    scoreboard players operation #Physics.Overlap.ObjectAxis.z Physics = #Physics.ThisObject Physics.Object.ProjectionOwnAxis.z.Max
    scoreboard players operation #Physics.Overlap.ObjectAxis.z Physics -= #Physics.Projection.OtherObject.ObjectAxis.z.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.z.Min
    execute if score #Physics.Overlap.ObjectAxis.z Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.ObjectAxis.z Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.ObjectAxis.z Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.z Physics

    # x_other
    scoreboard players operation #Physics.Overlap.OtherObjectAxis.x Physics = #Physics.Projection.Object.OtherObjectAxis.x.Max Physics
    scoreboard players operation #Physics.Overlap.OtherObjectAxis.x Physics -= @s Physics.Object.ProjectionOwnAxis.x.Min
    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.ProjectionOwnAxis.x.Max
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.OtherObjectAxis.x.Min Physics
    execute if score #Physics.Overlap.OtherObjectAxis.x Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.OtherObjectAxis.x Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.OtherObjectAxis.x Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.OtherObjectAxis.x Physics

    # y_other
    scoreboard players operation #Physics.Overlap.OtherObjectAxis.y Physics = #Physics.Projection.Object.OtherObjectAxis.y.Max Physics
    scoreboard players operation #Physics.Overlap.OtherObjectAxis.y Physics -= @s Physics.Object.ProjectionOwnAxis.y.Min
    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.ProjectionOwnAxis.y.Max
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.OtherObjectAxis.y.Min Physics
    execute if score #Physics.Overlap.OtherObjectAxis.y Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.OtherObjectAxis.y Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.OtherObjectAxis.y Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.OtherObjectAxis.y Physics

    # z_other
    scoreboard players operation #Physics.Overlap.OtherObjectAxis.z Physics = #Physics.Projection.Object.OtherObjectAxis.z.Max Physics
    scoreboard players operation #Physics.Overlap.OtherObjectAxis.z Physics -= @s Physics.Object.ProjectionOwnAxis.z.Min
    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.ProjectionOwnAxis.z.Max
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.OtherObjectAxis.z.Min Physics
    execute if score #Physics.Overlap.OtherObjectAxis.z Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.OtherObjectAxis.z Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.OtherObjectAxis.z Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.OtherObjectAxis.z Physics

    # Cross Product: x_this x x_other
    scoreboard players operation #Physics.Overlap.CrossProductAxis2.xx Physics = #Physics.Projection.Object.CrossProductAxis2.xx.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis2.xx Physics -= #Physics.Projection.OtherObject.CrossProductAxis2.xx.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.CrossProductAxis2.xx.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis2.xx.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis2.xx Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis2.xx Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis2.xx Physics unless score #Physics.Overlap.CrossProductAxis2.xx Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis2.xx Physics

    # Cross Product: x_this x y_other
    scoreboard players operation #Physics.Overlap.CrossProductAxis2.xy Physics = #Physics.Projection.Object.CrossProductAxis2.xy.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis2.xy Physics -= #Physics.Projection.OtherObject.CrossProductAxis2.xy.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.CrossProductAxis2.xy.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis2.xy.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis2.xy Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis2.xy Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis2.xy Physics unless score #Physics.Overlap.CrossProductAxis2.xy Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis2.xy Physics

    # Cross Product: x_this x z_other
    scoreboard players operation #Physics.Overlap.CrossProductAxis2.xz Physics = #Physics.Projection.Object.CrossProductAxis2.xz.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis2.xz Physics -= #Physics.Projection.OtherObject.CrossProductAxis2.xz.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.CrossProductAxis2.xz.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis2.xz.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis2.xz Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis2.xz Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis2.xz Physics unless score #Physics.Overlap.CrossProductAxis2.xz Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis2.xz Physics

    # Cross Product: y_this x x_other
    scoreboard players operation #Physics.Overlap.CrossProductAxis2.yx Physics = #Physics.Projection.Object.CrossProductAxis2.yx.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis2.yx Physics -= #Physics.Projection.OtherObject.CrossProductAxis2.yx.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.CrossProductAxis2.yx.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis2.yx.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis2.yx Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis2.yx Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis2.yx Physics unless score #Physics.Overlap.CrossProductAxis2.yx Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis2.yx Physics

    # Cross Product: y_this x y_other
    scoreboard players operation #Physics.Overlap.CrossProductAxis2.yy Physics = #Physics.Projection.Object.CrossProductAxis2.yy.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis2.yy Physics -= #Physics.Projection.OtherObject.CrossProductAxis2.yy.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.CrossProductAxis2.yy.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis2.yy.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis2.yy Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis2.yy Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis2.yy Physics unless score #Physics.Overlap.CrossProductAxis2.yy Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis2.yy Physics

    # Cross Product: y_this x z_other
    scoreboard players operation #Physics.Overlap.CrossProductAxis2.yz Physics = #Physics.Projection.Object.CrossProductAxis2.yz.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis2.yz Physics -= #Physics.Projection.OtherObject.CrossProductAxis2.yz.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.CrossProductAxis2.yz.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis2.yz.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis2.yz Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis2.yz Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis2.yz Physics unless score #Physics.Overlap.CrossProductAxis2.yz Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis2.yz Physics

    # Cross Product: z_this x x_other
    scoreboard players operation #Physics.Overlap.CrossProductAxis2.zx Physics = #Physics.Projection.Object.CrossProductAxis2.zx.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis2.zx Physics -= #Physics.Projection.OtherObject.CrossProductAxis2.zx.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.CrossProductAxis2.zx.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis2.zx.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis2.zx Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis2.zx Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis2.zx Physics unless score #Physics.Overlap.CrossProductAxis2.zx Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis2.zx Physics

    # Cross Product: z_this x y_other
    scoreboard players operation #Physics.Overlap.CrossProductAxis2.zy Physics = #Physics.Projection.Object.CrossProductAxis2.zy.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis2.zy Physics -= #Physics.Projection.OtherObject.CrossProductAxis2.zy.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.CrossProductAxis2.zy.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis2.zy.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis2.zy Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis2.zy Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis2.zy Physics unless score #Physics.Overlap.CrossProductAxis2.zy Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis2.zy Physics

    # Cross Product: z_this x z_other
    scoreboard players operation #Physics.Overlap.CrossProductAxis2.zz Physics = #Physics.Projection.Object.CrossProductAxis2.zz.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis2.zz Physics -= #Physics.Projection.OtherObject.CrossProductAxis2.zz.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.CrossProductAxis2.zz.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis2.zz.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis2.zz Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis2.zz Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis2.zz Physics unless score #Physics.Overlap.CrossProductAxis2.zz Physics matches 0 run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zz/main

# Get the involved features of both objects
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.x Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis_x/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis_x/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.z Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis_x/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.OtherObjectAxis.x Physics run return run function physics:zprivate/contact_generation/new_contact/object/other_axis_x/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.OtherObjectAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/object/other_axis_x/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.OtherObjectAxis.z Physics run return run function physics:zprivate/contact_generation/new_contact/object/other_axis_x/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis2.xx Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xx/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis2.xy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xy/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis2.xz Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xz/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis2.yx Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yx/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis2.yy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yy/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis2.yz Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yz/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis2.zx Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zx/main
function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zy/main
