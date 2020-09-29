//
//  HistoryView.swift
//  TodaysInabaMVC
//
//  Created by 深瀬 貴将 on 2020/09/29.
//

import SwiftUI

struct HistoryView: View {
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 0) {
            ForEach(0..<12, id: \.self) { index in
                Text("\(index)")
                    .frame(width: 100, height: 100, alignment: .center)
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
