//
//  CustomSegmentView.swift
//  SwiftUIIListExampleApp
//
//  Created by Akash on 11/10/21.
//

import Foundation
import SwiftUI
import MapKit

struct CommonDataModel{
    enum EnumIconPosition:Int {
        case left, right, none
    }
    var title:String
    var icon:String? = nil
    var iconPosition: EnumIconPosition = .none
}

struct CustomSegmentedPickerView: View {
    
    var buttonTitlesArray: [CommonDataModel] = [CommonDataModel]() // array of title pass from out side
    var tabHeight: CGFloat = 0 // segment hieght
    let buttonTapAction: (CommonDataModel) -> Void
    
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
    
    var buttonTitlesArray: [CommonDataModel] = [CommonDataModel]()
    @State var selectedIndex = 0
    @State var frames: [CGRect] = [CGRect]()
    @State private var selectedIndexBackgroundColor = Color.blue
    var buttonTapAction: (CommonDataModel) -> Void
    
    var body: some View {
        ZStack{
            HStack(spacing: 0) {
                ForEach(Array(self.buttonTitlesArray.enumerated()), id: \.offset) { offset, item in
                    let buttonIndex = offset
                    CustomButtonSegment1(buttonIndex: buttonIndex, selectedDataModel: item, isSelectedButton: self.selectedIndex   == buttonIndex) { (selectedIndex) in
                        self.selectedIndex = selectedIndex
                        self.buttonTapAction(self.buttonTitlesArray[selectedIndex])
                    }.foregroundColor(selectedIndexBackgroundColor).padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 10)).background(
                        GeometryReader { geo in
                            Color.clear.onAppear { self.setFrame(index: buttonIndex, frame: geo.frame(in: .global)) }
                        }
                    )
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

struct CustomButtonSegment1: View {
    
    var buttonIndex = 0
    var selectedDataModel: CommonDataModel
    var isSelectedButton:Bool = false
    var buttonAction: (Int) -> Void
    private let iconSize:CGFloat = 15
    
    var body : some View {
        Button(action: {
            self.buttonAction(buttonIndex)
        }){
            switch selectedDataModel.iconPosition {
            case .none:
                Text(selectedDataModel.title).foregroundColor(isSelectedButton ? Color.white : Color.blue)
            case .left:
                if let iconName = selectedDataModel.icon, !iconName.isEmpty{
                    Image(iconName).resizable().colorMultiply(isSelectedButton ? Color.white : Color.blue).frame(width: iconSize, height: iconSize, alignment: .center)
                }
                Text(selectedDataModel.title).foregroundColor(isSelectedButton ? Color.white : Color.blue)
            case .right:
                Text(selectedDataModel.title).foregroundColor(isSelectedButton ? Color.white : Color.blue)
                if let iconName = selectedDataModel.icon, !iconName.isEmpty{
                    Image(iconName).resizable().colorMultiply(isSelectedButton ? Color.white : Color.blue).frame(width: iconSize, height: iconSize, alignment: .center)
                }
            }
        }
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
            let arrayOfSegment = [CommonDataModel.init(title: "Jobs"),
                                  CommonDataModel.init(title: "Search", icon: "searchAtLandingPage", iconPosition: .left),
                                  CommonDataModel.init(title: "Connect", icon: "umbagog", iconPosition: .right)
            ]
            CustomSegmentedPickerView(buttonTitlesArray: arrayOfSegment,tabHeight: 50, buttonTapAction: { dataModel in
                debugPrint(dataModel.title)
            })
        }
    }
}
