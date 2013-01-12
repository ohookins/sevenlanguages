// FIXME: DOES NOT WORK

// More or less everything is executed in the context of the Builder
Builder := Object clone

// Set up the JSON-like map initialisation syntax
OperatorTable addAssignOperator(":", "atPutValue")
Builder curlyBrackets := method(
  r := Map clone
  call message arguments foreach(arg,
    r doMessage(arg)
	)
  r
)
Map atPutValue := method(
  self atPut(
		call evalArgAt(0) asMutable removePrefix("\"") removeSuffix("\""),
		call evalArgAt(1))
)

// Indentation trackers and convenience methods
Builder indent_level := 0
Builder indent := method(
  str := ""
  indent_level repeat(str = str .. "    ")
  str
)
Builder incr := method(
  indent_level = indent_level + 1
)
Builder decr := method(
  indent_level = indent_level - 1
)

// Method for handling any element recursively
Builder forward := method(

	// Leave the element open in case we need to append attributes
	xml := indent .. "<" .. call message name

  incr
  call message arguments foreach(arg,
		content := self doMessage(arg)
		writeln(content)

		// Map of attributes: it goes inside the element.
		if(content type == "Map",
			content foreach(key, value,
				xml := xml .. " " .. key .. "=\"" .. value .. "\""
			)
			xml := xml .. "\">"
		)

		// Plain content: it becomes nested within open/close element tags.
    if(content type == "Sequence",
      xml := xml .. indent .. content
    )
  );
  decr
  xml := xml .. indent .. "</" .. call message name .. ">"
	return xml
)

// Input has to be in a different file due to this:
// http://tech.groups.yahoo.com/group/iolanguage/message/12574
xml := File with("foo.txt") openForReading contents
doString(xml) println
