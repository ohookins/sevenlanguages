module Main where
    list_reverse :: [Integer] -> [Integer]
    list_reverse [] = []
    list_reverse (h:t) = list_reverse t ++ [h]
