//
//  HomeViewModel.swift
//  Whoosh
//
//  Created by Pallav Trivedi on 29/06/21.
//

import Foundation
import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    @Published var flights = [Flight]()
    
    func getHomeData() {
       //Use bundle file instead of web service
       // NetworkManager.shared.getData(endpoint: .flights, type: Flight.self)
        //Bundle.main.decodeable(fileName: "flight.json")
        FileManager.shared.getData(fileName: "flight.json", type: Flight.self)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            }
    receiveValue: { [weak self] flightsData in
        self?.flights = flightsData
    }
    .store(in: &cancellables)
        
        //read json file locally
    // Part 4
   /*
        Bundle.main.decodeable(fileName: "flight.json")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { (fact: [Flight]) in
                print(fact[0].flight)
        })
        
  */
        
    }
    
}

