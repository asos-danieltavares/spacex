import Foundation

typealias Typography = [NSAttributedString.Key: Any]

protocol TypographyProvider {
    func listPlaceholderTitle() -> Typography
    func listTitle() -> Typography
    func filterHeading() -> Typography
    func filterButtonTitle() -> Typography
}
