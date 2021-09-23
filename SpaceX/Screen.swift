import Models
import Combine

enum Screen {
    case index
    case links(name: String, links: [Launch.Link])
    case filterOptions(subject: FilterSubject, criteria: FilterCriteria, years: [Int])
    case safariWebview(URL)
}
