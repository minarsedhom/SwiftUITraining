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

//This declares the SUT, which is BullsEyeGame, creates it in setUpWithError() and releases it in tearDownWithError().
final class BullsEyeFakeTests: XCTestCase {

  var sut: BullsEyeGame!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = BullsEyeGame()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  //1- You set up the fake data and response and create the fake session object. Finally, inject the fake session into the app as a property of sut.
  //2- You still have to write this as an asynchronous test because the stub is pretending to be an asynchronous method. Check whether calling startNewRound(completion:) parses the fake data by comparing targetValue with the stubbed fake number.

  //this test used a stub to provide input from a fake object
  func testStartNewRoundUsesRandomValueFromApiRequest() {
    // given
    // 1
    let stubbedData = "[1]".data(using: .utf8)
    let urlString =
      "http://www.randomnumberapi.com/api/v1.0/random?min=0&max=100&count=1" //useless in here
    let url = URL(string: urlString)!
    let stubbedResponse = HTTPURLResponse(
      url: url,
      statusCode: 200,
      httpVersion: nil,
      headerFields: nil)
    let urlSessionStub = URLSessionStub(
      data: stubbedData,
      response: stubbedResponse,
      error: nil)
    sut.urlSession = urlSessionStub
    let promise = expectation(description: "Value Received")

    // when
    sut.startNewRound {
      // then
      // 2
      XCTAssertEqual(self.sut.targetValue, 1)
      promise.fulfill()
    }
    wait(for: [promise], timeout: 5)
  }
  
}

//Notes:
//The BullsEye project contains the supporting file URLSessionStub.swift. This defines a simple protocol, named URLSessionProtocol, with a method to create a data task with a URL. It also defines URLSessionStub, which conforms to this protocol. Its initializer lets you define the data, response and error the data task should return.

