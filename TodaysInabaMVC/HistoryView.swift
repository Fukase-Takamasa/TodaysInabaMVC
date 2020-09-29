//
//  HistoryView.swift
//  TodaysInabaMVC
//
//  Created by 深瀬 貴将 on 2020/09/29.
//

import SwiftUI
import struct Kingfisher.KFImage

struct HistoryView: View {
    
    @State var imageUrlStrings: [String] = []
        
    var body: some View {
        //GeometryReaderでラップすることで画面サイズにアクセスできる
        GeometryReader { bodyView in
            ScrollView(.vertical) {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 0) {
                    ForEach(0..<self.imageUrlStrings.count, id: \.self) { index in
                        KFImage(URL(string: self.imageUrlStrings[index]))
                            .resizable()
                            .scaledToFit()
                            //Itemの縦横をそれぞれ画面横幅の半分にしてる
                            .frame(width: bodyView.size.width / 2, height: bodyView.size.width / 2)
                    }
                }
            }
            .onAppear {
                guard let urlArr = UserDefaults.standard.value(forKey: "imageUrlStrings") as? [String] else {return}
                self.imageUrlStrings = urlArr
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
