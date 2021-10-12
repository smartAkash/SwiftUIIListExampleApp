//
//  CustomSegmentView.swift
//  SwiftUIIListExampleApp
//
//  Created by Akash on 11/10/21.
//

import Foundation
import SwiftUI

struct CustomSegmentedPickerView: View {
    
    enum EnumSegmentType{
        case simple(title:String)  , simpleWithLeftSideIcon(title:String, icon:String? = nil), simpleWithRightSideIcon(title:String, icon:String? = nil)
    }
    
    /*
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
     }*/
    
    var buttonTitlesArray: [EnumSegmentType] = [EnumSegmentType]() // array of title pass from out side
    var tabHeight: CGFloat = 0 // segment hieght
    let buttonTapAction: (EnumSegmentType) -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {
            configureCustomButtonSegment(buttonTitlesArray: buttonTitlesArray, frames: Array<CGRect>(repeating: .zero, count: buttonTitlesArray.count), buttonTapAction: { buttonSelectedEnum in
                buttonTapAction(buttonSelectedEnum)
            }).padding(.all, 5).background(Color.white)
        }).cornerRadius(tabHeight/2).padding(.leading, 20).padding(.trailing, 20).animation(.easeInOut)
        
    }
}


// Configure Segment of Button
struct configureCustomButtonSegment: View {
    
    var buttonTitlesArray: [CustomSegmentedPickerView.EnumSegmentType] = [CustomSegmentedPickerView.EnumSegmentType]()
    @State var selectedIndex = 0
    @State var frames: [CGRect] = [CGRect]()
    @State private var selectedIndexBackgroundColor = Color.blue
    var buttonTapAction: (CustomSegmentedPickerView.EnumSegmentType) -> Void
    
    var body: some View {
        ZStack{
            HStack(spacing: 0) {
                ForEach(Array(self.buttonTitlesArray.enumerated()), id: \.offset) { offset, item in
                    let buttonIndex = offset
                    switch item {
                    case .simple(let title):
                        CustomButtonSegment(buttonIndex: buttonIndex, title: title, isSelectedButton: self.selectedIndex   == buttonIndex, buttonAction: { (selectedIndex) in
                            self.selectedIndex = selectedIndex
                            self.buttonTapAction(self.buttonTitlesArray[selectedIndex])
                        }).foregroundColor(selectedIndexBackgroundColor).padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 10)).background(
                            GeometryReader { geo in
                                Color.clear.onAppear { self.setFrame(index: buttonIndex, frame: geo.frame(in: .global)) }
                            }
                        )
                        
                    case .simpleWithRightSideIcon(let title, let icon):
                        CustomButtonSegment(buttonIndex: buttonIndex, rightIcon: true, title: title, icon: icon, isSelectedButton: self.selectedIndex   == buttonIndex, buttonAction: { (selectedIndex) in
                            self.selectedIndex = selectedIndex
                            self.buttonTapAction(self.buttonTitlesArray[selectedIndex])
                        }).foregroundColor(selectedIndexBackgroundColor).padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 10)).background(
                            GeometryReader { geo in
                                Color.clear.onAppear { self.setFrame(index: buttonIndex, frame: geo.frame(in: .global)) }
                            }
                        )
                        
                    case .simpleWithLeftSideIcon(let title, let icon):
                        CustomButtonSegment(buttonIndex: buttonIndex, leftIcon: true, title: title, icon: icon, isSelectedButton: self.selectedIndex   == buttonIndex, buttonAction: { (selectedIndex) in
                            self.selectedIndex = selectedIndex
                            self.buttonTapAction(self.buttonTitlesArray[selectedIndex])
                        }).foregroundColor(selectedIndexBackgroundColor).padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 10)).background(
                            GeometryReader { geo in
                                Color.clear.onAppear { self.setFrame(index: buttonIndex, frame: geo.frame(in: .global)) }
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
    
    private func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame
    }
}

// Configure Button
struct CustomButtonSegment: View {
    
    var buttonIndex = 0
    var leftIcon:Bool?
    var rightIcon:Bool?
    var title = ""
    var icon:String?
    var isSelectedButton:Bool = false
    var buttonAction: (Int) -> Void
    private let iconSize:CGFloat = 15
    
    var body : some View {
        Button(action: {
            self.buttonAction(buttonIndex)
        }){
            if leftIcon == nil && rightIcon == nil {
                Text(title).foregroundColor(isSelectedButton ? Color.white : Color.blue)
            }else if leftIcon != nil, let iconName = icon{
                Image(iconName).resizable().colorMultiply(isSelectedButton ? Color.white : Color.blue).frame(width: iconSize, height: iconSize, alignment: .center)
                Text(title).foregroundColor(isSelectedButton ? Color.white : Color.blue)
            }else if rightIcon != nil, let iconName = icon{
                Text(title).foregroundColor(isSelectedButton ? Color.white : Color.blue)
                Image(iconName).resizable().colorMultiply(isSelectedButton ? Color.white : Color.blue).frame(width: iconSize, height: iconSize, alignment: .center)
            }else{
                Text(title).foregroundColor(isSelectedButton ? Color.white : Color.blue)
            }
        }
    }
}

struct CustomSegmentedPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.yellow
            CustomSegmentedPickerView(buttonTitlesArray: [.simple(title: "Jobs"), .simpleWithLeftSideIcon(title: "Search", icon: "searchAtLandingPage"), .simpleWithRightSideIcon(title: "Connect",icon: "umbagog")],tabHeight: 50, buttonTapAction: { enumSegmentType in
                debugPrint(enumSegmentType)
            })
        }
    }
}
