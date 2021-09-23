import UIKit

final class FilterViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: FilterViewModel

    @IBOutlet private weak var sortOrderLabel: UILabel!
    @IBOutlet private weak var sortOrderSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var missionSuccessfulLabel: UILabel!
    @IBOutlet private weak var missionSuccessfulSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var yearsLabel: UILabel!
    @IBOutlet private weak var yearsPicker: UIPickerView!
    @IBOutlet private weak var dismissButton: UIButton!

    // MARK: - Initialisers
    init(viewModel: FilterViewModel, theming: ThemingProvider) {
        self.viewModel = viewModel

        super.init(nibName: String(describing: type(of: self)), bundle: .main)

        configureTheming(theming)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden
    override func viewDidLoad() {
        super.viewDidLoad()

        configurePageTitle()
        configureDismissButton()
        configureSortBy()
        configureMissionSuccessful()
        configureYears()
    }

    // MARK: - IBActions
    @IBAction func dismissTapped() {
        viewModel.dismiss()
    }

    @IBAction func missionSuccessfulUpdated(_ sender: UISegmentedControl) {
        viewModel.updateMissionSuccessfulPreference(sender.selectedSegmentIndex)
    }

    @IBAction func sortOrderUpdated(_ sender: UISegmentedControl) {
        viewModel.updateSortOrder(sender.selectedSegmentIndex)
    }

    // MARK: - Private Implementation Details
    private func configureTheming(_ theming: ThemingProvider) {
        view.backgroundColor = theming.backgroundColor
    }

    private func configurePageTitle() {
        navigationItem.title = viewModel.pageTitle
    }

    private func configureDismissButton() {
        dismissButton.setTitle(viewModel.dismissTitle, for: .normal)
    }

    private func configureSortBy() {
        sortOrderLabel.attributedText = viewModel.sortByTitle
        sortOrderSegmentedControl.setTitle(viewModel.ascendingTitle, forSegmentAt: 0)
        sortOrderSegmentedControl.setTitle(viewModel.descendingTitle, forSegmentAt: 1)
        sortOrderSegmentedControl.selectedSegmentIndex = viewModel.sortByPreference
    }

    private func configureMissionSuccessful() {
        missionSuccessfulLabel.attributedText = viewModel.missionSuccessfulTitle
        missionSuccessfulSegmentedControl.setTitle(viewModel.yesLabelTitle, forSegmentAt: 0)
        missionSuccessfulSegmentedControl.setTitle(viewModel.noLabelTitle, forSegmentAt: 1)
        missionSuccessfulSegmentedControl.setTitle(viewModel.noPreferenceLabelTitle, forSegmentAt: 2)
        missionSuccessfulSegmentedControl.selectedSegmentIndex = viewModel.missionSuccessfulPreference
    }

    private func configureYears() {
        yearsLabel.attributedText = viewModel.filterByYearTitle

        yearsPicker.delegate = self
        yearsPicker.dataSource = self

        yearsPicker.selectRow(viewModel.selectedYear, inComponent: 0, animated: false)
    }
}

extension FilterViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        viewModel.updateYearPreference(row)
    }
}

extension FilterViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.years.count
    }

    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        viewModel.years[row]
    }
}
