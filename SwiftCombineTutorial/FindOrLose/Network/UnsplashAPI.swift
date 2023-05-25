/// Copyright (c) 2020 Razeware LLC
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

import Foundation
import Combine

enum UnsplashAPI {
  static let accessToken = "5v_46fadstDuxBubjekDJQGKJiZ-YTOZKnY7o9I_bjs"

  //static func randomImage(completion: @escaping (RandomImageResponse?) -> Void) {
  static func randomImage() -> AnyPublisher<RandomImageResponse, GameError> { // it returns a publisher, with an output type of RandomImageResponse and a failure type of GameError.
//AnyPublisher is a system type that you can use to wrap “any” publisher, which keeps you from needing to update method signatures if you use operators, or if you want to hide implementation details from callers.


    let url = URL(string: "https://api.unsplash.com/photos/random/?client_id=\(accessToken)")!

    let config = URLSessionConfiguration.default
    config.requestCachePolicy = .reloadIgnoringLocalCacheData
    config.urlCache = nil
    let session = URLSession(configuration: config)

    var urlRequest = URLRequest(url: url)
    urlRequest.addValue("Accept-Version", forHTTPHeaderField: "v1")

//    session.dataTask(with: urlRequest) { data, response, error in
//      guard
//        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//        let data = data, error == nil,
//        let decodedResponse = try? JSONDecoder().decode(RandomImageResponse.self, from: data)
//        else {
//          completion(nil)
//          return
//      }
//
//      completion(decodedResponse)
//    }.resume()
    
    //Combine version
    
    // 1
    return session.dataTaskPublisher(for: urlRequest)
      // 2
      .tryMap { response in
        guard
          // 3
          let httpURLResponse = response.response as? HTTPURLResponse,
          httpURLResponse.statusCode == 200
          else {
            // 4
            throw GameError.statusCode
        }
        // 5
        return response.data
      }
      // 6
      .decode(type: RandomImageResponse.self, decoder: JSONDecoder())
      // 7
      .mapError { GameError.map($0) }
      // 8
      .eraseToAnyPublisher()
  }
}
