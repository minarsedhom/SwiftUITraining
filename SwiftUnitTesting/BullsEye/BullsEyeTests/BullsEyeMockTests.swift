import XCTest

@testable import BullsEye

//MockUserDefaults overrides set(_:forKey:) to increment gameStyleChanged. Similar tests often set a Bool variable, but incrementing Int gives you more flexibility. For example, your test could check that the app only calls the method once.
class MockUserDefaults: UserDefaults {
  var gameStyleChanged = 0
  override func set(_ value: Int, forKey defaultName: String) {
    if defaultName == "gameStyle" {
      gameStyleChanged += 1
    }
  }
}

final class BullsEyeMockTests: XCTestCase {
  var sut: ViewController!
  var mockUserDefaults: MockUserDefaults!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = UIStoryboard(name: "Main", bundle: nil)
      .instantiateInitialViewController() as? ViewController
    mockUserDefaults = MockUserDefaults(suiteName: "testing")
    sut.defaults = mockUserDefaults
  }

  override func tearDownWithError() throws {
    sut = nil
    mockUserDefaults = nil
    try super.tearDownWithError()
  }
  //The when assertion is that the gameStyleChanged flag is 0 before the test method changes the segmented control. So, if the then assertion is also true, it means set(_:forKey:) was called exactly once.

  func testGameStyleCanBeChanged() {
    // given
    let segmentedControl = UISegmentedControl()

    // when
    XCTAssertEqual(
      mockUserDefaults.gameStyleChanged,
      0,
      "gameStyleChanged should be 0 before sendActions")
    segmentedControl.addTarget(
      sut,
      action: #selector(ViewController.chooseGameStyle(_:)),
      for: .valueChanged)
    segmentedControl.sendActions(for: .valueChanged)

    // then
    XCTAssertEqual(
      mockUserDefaults.gameStyleChanged,
      1,
      "gameStyle user default wasn't changed")
  }
}
