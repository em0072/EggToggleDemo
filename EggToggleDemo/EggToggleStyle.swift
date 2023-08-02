//
//  EggToggleStyle.swift
//  EggToggleDemo
//
//  Created by Evgeny Mitko on 02/08/2023.
//

import SwiftUI

struct EggToggleStyle: ToggleStyle {
        
    @State private var rotationDegree: CGFloat = 0
    @State private var yRotationDirection: CGFloat = 1
    
    func makeBody(configuration: Configuration) -> some View {
        
        HStack(spacing: 0) {
            handleView
                .zIndex(1)
            handleExtensionView(isOn: configuration.isOn)
            panView(isOn: configuration.isOn)
        }
        .rotation3DEffect(.degrees(rotationDegree),
                          axis: (x: 0, y: 1, z: 0),
                          anchor: .center,
                          anchorZ: 0,
                          perspective: 0.7
        )
        .onTapGesture {
            rotationDegree = configuration.isOn ? -30 : 30
            configuration.isOn.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                rotationDegree = 0
            }
        }
        .animation(.easeIn, value: configuration.isOn)
        .animation(.easeInOut, value: rotationDegree)

    }
    
    private var handleView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 45, height: 15)
                .foregroundStyle(.handle
                    .shadow(.inner(color: .black.opacity(0.4), radius: 8, x: 0, y: 0))
                )
                .clipShape(
                    .rect(topLeadingRadius: 25,
                          bottomLeadingRadius: 25,
                          bottomTrailingRadius: 5,
                          topTrailingRadius: 5,
                          style: .continuous)
                )
                .overlay {
                    // Hole in the handle
                    HStack {
                        ZStack {
                            Circle()
                                .frame(width: 8, height: 8)
                                .blendMode(.destinationOut)
                            
                            Circle()
                                .stroke(.handleHole, lineWidth: 1)
                                .frame(width: 8, height: 8)
                        }
                        .padding(.leading, 7)
                        Spacer()
                    }
                }

        }
        .compositingGroup()
        .shadow(color: .black.opacity(0.8), radius: 1, x: 0, y: 0)
    }
    
    private func handleExtensionView(isOn: Bool) ->  some View {
        Rectangle()
            .frame(width: 15, height: 7)
            .foregroundStyle((isOn ? Color.handleExtensionGreen : .handleExtension)
                .shadow(.inner(color: .black.opacity(0.4), radius: 1, x: 1, y: 0))
            )
    }
    
    private func panView(isOn: Bool) -> some View {
        ZStack {
            Capsule()
                .foregroundStyle((isOn ? Color.panOutGreen : .panOut)
                    .shadow(.drop(color: .black, radius: 1, x: 0, y: 0))
                )
            
            Capsule()
                .foregroundStyle((isOn ? Color.panMiddleGreen : .panMiddle)
                    .shadow(.inner(color: .black.opacity(0.5), radius: 3, x: 0, y: 0))
                )
                .padding(3)

            Capsule()
                .foregroundStyle((isOn ? Color.panInGreen : .panIn)
                    .shadow(.inner(color: .black.opacity(0.5), radius: 1, x: 0, y: 0))
                    .shadow(.drop(color: .white.opacity(0.5), radius: 3, x: 0, y: 0))
                )
                .padding(9)
                .overlay {
                    eggView(isOn: isOn)
                        .offset(x: isOn ? 30 : -30)
                }
        }
        .frame(width: 120, height: 60)
    }
    
    private func eggView(isOn: Bool) -> some View {
            eggWhiteShape
                .foregroundStyle(eggWhiteBorderColor(isOn: isOn))
                .overlay {
                    eggWhiteShape
                        .foregroundStyle(eggWhiteColor(isOn: isOn))
                        .offset(x: (isOn ? 1 : -1) * 1,
                                y: (isOn ? 1 : -1) * 1.5)
                }
                .clipShape(eggWhiteClipStyle)
                .rotationEffect(.degrees(isOn ? 0 : -180))
                .overlay {
                    eggYokeView
                        .padding(6)
                }
    }
    
    private var eggYokeView: some View {
        ZStack {
            Circle()
                .foregroundStyle(.eggWhiteOn)
                .offset(x: -1, y: -1)
            
            Circle()
                .foregroundStyle(.eggYoke
                    .shadow(.inner(color: .black.opacity(0.2), radius: 0, x: -2, y: -2))
                )
                .overlay {
                    VStack {
                        HStack(spacing: 1.5) {
                            Ellipse()
                                .fill(.white)
                                .frame(width: 3, height: 6)
                                .rotationEffect(.degrees(40))
                                .offset(y: 3)
                            
                            Circle()
                                .fill(.white)
                                .frame(width: 2.7)
                            Spacer()
                        }
                        .padding(.leading, 4)
                        Spacer()
                    }
                }
        }
    }
    
    private var eggWhiteShape: some View {
        Rectangle()
            .frame(width: 38, height: 33)
            .clipShape(eggWhiteClipStyle)
    }
    
    private var eggWhiteClipStyle: UnevenRoundedRectangle {
        .rect(topLeadingRadius: 19,
              bottomLeadingRadius: 14,
              bottomTrailingRadius: 17,
              topTrailingRadius: 15,
              style: .circular)
    }
    
    private func eggWhiteColor(isOn: Bool) -> Color {
        isOn ? Color.eggWhiteOn : Color.eggWhiteOff
    }
    
    private func eggWhiteBorderColor(isOn: Bool) -> Color {
        isOn ? Color.eggWhiteBorderOn : Color.eggWhiteBorderOff
    }

}

#Preview {
    ContentView()
}
