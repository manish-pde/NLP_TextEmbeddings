//
//  ContentView.swift
//  NLP_TextEmbeddings
//
//  Created by Manish on 23/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewmodel = ContentViewModel()
    
    @State private var disInput1 = ""
    @State private var disInput2 = ""
    @State private var disInput3 = ""
    
    @State private var relatedInput = ""
    
    var body: some View {
        VStack {
            List {
                DisclosureGroup("Distance") {
                    VStack(alignment: .leading) {
                        Text("Result:")
                        Text(viewmodel.distanceResult)
                    }
                    
                    VStack {
                        TextField("Input 1", text: $disInput1)
                        TextField("Input 2", text: $disInput2)
                        TextField("Input 3", text: $disInput3)
                    }
                    
                    Button("Evaluate") {
                        viewmodel.checkDistance(
                            for: disInput1.lowercased().trimmingCharacters(in: .whitespacesAndNewlines),
                            txt2: disInput2.lowercased().trimmingCharacters(in: .whitespacesAndNewlines),
                            txt3: disInput3.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                        )
                    }
                }
                
                DisclosureGroup("Related Words") {
                    VStack(alignment: .leading) {
                        Text("Result:")
                        Text(viewmodel.relatedResult)
                    }
                    
                    VStack {
                        TextField("Input", text: $relatedInput)
                    }
                    
                    Button("Evaluate") {
                        viewmodel.findRelatedWords(for: relatedInput.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
