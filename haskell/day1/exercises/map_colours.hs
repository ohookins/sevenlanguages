module Main where
    colours = ["red", "green", "blue"]

    mapColours :: [[([Char], [Char])]]
    mapColours =
        [[("Tennessee", colour1), ("Mississippi", colour2), ("Alabama", colour3), ("Georgia", colour4), ("Florida", colour5)] |
            colour1 <- colours,
            colour2 <- colours,
            colour3 <- colours,
            colour4 <- colours,
            colour5 <- colours,
            colour1 /= colour2, -- Tennessee / Mississippi
            colour1 /= colour3, -- Tennessee / Alabama
            colour1 /= colour4, -- Tennessee / Georgia
            colour2 /= colour3, -- Mississippi / Alabama
            colour3 /= colour4, -- Alabama / Georgia
            colour3 /= colour5, -- Alabama / Florida
            colour4 /= colour5] -- Georgia / Florida
