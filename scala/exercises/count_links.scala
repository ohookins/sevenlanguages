import scala.io._
import scala.actors._
import Actor._

// START:loader
object PageLoader {
 val link = """<a href="([^"]+)">""".r
 def getPageLinks(url : String) = link.findAllMatchIn(Source.fromURL(url).mkString).length
}
// END:loader

val urls = List("http://www.amazon.com/",
               "https://www.twitter.com/",
               "http://www.google.com/",
               "http://www.cnn.com/" )

// START:time
def timeMethod(method: () => Unit) = {
 val start = System.nanoTime
 method()
 val end = System.nanoTime
 println("Method took " + (end - start)/1000000000.0 + " seconds.")
}
// END:time

// START:sequential
def getPageLinksSequentially() = {
 for(url <- urls) {
   println("Links for " + url + ": " + PageLoader.getPageLinks(url))
 }
}
// END:sequential

// START:concurrent
def getPageLinksConcurrently() = {
 val caller = self

 for(url <- urls) {
   actor { caller ! (url, PageLoader.getPageLinks(url)) }
 }

 for(i <- 1 to urls.size) {
   receive {
     case (url, count) =>
       println("Links for " + url + ": " + count)
   }
 }
}
// END:concurrent

// START:script
println("Sequential run:")
timeMethod { getPageLinksSequentially }

println("Concurrent run")
timeMethod { getPageLinksConcurrently }
// END:script
