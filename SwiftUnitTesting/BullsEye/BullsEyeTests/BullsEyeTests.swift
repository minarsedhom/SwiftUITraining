/// Copyright (c) 2023 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import XCTest
@testable import BullsEye

final class BullsEyeTests: XCTestCase {
  //This creates a placeholder for BullsEyeGame,
  //which is the System Under Test (SUT), or the object this test case class is concerned with testing.

  var sut: BullsEyeGame! //System Under Test(sut)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
      try super.setUpWithError()
      sut = BullsEyeGame()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      sut = nil
      try super.tearDownWithError()
    }
  
  func testScoreIsComputedWhenGuessIsHigherThanTarget() {
    // given
    let guess = sut.targetValue + 5

    // when
    sut.check(guess: guess)

    // then
    XCTAssertEqual(sut.scoreRound, 95, "Score computed from guess is wrong")
  }
  
  func testScoreIsComputedWhenGuessIsLowerThanTarget() {
    // given
    let guess = sut.targetValue - 5

    // when
    sut.check(guess: guess)

    // then
    XCTAssertEqual(sut.scoreRound, 95, "Score computed from guess is wrong")
  }
  
  //Testing Performance
  func testScoreIsComputedPerformance() {
    measure(
      metrics: [
        XCTClockMetric(),
        XCTCPUMetric(),
        XCTStorageMetric(),
        XCTMemoryMetric()
      ]
    ) {
      sut.check(guess: 100)
    }
  }
}

//Notes:
//1- It’s good practice creating the SUT in setUpWithError() and releasing it in tearDownWithError() to ensure every test starts with a clean slate. For more discussion, check out Jon Reid’s post on the subject.

//Click Set Baseline to set a reference time. Run the performance test again and view the result — it might be better or worse than the baseline. The Edit button lets you reset the baseline to this new result.
//Baselines are stored per device configuration, so you can have the same test executing on several different devices. Each can maintain a different baseline dependent upon the specific configuration’s processor speed, memory, etc.
//Any time you make changes to an app that might impact the performance of the method being tested, run the performance test again to see how it compares to the baseline.

//Enabling Code Coverage
//The code coverage tool tells you what app code your tests are actually running, so you know what parts of the app aren’t tested — at least, not yet.
