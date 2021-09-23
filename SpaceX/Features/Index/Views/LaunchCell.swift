import UIKit
import Localization
import Combine
import protocol Networking.ImageLoadable

protocol ImageCellLoading {
    func loadImage(forUrl url: URL)
}

final class LaunchCell: UICollectionViewCell {

    // MARK: - Properties
    private weak var imageLoader: ImageLoadable?
    private var cancellable: AnyCancellable?

    // MARK: - Outlets
    @IBOutlet private weak var launchStatusImageView: UIImageView!
    @IBOutlet private weak var launchImageView: UIImageView!
    @IBOutlet private weak var missionNamePlaceholderLabel: UILabel!
    @IBOutlet private weak var missionNameLabel: UILabel!
    @IBOutlet private weak var datePlaceholderLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var rocketPlaceholderLabel: UILabel!
    @IBOutlet private weak var rocketLabel: UILabel!
    @IBOutlet private weak var daysPlaceholderLabel: UILabel!
    @IBOutlet private weak var daysLabel: UILabel!

    // MARK: - Overridden
    override func prepareForReuse() {
        super.prepareForReuse()

        applyImagePlaceholders()
        imageLoader = nil
        cancellable?.cancel()
        cancellable = nil
    }

    // MARK: - Public Facing API
    func configure(using viewModel: LaunchViewModel,
                   imageLoader: ImageLoadable?) {

        self.imageLoader = imageLoader

        applyImagePlaceholders()

        configureMissionName(using: viewModel)
        configureLaunchStatusImage(using: viewModel)
        configureDateTime(using: viewModel)
        configureRocket(using: viewModel)
        configureDays(using: viewModel)
    }
}

// MARK: - ImageCellLoading conformance
extension LaunchCell: ImageCellLoading {

    func loadImage(forUrl url: URL) {
        cancellable = imageLoader?.loadImage(for: url)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] image in
                    self?.launchImageView.image = image
                  })
    }
}

// MARK: - Private Implementation Details
private extension LaunchCell {

    func applyImagePlaceholders() {
        launchImageView.image = UIImage(named: "placeholder", in: .main, compatibleWith: nil)
        launchStatusImageView.image = nil
    }

    func configureLaunchStatusImage(using viewModel: LaunchViewModel) {
        launchStatusImageView.image = viewModel.imageName.flatMap {
            UIImage(named: $0, in: .main, compatibleWith: nil)
        }
    }

    func configureMissionName(using viewModel: LaunchViewModel) {
        missionNamePlaceholderLabel.text = String(.mission)
        missionNameLabel.text = viewModel.missionName
    }

    func configureDateTime(using viewModel: LaunchViewModel) {
        datePlaceholderLabel.text = String(.dateTime)
        dateLabel.text = viewModel.launchDateTime
    }

    func configureRocket(using viewModel: LaunchViewModel) {
        rocketPlaceholderLabel.text = String(.rocket)
        rocketLabel.text = viewModel.rocketInfo
    }

    func configureDays(using viewModel: LaunchViewModel) {
        daysPlaceholderLabel.text = viewModel.daysPlaceholder
        daysLabel.text = viewModel.days
    }
}
