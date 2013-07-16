import scala.util.Random

object Board {
    // Represent a board as an array of 9 character literals.
    var cells = Array(' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ')

    // Select the first player randomly
    var player = 'X'
    if (Random.nextBoolean()) {
        player = 'O'
    }

    // Nested lists for checking winning moves
    // involving three of one player's character
    // in a row.
    val row1 = List(0,1,2)
    val row2 = List(3,4,5)
    val row3 = List(6,7,8)
    val rows = List(row1, row2, row3)
    val col1 = List(0,3,6)
    val col2 = List(1,4,7)
    val col3 = List(2,5,8)
    val cols = List(col1, col2, col3)
    val dia1 = List(0,4,8)
    val dia2 = List(2,4,6)
    val dias = List(dia1, dia2)
    val triples = List(rows, cols, dias)

    // Alternate players between each move
    def alternatePlayer() {
        if (player == 'X') {
            player = 'O'
        } else {
            player = 'X'
        }
    }

    // Make the actual move, which involves checking validity
    // and whether it won or not.
    def move(cell: Int) {
        if (!validMove(cell)) {
            println("Invalid move!")
            return
        }
        cells(cell) = player

        checkWinningMove()
        alternatePlayer()
    }

    // Valid moves are bounded by board size and can only be made into
    // empty cells.
    def validMove(cell: Int):Boolean = {
        if (cell < 0 || cell >= cells.length) {
            return false
        }

        if (cells(cell) != ' ') {
            return false
        }

        return true
    }

    // Iterate through each set of three cells that produces a winning move,
    // checking for three of the same character.
    // If all cells are filled and no winning move was detected, it is a tie.
    def checkWinningMove() {
        triples.foreach { triple =>
            triple.foreach { line =>
                var test_line = List(cells(line(0)), cells(line(1)), cells(line(2)))
                if (test_line.distinct.length == 1 && test_line(0) != ' ') {
                    this.print()
                    println(test_line(0) + " is the winning player!")
                    sys.exit()
                }
            }
        }

        cells.foreach { cell =>
            if (cell == ' ') {
                return
            }
        }
        println("Both players tied!")
        sys.exit()
    }

    // Print the current state of the board in ASCII art
    def print() {
        println("Current player: " + player)
        println(cells(0) + "|" + cells(1) + "|" + cells(2))
        println("-----")
        println(cells(3) + "|" + cells(4) + "|" + cells(5))
        println("-----")
        println(cells(6) + "|" + cells(7) + "|" + cells(8))
    }
}

// Start the game
var input = 0
while(true) {
    Board.print()
    println()
    try {
        input = Console.readInt()
        Board.move(input)
    } catch {
        // Catch a EOF and any non-int values entered.
        case e:java.io.EOFException => println("Game over!"); sys.exit()
        case e:java.lang.NumberFormatException => println("Enter a number")
    }
}
