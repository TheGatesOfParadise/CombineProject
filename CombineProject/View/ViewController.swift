import UIKit
import SwiftUI
import Combine


class SignUpButton: UIButton {
    
}

class ViewController: UIViewController {
    
    @IBOutlet private var userNameTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var tncSwitch: UISwitch!
    @IBOutlet private var signupButton1: UIButton!
    @IBOutlet private var signupButton2: UIButton!
    
    @Published private var isTnCAccepted: Bool = false
    @Published private var username: String = ""
    @Published private var password: String = ""
    
    private let viewModel: SignUpViewModel = SignUpViewModel()
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    
    private var signupValidationPublisher: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest3($isTnCAccepted, $username, $password)
            .map { isTnCAccepted, username, password in
                isTnCAccepted && !username.isEmpty && !password.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tncSwitch.setOn(isTnCAccepted, animated: true)
        signupValidationPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: signupButton1)
            .store(in: &subscriptions)
    }
    
    @IBAction private func didToggleTnCSwitch(_ sender: UISwitch) {
        isTnCAccepted = sender.isOn
    }
    
    @IBAction private func didChangeUsername(_ sender: UITextField) {
        username = sender.text ?? ""
    }
    
    @IBAction private func didChangePassword(_ sender: UITextField) {
        password = sender.text ?? ""
    }
    
    @IBAction private func didClickOnSubmitButton1(_ sender: SignUpButton) {
        //To be implemented in Zip Operator video
        print(username)
       
        //go to swiftui FlightOverviewView using Zip operator
        let vc = UIHostingController(rootView: FlightOverviewView1())
        present(vc, animated: true)
 
        /*
         this causes error because by now players are flights are not retrieved back yet
        for player in viewModel.userProfile!.players {
            print(player.image)
        }
        
        for flight in viewModel.userProfile!.flights {
            print(flight.flightNumber!)
        }
   */
    }
    
    @IBAction private func didClickOnSubmitButton2(_ sender: SignUpButton) {
        //To be implemented in Zip Operator video
        print(username)
       
        //go to swiftui FlightOverviewView using plain Combine
        let vc = UIHostingController(rootView: FlightOverviewView2())
        present(vc, animated: true)
    }
}
