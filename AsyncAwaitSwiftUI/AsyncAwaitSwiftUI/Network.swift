//
//  Network.swift
//  AsyncAwaitSwiftUI
//
//  Created by Sedhom, Mina R on 5/24/23.
//

import Foundation
// Network.swift

class Network {
    //we can call the above function in the onAppear modifier to get our data printed on the console.
    //onAppear doesn't support asynchronous code.
    
    func getRandomFoodWithCompletionHandler() {
        guard let url = URL(string: "https://random-data-api.com/api/food/random_food") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { return }
            guard let data = data else { return }
            do {
                let decodedFood = try JSONDecoder().decode(Food.self, from: data)
                print("Completion handler decodedFood", decodedFood)
            } catch {
                print("Error decoding", error)
            }
        }
        
        dataTask.resume()
    }
    
    
    func getRandomFood() async throws -> Food  {
        guard let url = URL(string: "https://random-data-api.com/api/food/random_food") else { fatalError("Missing URL") }
            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            let decodedFood = try JSONDecoder().decode(Food.self, from: data)
        print("Async decodedFood", decodedFood)
        return decodedFood
    }
}
