# SpaceX iOS Task 📱

### Future Improvements

If spending longer on this project, there are a number of improvements I would suggest:-

**1. Add Snapshot tests**

Import the `SnapshotTesting` library from [Pointfree](https://github.com/pointfreeco/swift-snapshot-testing)
 and add a series of snapshot tests to cover each of the view controllers and views.

**2. Add error view**

I left a TODO/warning around implementing an error view within the first screen; in case the API is ever down, the API changes (and we are unable to decode the response) or no launches are returned.

**3. Add pull to refresh support**

Currently there is no pull to refresh support within the first index page. This would be good to add.

**4. Switch to stubbed data for UI tests**

I added some UI tests to cover the existing navigation flow. Unfortunately they are run against a live endpoint; so if the API was to go down, then these tests would fail. A tool like `Catbird` may be good to add for mocking. There are also a couple of integration tests around `ImageLoader` and `ResourceLoader`. Again, it would be good to switch these to point to a mock server.

**5. Add accessibility identifiers to elements for use within UI tests**

The UI tests added follow the Page Object Model (POM) pattern. The XCUIElements within each of the pages are currently being accessed via the text E.g.

```swift
private var falconSatMissionLabel: XCUIElement {
    app.staticTexts["FalconSat"]
}
```

This is not particularly great; a more flexible approach would be to add an `accessibilityIdentifier` to each of the elements and identifying them this way. 

**6. Improve dynamic type support**

The first/index page consists of a number of labels. The left aligned labels have a fixed width (to try and match the design within the brief). This is not particularly great if a user has a larger text size set (as the labels will either truncate or push down onto additional lines).

**7. Switch over to attributed strings**

Currently a number of labels just have a text string applied to them & the font style is being defined within a nib. It would be good to migrate over to NSAttributedStrings and make greater use of the `TypographyProvider` protocol added. This would allow font sizes and text colours to be defined somewhere centrally. 

**8. Improve list page when no results found**

If the user changes the filter, for example selecting the year 2013 and mission successful as false; then no results are shown. It would be good to provide some context to the user that there are no matching results for their search requirements.

**9. Add Swiftlint**

It would be good to add Swiftlint as a build phase to ensure that any linting errors are caught early. 

**10. Add landscape support**

The index page works well in landscape mode; however the filter page doesn't. Would update this page to support scrolling.
