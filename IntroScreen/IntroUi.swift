//
//  IntroUi.swift
//  IntroScreen
//
//  Created by Auto on 9/4/23.
//

import SwiftUI

struct IntroUi: View {
    
    let pages: [OnboardingPage]
    
    @State private var currentPageIndex = 0
    
    init() {
        let introDescription = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nisi nulla purus neque quisque dictum dui. Accumsan fames adipiscing."
        
        self.pages = [
            OnboardingPage(imageName: "cuate", introduction: "Introduction 1", description: introDescription, imageSize: CGSize(width: 300, height: 200)),
            OnboardingPage(imageName: "rafiki1", introduction: "Introduction 2", description: introDescription, imageSize: CGSize(width: 300, height: 200)),
            OnboardingPage(imageName: "bro", introduction: "Introduction 3", description: introDescription, imageSize: CGSize(width: 300, height: 200)),
            OnboardingPage(imageName: "rafiki", introduction: "Explore the app", description: introDescription, imageSize: CGSize(width: 400, height: 300)),
        ]
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(pages[currentPageIndex].imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: pages[currentPageIndex].imageSize.width, height: pages[currentPageIndex].imageSize.height)
                .padding()
            
            Text(pages[currentPageIndex].introduction)
                .font(Font.custom("Outfit", size: 24).weight(.semibold))
                .foregroundColor(.black)
                
            
            Text(pages[currentPageIndex].description)
                .font(Font.custom("Outfit", size: 15))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.34, green: 0.33, blue: 0.33))
                .frame(width: 349, height: 74, alignment: .top)
                
            
            Spacer()
            DotIndicator(currentPageIndex: $currentPageIndex, pageCount: pages.count)
            Spacer()
            
            if currentPageIndex == pages.count - 1 {
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.blue)
                            .frame(width: 160, height: 51)
                            .cornerRadius(17)
                        Text("Get Started")
                            .font(
                                Font.custom("Outfit", size: 20)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.white)
                    }
                })
            } else {
                HStack {
                    Button(action: {
                        currentPageIndex = pages.count - 1
                    }, label: {
                        Text("Skip")
                            .font(
                                Font.custom("Outfit", size: 24)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.black)
                    })
                    .padding()
                    Spacer()
                    
                    Button(action: {
                        currentPageIndex += 1
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
        }
        .padding()
    }
}

struct OnboardingPage {
    let imageName: String
    let introduction: String
    let description: String
    let imageSize: CGSize
}

struct DotIndicator: View {
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

