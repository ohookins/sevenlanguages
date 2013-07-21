import scala.collection.mutable.HashMap
import scala.util.matching.Regex
import scala.io.Source

trait Censor {
    val wordRegex = new Regex("""(\w+)""", "word")

    def replace(input:String, replacements:HashMap[String,String]) : String = {
        return wordRegex replaceAllIn (input, m =>
            if (replacements.contains(m.group("word"))) {
                replacements(m.group("word"))
            } else {
                m.group("word")
            })
    }
}

object Book extends Censor {
    val mytext = "Aw shoot I forgot my darn car keys! Darn things keep going missing."
    val replacements = new HashMap[String,String]

    def censor(filename:String) {
        Source.fromFile(filename).getLines().foreach(line =>
            replacements += ((line.split("\t")(0), line.split("\t")(1)))
        )

        println(replace(mytext, replacements))
    }
}

Book.censor("censorWords.txt")
