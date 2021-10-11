//
//  CustomSegmentView.swift
//  SwiftUIIListExampleApp
//
//  Created by Akash on 11/10/21.
//

import Foundation
import SwiftUI

struct CustomSegmentedPickerView: View {
    
    enum EnumSegmentType: Int {
        case discover = 0, search, jobs
        
        var title:String {
            switch self {
            case .discover:
                return "Tab 1"
            case .search:
                return "tab 2"
            case .jobs:
                return "Tab 3"
            }
        }
    }
    
    var buttonTitlesArray: [EnumSegmentType] = [EnumSegmentType]()
    @State private var selectedIndexColor = Color.white
    var tabHeight: CGFloat = 50
    
    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {
            configureCustomButtonSegment(buttonTitlesArray: buttonTitlesArray, frames: Array<CGRect>(repeating: .zero, count: buttonTitlesArray.count), tabHeight: tabHeight)
                .padding(.all, 5)
                .animation(.default, value: 1).background(selectedIndexColor)
        }).cornerRadius(tabHeight/2).padding(.leading, 20).padding(.trailing, 20)
    }
}

struct configureCustomButtonSegment: View {
    
    var buttonTitlesArray: [CustomSegmentedPickerView.EnumSegmentType] = [CustomSegmentedPickerView.EnumSegmentType]()
    @State private var selectedIndex = 0
    @State var frames: [CGRect] = Array<CGRect>(repeating: .zero, count: 2)
    @State private var selectedIndexColor = Color.white
    @State private var selectedTextIndexColor = Color.white
    @State private var selectedIndexBackgroundColor = Color.blue
    var tabHeight: CGFloat = 50
    @State private var toggle = true
    
    var body: some View {
        ZStack{
            HStack(spacing: 0) {
                ForEach(self.buttonTitlesArray.indices, id: \.self) { index in
                    switch self.buttonTitlesArray[index] {
                    case .jobs,.discover:
                        Button(action: {
                            self.selectedIndex = index
                        }) {
                            Text(self.buttonTitlesArray[index].title).foregroundColor(self.selectedIndex   == index ? Color.white : Color.blue)
                        }
                        .foregroundColor(selectedIndexBackgroundColor).padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 10)).background(
                            GeometryReader { geo in
                                Color.clear.onAppear { self.setFrame(index: index, frame: geo.frame(in: .global)) }
                            }
                        )
                    case .search:
                        Button(action: { self.selectedIndex = index }) {
                            Image("searchAtLandingPage").colorMultiply(self.selectedIndex   == index ? Color.white : Color.blue).frame(width: 15, height: 15, alignment: .center)
                            Text(self.buttonTitlesArray[index].title).foregroundColor(self.selectedIndex   == index ? Color.white : Color.blue)
                        }
                        .foregroundColor(selectedIndexBackgroundColor).padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 10))
                        .background(
                            GeometryReader { geo in
                                Color.clear.onAppear { self.setFrame(index: index, frame: geo.frame(in: .global)) }
                            }
                        )
                    }
                }
            }
        }.background(
            Capsule().fill(
                selectedIndexBackgroundColor)
                .frame(width: self.frames[self.selectedIndex].width,
                       height: self.frames[self.selectedIndex].height, alignment: .topLeading)
                .offset(x: self.frames[self.selectedIndex].minX - self.frames[0].minX)
            , alignment: .leading
        )
    }
    
    func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame
    }
}

struct CustomSegmentedPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSegmentedPickerView()
    }
}
