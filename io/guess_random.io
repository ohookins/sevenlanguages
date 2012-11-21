# Set up the random number and input
# IMPORTANT: Since we are using the Random module, this current file MUST NOT
# be itself named random.io - the world will implode!
rand := Random value(100) round
input := File standardInput

# Set up answer placeholder
currAnswer := -1

"Please guess the number between 0 and 100" println
loop(
  prevAnswer := currAnswer
  currAnswer := input readLine asNumber

  # Attempt to see if the latest guess was better or worse than the last.
  if(currAnswer == rand, "You got it!" println; break,
    if(prevAnswer == -1, "Guess again" println; continue,
      previousGap := (prevAnswer - rand) abs
      currentGap := (currAnswer - rand) abs

      if(currentGap < previousGap, "hotter" println; continue)
      if(currentGap > previousGap, "colder" println; continue)
    )
  )

  "Guess again" println
)

exit(0)
