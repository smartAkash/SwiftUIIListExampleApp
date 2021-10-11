//
//  CustomSegmentView.swift
//  SwiftUIIListExampleApp
//
//  Created by Akash on 11/10/21.
//

import Foundation
import SwiftUI

struct CustomSegmentedPickerView: View {
//    
//    enum EnumSegment {
//        case simple(String) , simpleWithLeftSideicon(String, String?), simpleWithRightSideicon(String, String?)
//    }
    
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
    
    var buttonTitlesArray: [EnumSegmentType] = [EnumSegmentType]() // array of title pass from out side
    var tabHeight: CGFloat = 0 // segment hieght
    internal var setSegmentContainerBgColor = Color.white // background color of main container
    let buttonAction: (EnumSegmentType) -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {
            configureCustomButtonSegment(buttonTitlesArray: buttonTitlesArray, frames: Array<CGRect>(repeating: .zero, count: buttonTitlesArray.count), tabHeight: tabHeight, buttonAction: { buttonSelectedEnum in
                buttonAction(buttonSelectedEnum)
            }).padding(.all, 5)
              .animation(.default, value: 20).background(setSegmentContainerBgColor)
        }).cornerRadius(tabHeight/2).padding(.leading, 20).padding(.trailing, 20)
    }
}

struct configureCustomButtonSegment: View {
    
    var buttonTitlesArray: [CustomSegmentedPickerView.EnumSegmentType] = [CustomSegmentedPickerView.EnumSegmentType]()
    @State private var selectedIndex = 0
    @State var frames: [CGRect] = [CGRect]()
    @State private var selectedIndexBackgroundColor = Color.blue
    var tabHeight: CGFloat = 0 // segment hieght
    var buttonAction: (CustomSegmentedPickerView.EnumSegmentType) -> Void

    var body: some View {
        ZStack{
            HStack(spacing: 0) {
                ForEach(self.buttonTitlesArray.indices, id: \.self) { index in
                    switch self.buttonTitlesArray[index] {
                    case .jobs,.discover:
                        Button(action: {
                            self.selectedIndex = index
                            buttonAction(self.buttonTitlesArray[index])
                        }) {
                            Text(self.buttonTitlesArray[index].title).foregroundColor(self.selectedIndex   == index ? Color.white : Color.blue)
                        }
                        .foregroundColor(selectedIndexBackgroundColor).padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 10)).background(
                            GeometryReader { geo in
                                Color.clear.onAppear { self.setFrame(index: index, frame: geo.frame(in: .global)) }
                            }
                        )
                    case .search:
                        Button(action: {
                            self.selectedIndex = index
                            buttonAction(self.buttonTitlesArray[index])
                        }) {
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

