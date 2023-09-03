//
//  IntroUi.swift
//  IntroScreen
//
//  Created by Auto on 9/4/23.
//

import SwiftUI

struct IntroUi: View {
    let pages: [OnboardingPage] = [
        OnboardingPage(imageName: "cuate", introduction: "Introduction 1", description: "This is the introduction 1."),
        OnboardingPage(imageName: "rafiki1", introduction: "Introduction 2", description: "This is the introduction 2."),
        OnboardingPage(imageName: "bro", introduction: "Introduction 3", description: "This is the introduction 3.")
    ]
    
    @State private var currentPageIndex = 0
    
    var body: some View {
        VStack {
            Image(pages[currentPageIndex].imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
            
            Text(pages[currentPageIndex].introduction)
                .font(.title)
            
            Text(pages[currentPageIndex].description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            HStack {
                ForEach(0..<pages.count, id: \.self) { index in
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(index == currentPageIndex ? .blue : .gray)
                        .onTapGesture {
                            currentPageIndex = index
                        }
                }
            }
            .padding(.vertical, 20)
            
            HStack {
                Button("Skip") {
                    
                }
                .padding()
                
                Spacer()
                
//                Button("Back") {
//                    if currentPageIndex > 0 {
//                        currentPageIndex -= 1
//                    }
//                }
                .padding()
                
                Button("Next") {
                    if currentPageIndex < pages.count - 1 {
                        currentPageIndex += 1
                    } else {
                        // Handle completion action
                    }
                }
                .padding()
            }
        }
        .padding()
    }
}

struct OnboardingPage {
    let imageName: String
    let introduction: String
    let description: String
}


struct IntroUi_Previews: PreviewProvider {
    static var previews: some View {
        IntroUi()
    }
}
