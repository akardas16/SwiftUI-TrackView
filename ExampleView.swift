//
//  ExampleView.swift
//  PopupView-Example
//
//  Created by Abdullah Kardaş on 26.06.2023.
//

import SwiftUI

struct ExampleView: View {
    var orderStatus = ["Preparing","Packaging","On the way","Arrived"]
    @State var currentIndex = 2
    var body: some View {
        VStack {
            
            //Style 1
            Section {
                TrackView(currentIndex: $currentIndex, list: orderStatus, style: .reloading, showLabels: true,selectedColor: .green)
                
            } header: {
                Text("Style 1")
            }.padding(.vertical)

            //Style 2
            Section {
                TrackView(currentIndex: $currentIndex, list: Array(repeating: "", count: 5), style: .moving, showLabels: true,selectedColor: .blue)
                   
            } header: {
                Text("Style 2")
            }.padding(.vertical)
           
           
            Spacer()
        }
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
