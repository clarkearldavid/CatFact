//
//  ContentView.swift
//  CatFact
//
//  Created by Clark David on 12/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CatViewModel()
    let targetHeight: CGFloat = 200
    
    var body: some View {
        VStack {
            
            Text("Random Cat Facts")
                .font(.largeTitle)
            
            if viewModel.showLoading {
                VStack(spacing: 20) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(height: 200)
                        .cornerRadius(10)
                        .redacted(reason: .placeholder)
                    
                    Text("Fetching a cat fact...")
                        .redacted(reason: .placeholder)
                        .frame(height: 20)
                }
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(Color.red)
            } else {
                Button(action: {
                    viewModel.fetchCatData()
                }) {
                    VStack(spacing: 20) {
                        if let url = URL(string: viewModel.catURL.url) {
                            
                            let aspectRatio = viewModel.catURL.width > 0 && viewModel.catURL.height > 0
                                    ? viewModel.catURL.width / viewModel.catURL.height
                            : 1.0
                            
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(aspectRatio, contentMode: .fit)
                            } placeholder: {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(height: 200)
                                    .cornerRadius(10)
                                    .redacted(reason: .placeholder)
                            }
                        }
                        
                        Text(viewModel.catFact)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchCatData()
        }
    }
}

#Preview {
    ContentView()
}
