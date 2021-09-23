import UIKit
import Combine
import protocol Networking.ImageLoadable

final class IndexViewController: UICollectionViewController {

    // MARK: - Properties
    private let imageLoader: ImageLoadable
    private let viewModel: IndexViewModel
    private var cancellable: AnyCancellable?
    private var dataSource: UICollectionViewDiffableDataSource<Section, LaunchViewModel>!

    // MARK: - Initialisers
    required init(viewModel: IndexViewModel,
                  theming: ThemingProvider,
                  imageLoader: ImageLoadable) {
        self.viewModel = viewModel
        self.imageLoader = imageLoader

        super.init(collectionViewLayout: .generateSpaceXIndexLayout())

        configurePageTitle()
        configureTheming(theming)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCellDataSource()
        configureHeaderDataSource()

        viewModel.fetchDetails()

        cancellable = viewModel.$state.sink { [weak self] state in
            self?.render(state)
        }
    }

    // MARK: - Actions
    @objc func filter(_ sender: Any) {
        viewModel.filterSelected()
    }
}

// MARK: - UICollectionViewDelegate
extension IndexViewController {

    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {

        if let selectedViewModel = dataSource.itemIdentifier(for: indexPath) {
            viewModel.launchSelected(selectedViewModel)
        }
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 willDisplay cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {

        if let imageLoadingCell = cell as? ImageCellLoading,
           let selectedViewModel = dataSource.itemIdentifier(for: indexPath),
           let url = selectedViewModel.patchImageUrl {
            imageLoadingCell.loadImage(forUrl: url)
        }
    }
}

// MARK - Private Implementation Details
private extension IndexViewController {

    func configureHeaderDataSource() {

        let headerNib = UINib(nibName: "HeaderView", bundle: .main)

        let headerRegistration = UICollectionView.SupplementaryRegistration<HeaderView>(supplementaryNib: headerNib, elementKind: "Header") { [weak self] supplementaryView, _, indexPath in
            guard let headerViewModel = self?.viewModel.headerViewModel else { return }
            supplementaryView.configure(using: headerViewModel)
        }

        dataSource.supplementaryViewProvider = { [weak self] supplementaryView, _, indexPath in
            self?.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
    }

    func configureCellDataSource() {

        let cellNib = UINib(nibName: "LaunchCell", bundle: .main)

        let cellRegistration = UICollectionView.CellRegistration<LaunchCell, LaunchViewModel>(cellNib: cellNib) { [unowned self] cell, _, viewModel in
            cell.configure(using: viewModel, imageLoader: self.imageLoader)
        }

        dataSource = UICollectionViewDiffableDataSource<Section, LaunchViewModel>(collectionView: collectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }

    func render(_ state: IndexViewModel.State) {

        switch state {
        case .error:
            configureErrorState()
        case .loaded(let viewModels):
            configureFilterButton()
            configureLoadedState(viewModels)
        case .reload(let viewModels):
            configureReloadState(viewModels)
        case .loading:
            configureLoadingState()
        }
    }

    func configureLoadedState(_ viewModels: [LaunchViewModel]) {

        var snapshot = DiffableDataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModels)

        dataSource.apply(snapshot, animatingDifferences: false)

        collectionView.backgroundView = nil
    }

    func configureReloadState(_ viewModels: [LaunchViewModel]) {

        var newSnapshot = dataSource.snapshot()
        newSnapshot.deleteAllItems()

        newSnapshot.appendSections([.main])
        newSnapshot.appendItems(viewModels)

        dataSource.apply(newSnapshot, animatingDifferences: false)
    }

    func configureErrorState() {
        #warning("TODO: Add error view")
    }

    func configureLoadingState() {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.startAnimating()

        collectionView.backgroundView = loadingIndicator
    }

    func configurePageTitle() {
        navigationItem.title = viewModel.pageTitle
    }

    func configureTheming(_ theming: ThemingProvider) {
        collectionView.backgroundColor = theming.backgroundColor
    }

    func configureFilterButton() {

        let filterImage = UIImage(named: "filter-icon")?.withRenderingMode(.alwaysOriginal)
        let filterButton = UIBarButtonItem(image: filterImage, style: .done, target: self, action: #selector(filter))

        navigationItem.rightBarButtonItem = filterButton
    }
}

// MARK: - Data Structures
private extension IndexViewController {

    typealias DiffableDataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, LaunchViewModel>

    enum Section {
        case title
        case main
    }
}
