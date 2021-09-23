import UIKit

struct SpaceXTypography: TypographyProvider {

    func listPlaceholderTitle() -> Typography {
        [
            .font: UIFont.preferredFont(forTextStyle: .caption2),
            .foregroundColor: UIColor.label
        ]
    }

    func listTitle() -> Typography {
        [
            .font: UIFont.preferredFont(forTextStyle: .caption2),
            .foregroundColor: UIColor.label
        ]
    }

    func filterHeading() -> Typography {
        [
            .font: UIFont.preferredFont(forTextStyle: .headline),
            .foregroundColor: UIColor.label
        ]
    }

    func filterButtonTitle() -> Typography {
        [
            .font: UIFont.preferredFont(forTextStyle: .body),
            .foregroundColor: UIColor.label
        ]
    }
}
