//
//  HistoryView.swift
//  TodaysInabaMVC
//
//  Created by 深瀬 貴将 on 2020/09/29.
//

import SwiftUI
import struct Kingfisher.KFImage

struct HistoryView: View {
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 0) {
                ForEach(0..<100, id: \.self) { index in
                    KFImage(URL(string: "https://1.bp.blogspot.com/-_CVATibRMZQ/XQjt4fzUmjI/AAAAAAABTNY/nprVPKTfsHcihF4py1KrLfIqioNc_c41gCLcBGAs/s400/animal_chara_smartphone_penguin.png")!)
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                }
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
