module Main where
    allEven1 :: [Integer] -> [Integer]
    allEven1 [] = []
    allEven1 (h:t) = if even h then h:allEven1 t else allEven1 t

    allEven2 :: [Integer] -> [Integer]
    allEven2 [] = []
    allEven2 (h:t)
        | even h = h:allEven2 t
        | otherwise = allEven2 t

    allEven3 :: [Integer] -> [Integer]
    allEven3 y = [x | x <- y, even x]
