# Calculate DeltaVelocity (Desired velocity change)
# (Important): -(1 + RestitutionCoefficient) * SeparatingVelocity
execute store result score #Physics.Maths.DeltaVelocity Physics run data get storage physics:resolution Contact.RestitutionCoefficient
scoreboard players add #Physics.Maths.DeltaVelocity Physics 100

scoreboard players operation #Physics.Maths.DeltaVelocity Physics *= #Physics.MinSeparatingVelocityTotal Physics
scoreboard players operation #Physics.Maths.DeltaVelocity Physics *= #Physics.Constants.-1 Physics

# Calculate orthonormal basis
# (Important): The orthonormal basis is a 3x3 matrix. The first column is the contact normal, the 2nd and 3rd columns are tangents.
# (Important): For axis-aligned contact normals like here, this is trivial, so I just directly incorporate it into subsequent formulas for performance reasons. Here, it's: [[±1.0, 0.0, 0.0],[0.0, 1.0, 0.0],[0.0, 0.0, 1.0]]

# Transform ContactVelocity from world space to contact space
# (Important): To avoid matrix multiplication, I instead do: ContactVelocityContactSpace.<x/y/z> = ContactVelocity * <respective column of orthonormal basis> (Dot product)
# (Important): Here, the ContactVelocity is already in contact space.
execute store result score #Physics.Maths.ContactVelocityContactSpace.x Physics run data get storage physics:resolution Contact.ContactVelocity[0]
execute store result score #Physics.Maths.ContactVelocityContactSpace.y Physics run data get storage physics:resolution Contact.ContactVelocity[1]
execute store result score #Physics.Maths.ContactVelocityContactSpace.z Physics run data get storage physics:resolution Contact.ContactVelocity[2]

# Calculate effective mass along the 3 contact axes (3 columns of the orthonormal basis)
# xxx
