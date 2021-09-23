import UIKit

final class HeaderView: UICollectionReusableView {

    // MARK: - Outlets
    @IBOutlet private weak var companyTitleLabel: UILabel!
    @IBOutlet private weak var companyInformationLabel: UILabel!
    @IBOutlet private weak var launchesTitleLabel: UILabel!

    // MARK: - Public Facing API
    func configure(using viewModel: HeaderViewModel) {
        companyTitleLabel.text = viewModel.companyTitle
        companyInformationLabel.text = viewModel.companyInformation
        launchesTitleLabel.text = viewModel.launchesTitle
    }
}
