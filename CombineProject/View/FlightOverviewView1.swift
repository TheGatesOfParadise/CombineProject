//
//  ContentView.swift
//  Whoosh
//
//  Created by Pallav Trivedi on 29/06/21.
//

import SwiftUI

struct FlightOverviewView1: View {
    
    @ObservedObject var viewModel = SignUpViewModel()
    //private let viewModel: SignUpViewModel = SignUpViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hexStringToUIColor(hex: "#29272E"))
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVStack {
                        //viewModle's userProfile can't be nil, it has to be empty at first
                        //since it's a @published property,  the view will display contents
                        //after the data is retrieved
                        ForEach(viewModel.userProfile.flights, id: \.self) { value in
                            NavigationLink(destination: FlightDetailView(id: value.id)) {
                                FlightCardView(flight: value)
                            }
                            .foregroundColor(.black)
                        }
                    }
                }
                .navigationTitle("BOM - LHR")
            }
            
        }
        .onAppear {
            UITableView.appearance().separatorStyle = .none
            UITableView.appearance().showsVerticalScrollIndicator = false
            //viewModel.getHomeData()  --- this uses HomeViewModel get a list of flights from one json file
            viewModel.getOnBoardingData()  //-- this uses ZipOperator's SignUpViewModel to read 2 json files then zip them together
        }
    }
}



struct FlightOverviewViewView1_Previews: PreviewProvider {
    static var previews: some View {
        FlightOverviewView1()
    }
}

