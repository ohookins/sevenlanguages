module Main where
    colours = ["black", "white", "blue", "yellow", "red"]

    colourTuples :: [([Char], [Char])]
    colourTuples = [(a,b) | a <- colours, b <- colours, a < b]
