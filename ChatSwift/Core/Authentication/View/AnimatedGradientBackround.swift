//
//  AnimatedGradientBackround.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 18/01/2024.
//

import SwiftUI

struct AnimatedGradientBackround: View {
    
    let colors : [Color] = [.red, .blue, .green, .yellow]
    @State var animatedGradient: Bool = false
    
    var body: some View {
        ZStack{
            LinearGradient(
                colors: colors,
                startPoint: .topLeading,
                endPoint: .bottom
            )
            .hueRotation(.degrees(animatedGradient ? 100 : 0))
            .onAppear{
                withAnimation (
                    .easeInOut(duration: 3)
                    .repeatForever(autoreverses: true)){
                        animatedGradient.toggle()
                    }
            }
            
            Color
                .clear
                .background(.thinMaterial)
            
        
        }
    }
}

#Preview {
    AnimatedGradientBackround()
}
