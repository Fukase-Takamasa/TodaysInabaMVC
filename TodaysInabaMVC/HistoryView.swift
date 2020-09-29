//
//  HistoryView.swift
//  TodaysInabaMVC
//
//  Created by 深瀬 貴将 on 2020/09/29.
//

import SwiftUI

struct HistoryView: View {
    
    @State var inputText: String = ""
    @State var displayText: String = ""
    
    var body: some View {
        VStack {
            Text("Hello, \(displayText)")
            TextField("Your name", text: $inputText, onCommit: {
                UserDefaults.standard.set(inputText, forKey: "name")
                displayText = inputText
                inputText = ""
            })
            .padding()
        }
        .onAppear(perform: {
            displayText = "Inaba"
            guard let userDefaultsText = UserDefaults.standard.value(forKey: "name") as? String else {return}
            displayText = userDefaultsText
        })
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
