import scala.io._
import scala.actors._
import Actor._
import scala.collection.mutable.Set

object PageLoader {
    val linkRegex = """<a href="([^"]+)">""".r

    def getPageSize(url : String, recurse : Boolean = false) = {
        // Retrieve the top-level page
        val page = Source.fromURL(url).mkString
        var totalSize = page.length
        var subpages = Set("/")

        // Find each link, and enter it into a set to avoid duplication
        linkRegex.findAllMatchIn(page) foreach { m =>
            subpages.add(m.group(1))
        }

        // Remove link to the main page itself
        subpages.remove("/")

        // Get subpage lengths in a separate function
        val caller = self
        subpages.foreach { p =>
            actor { caller ! SubPageFetcher.getSubpageSize(url, p) }
        }

        // Wait for each result from a subpage actor
        for(i <- 1 to subpages.size) {
            receive {
                case subpageSize:Int =>
                    totalSize += subpageSize
            }
        }
        totalSize
    }
}

object SubPageFetcher {
    def getSubpageSize(parentPage : String, subPage : String) : Int = {
        val parentProtocol = """^https?""".r.findFirstIn(parentPage).get
        val parentDomain = """^https?://([^/]+)/""".r.findFirstMatchIn(parentPage).get.group(1)
        var subpageUrl = ""

        // Reconstruct relative links
        if (subPage.substring(0,2) == "//") {
            subpageUrl = parentProtocol + ":" + subPage
        } else if (subPage.substring(0,1) == "/") {
            subpageUrl = parentProtocol + "://" + parentDomain + subPage
        } else if (subPage.substring(0,10) == "javascript") {
            return 0
        } else {
            subpageUrl = subPage
        }

        // Catch ProtocolExceptions due to redirect loops
        // Catch IOException due to missing or unauthorized pages
        try {
            return Source.fromURL(subpageUrl).mkString.length
        } catch {
            case e:java.net.ProtocolException => return 0
            case e:java.io.IOException => return 0
        }
    }
}

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

def getPageSizesConcurrently() = {
    val caller = self

    for(url <- urls) {
        actor { caller ! (url, PageLoader.getPageSize(url)) }
    }

    for(i <- 1 to urls.size) {
        receive {
            case (url, size) =>
                println("Total size for " + url + " and sub-pages: " + size)
        }
    }
}

// No point running sequentially, it is far too slow.
println("Concurrent run")
timeMethod { getPageSizesConcurrently }
