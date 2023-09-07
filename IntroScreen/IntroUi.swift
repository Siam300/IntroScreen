//
//  IntroUi.swift
//  IntroScreen
//
//  Created by Auto on 9/4/23.
//

import SwiftUI

struct IntroUi: View {
    let pages: [onPage]
    @State private var currentPageIndex = 0
    @State var offset: CGSize = .zero
    
    init() {
        let introDescription = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nisi nulla purus neque quisque dictum dui. Accumsan fames adipiscing."
        self.pages = [
            onPage(imageName: "cuate", introduction: "Introduction 1", description: introDescription, imageSize: CGSize(width: 300, height: 200)),
            onPage(imageName: "rafiki1", introduction: "Introduction 2", description: introDescription, imageSize: CGSize(width: 300, height: 200)),
            onPage(imageName: "bro", introduction: "Introduction 3", description: introDescription, imageSize: CGSize(width: 300, height: 200)),
            onPage(imageName: "rafiki", introduction: "Explore the app", description: introDescription, imageSize: CGSize(width: 400, height: 300)),
        ]
    }
    
    var body: some View {
        VStack {
            Spacer()
            contentView(
                imageName: pages[currentPageIndex].imageName,
                introduction: pages[currentPageIndex].introduction,
                description: pages[currentPageIndex].description,
                imageSize: pages[currentPageIndex].imageSize,
                pageCount: pages.count,
                currentPageIndex: $currentPageIndex
            )
            Spacer()
            dotIndicator(currentPageIndex: $currentPageIndex, pageCount: pages.count)
            Spacer()
            if currentPageIndex == pages.count - 1 {
                Spacer()
                getStartedButton()
            } else {
                HStack {
                    skipButton(currentPageIndex: $currentPageIndex, pageCount: pages.count)
                    Spacer()
                    nextButton(currentPageIndex: $currentPageIndex, pageCount: pages.count)
                }
            }
        }
        .padding()
        .offset(offset)
        .scaleEffect(getScaleAmmount())
        .rotationEffect(Angle(degrees: getRotationAmmount()))
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation(.spring()) {
                        offset = value.translation
                    }
                }
                .onEnded{ value in
                    withAnimation(.spring()) {
                        offset = .zero
                        let gestureThreshold: CGFloat = 50 // Adjust this value to control the sensitivity of the swipe gesture
                        if abs(value.translation.width) > gestureThreshold {
                            if value.translation.width > 0 && currentPageIndex > 0 {
                                currentPageIndex -= 1 // Swipe right
                            } else if value.translation.width < 0 && currentPageIndex < pages.count - 1 {
                                currentPageIndex += 1 // Swipe left
                            }
                        }
                    }
                }
        )
    }
    
    func withSwipeAnimation(forward: Bool) {
            withAnimation(.spring()) {
                offset = .zero
                if forward && currentPageIndex < pages.count - 1 {
                    currentPageIndex += 1
                } else if !forward && currentPageIndex > 0 {
                    currentPageIndex -= 1
                }
            }
        }
    
    func getScaleAmmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmmount = abs(offset.width)
        let persentage = currentAmmount / max
        return 1.0 - min(persentage, 0.6) * 0.5
    }
    
    func getRotationAmmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmmount = offset.width
        let persentage = currentAmmount / max
        let persentageAsDouble = Double(persentage)
        let maxAngle: Double = 10
        return persentageAsDouble * maxAngle
    }
    
}

struct onPage {
    let imageName: String
    let introduction: String
    let description: String
    let imageSize: CGSize
}

struct dotIndicator: View {
    @Binding var currentPageIndex: Int
    let pageCount: Int
    
    var body: some View {
        HStack {
            Spacer()
            ForEach(0..<pageCount, id: \.self) { index in
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(index == currentPageIndex ? .blue : .gray)
                    .onTapGesture {
                        currentPageIndex = index
                    }
            }
            Spacer()
        }
        .padding(.vertical, 20)
    }
}

struct IntroUi_Previews: PreviewProvider {
    static var previews: some View {
        IntroUi()
    }
}

struct contentView: View {
    var imageName: String
    var introduction: String
    var description: String
    var imageSize: CGSize
    var pageCount: Int
    @Binding var currentPageIndex: Int
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: imageSize.width, height: imageSize.height)
            .padding()
        Text(introduction)
            .font(Font.custom("Outfit", size: 24).weight(.semibold))
            .foregroundColor(.black)
        
        Text(description)
            .font(Font.custom("Outfit", size: 15))
            .multilineTextAlignment(.center)
            .foregroundColor(Color(red: 0.34, green: 0.33, blue: 0.33))
            .frame(width: 349, height: 74, alignment: .top)
    }
}

struct getStartedButton: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            Text("Get Started")
                .font(
                    Font.custom("Outfit", size: 20)
                        .weight(.semibold)
                )
                .foregroundColor(.white)
        })
        .frame(width: 160, height: 51)
        .background(Color.blue)
        .cornerRadius(17)
    }
}

struct skipButton: View {
    @Binding var currentPageIndex: Int
    var pageCount: Int
    
    var body: some View {
        Button(action: {
            currentPageIndex = pageCount - 1
        }, label: {
            Text("Skip")
                .font(
                    Font.custom("Outfit", size: 24)
                        .weight(.semibold)
                )
                .foregroundColor(.black)
        })
        .padding()
    }
}

struct nextButton: View {
    @Binding var currentPageIndex: Int
    var pageCount: Int
    
    var body: some View {
        Button(action: {
            withAnimation {
                currentPageIndex += 1
            }
        }, label: {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 107, height: 51)
                    .background(Color.blue)
                    .cornerRadius(17)
                Text("Next")
                    .font(
                        Font.custom("Outfit", size: 20)
                            .weight(.semibold)
                    )
                    .foregroundColor(.white)
            }
        })
        .padding()
    }
}

