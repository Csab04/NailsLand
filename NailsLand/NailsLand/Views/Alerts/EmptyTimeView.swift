//
//  EmptyTimeView.swift
//  NailsLand
//
//  Created by Csaba Otvos on 27.03.2023.
//

import SwiftUI

struct EmptyTimeView: View {
    var body: some View {
        VStack{
            Text("Sorry!")
                .font(.title.bold())
            Text("I have no more free places this day")
                .font(.title2)
            Text("Please try another day!")
                .font(.title2)
        }
    }
}

struct EmptyTimeView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyTimeView()
    }
}
