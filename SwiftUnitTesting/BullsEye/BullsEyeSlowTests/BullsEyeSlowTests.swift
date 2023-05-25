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


final class BullsEyeSlowTests: XCTestCase {
  var sut: URLSession!
  //Apple introduced XCTSkip to skip a test when preconditions fail. Add the following line below the declaration of sut:
  let networkMonitor = NetworkMonitor.shared

  
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
      try super.setUpWithError()
       sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      sut = nil
      try super.tearDownWithError()
    }

//  1- expectation(description:): Returns XCTestExpectation, stored in promise. description describes what you expect to happen.
// 2- promise.fulfill(): Call this in the success condition closure of the asynchronous method’s completion handler to flag that the expectation has been met.
// 3- wait(for:timeout:): Keeps the test running until all expectations are fulfilled or the timeout interval ends, whichever happens first.
//
  // Asynchronous test: success fast, failure slow
  func testValidApiCallGetsHTTPStatusCode200() throws {
    //XCTSkipUnless(_:_:) skips the test when no network is reachable. Check this by disabling your network connection and running the test. You’ll see a new icon in the gutter next to the test, indicating that the test neither passed nor failed.
    try XCTSkipUnless(
      networkMonitor.isReachable,
      "Network connectivity needed for this test.")

    // given
    let urlString =
      "https://www.random.org/strings/?num=1&len=2&digits=on&format=plain&rnd=new"
    let url = URL(string: urlString)!
    // 1
    let promise = expectation(description: "Status code: 200")

    // when
    let dataTask = sut.dataTask(with: url) { _, response, error in
      // then
      if let error = error {
        XCTFail("Error: \(error.localizedDescription)")
        return
      } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
        if statusCode == 200 {
          // 2
          promise.fulfill()
        } else {
          XCTFail("Status code: \(statusCode)")
        }
      }
    }
    dataTask.resume()
    // 3
    wait(for: [promise], timeout: 5)
  }
  
  //The key difference is that simply entering the completion handler fulfills the expectation, and this only takes about a second to happen. If the request fails, the then assertions fail.
  
  //It fails because the request failed, not because the test run exceeded timeout.
  
  func testApiCallCompletes() throws {
    try XCTSkipUnless(
      networkMonitor.isReachable,
      "Network connectivity needed for this test.")
    
    // given
    let urlString = "https://www.random.org/strings/?num=1&len=2&digits=on&format=plain&rnd=new"//"http://www.randomnumberapi.com/test"
    let url = URL(string: urlString)!
    let promise = expectation(description: "Completion handler invoked")
    var statusCode: Int?
    var responseError: Error?

    // when
    let dataTask = sut.dataTask(with: url) { _, response, error in
      statusCode = (response as? HTTPURLResponse)?.statusCode
      responseError = error
      promise.fulfill()
    }
    dataTask.resume()
    wait(for: [promise], timeout: 5)

    // then
    XCTAssertNil(responseError)
    XCTAssertEqual(statusCode, 200)
  }

}
