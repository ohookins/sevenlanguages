Builder := Object clone

Builder indent_level := 0

Builder indent := method(
	str := ""
	for(i, 1, indent_level,
		str = str .. "    "
	)
	str
)

Builder incr := method(
	indent_level = indent_level + 1
)
Builder decr := method(
	indent_level = indent_level - 1
)

Builder forward := method(
	writeln(indent, "<", call message name, ">")
	incr
	call message arguments foreach(
		arg,
		content := self doMessage(arg);
		if(content type == "Sequence",
			writeln(indent, content)
		));
	decr
	writeln(indent, "</", call message name, ">"))

Builder ul(
	li("Io" ),
	li("Lua" ),
	li("JavaScript" ))
