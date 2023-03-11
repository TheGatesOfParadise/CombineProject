import Foundation
import Combine

struct UserProfileModel {
    var flights: [Flight]
    var players: [Player]
}

class SignUpViewModel: ObservableObject {
    
    @Published var userProfile = UserProfileModel(flights: [Flight](), players: [Player]())
    private var cancellables = Set<AnyCancellable>()
    
    func getOnBoardingData() {
        let publishers = Publishers.Zip(
            FileManager.shared.getData(fileName: "flight.json", type: Flight.self),
            FileManager.shared.getData(fileName: "Player.json", type: Player.self)
        )
        
        publishers.map{ (flights ,players ) in
            UserProfileModel(flights: flights, players: players)
        }
        .sink { (completion) in
            if case let .failure(error) = completion {
                print("Error -> \(error.localizedDescription)")
            }
        } receiveValue: { [weak self] profileModel in
            self?.userProfile = profileModel
        }
        .store(in: &cancellables)
    }

}
