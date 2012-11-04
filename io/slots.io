# Simple object clone, add a method into a slot and call it.
obj1 := Object clone
obj1 aMethod := method("This is text printed from obj1." println)
obj1 aMethod
"--- obj1 slots ---" println
obj1 slotNames println

# Clone Object into a prototype, add two slots: one with setter and one without
Obj2 := Object clone
Obj2 noSetter := 1
Obj2 noSetter = 2
"--- Obj2 (type) slots without setter ---" println
Obj2 slotNames println

# ::= adds a setter
Obj2 myvar ::= 3
Obj2 setMyvar(4)
"--- Obj2 (type) slots including setter ---" println
Obj2 slotNames println

# Clone the prototype and show the slots only on this object.
# Slots are not inherited - slot calls are passed up the chain.
obj3 := Obj2 clone
"--- obj3 from Obj2 (type) clone ---" println
obj3 proto println
obj3 slotNames println

# Now use the setter method to create and set the slot on this cloned object.
"obj3 myvar = " println
obj3 myvar println
obj3 setMyvar(6)
obj3 myvar println
obj3 slotNames println

# Setting a new value in the prototype object has no effect as we already
# have a slot of the same name in the child object.
Obj2 setMyvar(7)
Obj2 myvar println
obj3 myvar println
