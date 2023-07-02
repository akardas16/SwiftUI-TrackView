//
//  TrackView.swift
//  PopupView-Example
//
//  Created by Abdullah Kardaş on 25.06.2023.
//

import SwiftUI

struct TrackView: View {
    
   
    @State private var progress:Double = 0.0
    @Binding var currentIndex:Int
    var list = ["Preparing","Packaging","On the way","Arrived"] //Example list
    var style = AnimationStyle.reloading
    @State private var isVisible = true
    var showLabels = true
    var selectedColor = Color.purple
    
    
    var body: some View {
        VStack {
     
            
            HStack {
                ForEach(list.indices,id: \.self) { index in
                    if index < currentIndex {
                        VStack {
                            if showLabels {
                                Text(list[index]).font(.caption.bold())
                            }
                            Rectangle().fill(selectedColor).frame(height: 4)
                        }
                    }else if index > currentIndex {
                        
                        VStack {
                            if showLabels {
                                Text(list[index]).font(.caption.bold())
                            }
                            Rectangle().fill(.gray.opacity(0.5)).frame(height: 4)
                        }
                    }else {
                        VStack {
                            if showLabels {
                                Text(list[index]).font(.caption.bold())
                            }
                            if style == .moving {
                                ProgressView(value: 0.4)
                                    .progressViewStyle(MovingStyle(selectedColor:selectedColor))
                            }else {
                                ProgressView(value: progress)
                                    .progressViewStyle(ReloadingStyle(selectedColor:selectedColor, isVisible: $isVisible)).onAppear {
                                       
                                        animate()
                                       
                                }
                            }
                           
                        }
                    }
                    
                }
            }.padding(.horizontal,16)
          
        }
    }
    
    func animate(){
        isVisible = true
        withAnimation(.easeIn(duration: 1.5)) {
            
            progress = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8){
                withAnimation(.easeInOut(duration: 0.8)) {
                    isVisible = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                        progress = 0
                        animate()
                       
                    }
                }
            }
        }
    }
}

struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        TrackView(currentIndex: .constant(2))
    }
}

enum AnimationStyle {
case moving,reloading
}
struct MovingStyle: ProgressViewStyle {
    
    @State var isLoading = false
    var height: CGFloat = 4
    var selectedColor = Color.green
    
    
    func makeBody(configuration: Configuration) -> some View {
        
        return VStack {
            ZStack(alignment: .topLeading) {
                GeometryReader { geo in
                    Rectangle().fill(.gray.opacity(0.5))
                        .overlay(
                            Capsule().fill(selectedColor).frame(maxWidth: geo.size.width * 0.4).frame(height: height)
                               
                            ,alignment: isLoading ? .trailing:.leading) .frame(height: height)
                        .animation(.easeInOut(duration: 0.75).repeatForever(), value: isLoading)
                   
                }
            }
            .frame(height: height)
            .onAppear {
                isLoading.toggle()
            }
        }
    }
}
struct ReloadingStyle: ProgressViewStyle {
    
    var cornerRadius: CGFloat = 0
    var height: CGFloat = 4
    var selectedColor = Color.green
    @Binding var isVisible:Bool
    var animation: Animation = .easeIn(duration: 1.6).repeatForever(autoreverses: false)
  
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        
        return VStack {
            ZStack(alignment: .topLeading) {
                GeometryReader { geo in
                    Rectangle().fill(.gray.opacity(0.5))
                        .overlay(
                            Rectangle().fill(selectedColor).frame(maxWidth: geo.size.width * CGFloat(fractionCompleted))
                            
                                .opacity(isVisible ? 1:0)
                                //.animation(.default, value: isVisible)
                               
                               // .animation(animation, value: fractionCompleted)
                                
                                
                               
                                
                            ,alignment: .leading)
                   
                }
            }
            .frame(height: height)
            .cornerRadius(cornerRadius)
     
           
            
          
        }
    }
}
