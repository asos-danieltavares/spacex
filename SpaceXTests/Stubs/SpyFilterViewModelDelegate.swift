@testable import SpaceX

final class SpyFilterViewModelDelegate: FilterViewModelDelegate {

    var dismissCalled = false

    func dismiss() {
        dismissCalled = true
    }
}
