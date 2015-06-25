module Main where
    mathTables :: [(Integer, Integer, Integer)]
    mathTables = [(x,y,x*y) | x <- [1..12], y <- [1..12]]
