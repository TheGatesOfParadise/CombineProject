//
//  FlightDetailView.swift
//  CombineProject
//
//  Created by Mom macbook air on 3/10/23.
//

import SwiftUI

struct FlightDetailView: View {
    var flightId: Int
    init(id: Int) {
      flightId = id
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct FlightDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FlightDetailView(id: 0)
    }
}
