//
//  ContentView.swift
//  SwiftUIIListExampleApp
//
//  Created by Akash on 05/10/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CustomTextField(labelTitle: "First Name", placeHolderText: "Enter first name")
        CustomTextField(labelTitle: "Last name", placeHolderText: "Enter Last name",leftIcon: "chilkoottrail")
        CustomTextField(labelTitle: "Third name", placeHolderText: "Enter third name", rightIcon: "charleyrivers")
        CustomTextField(labelTitle: "Second name", placeHolderText: "Enter second name",leftIcon: "chilkoottrail", rightIcon: "charleyrivers")
    }
}

// Textfield title label
struct CustomTextFieldTitleLabel: View {
    
    // Will pass from out side
    // Left side spacing
    var leftSidePadding: CGFloat? = 10
    var labelTitle: String
    @State var titleTextColor: Color = Color.init(red: 43/255, green: 55/255, blue: 79/255).opacity(0.6)
    
    var body: some View {
        if !labelTitle.isEmpty{
            Text(labelTitle).foregroundColor(.gray).padding(.leading, leftSidePadding).foregroundColor(titleTextColor)
        }
    }
}

// TextField
struct CustomGenericTextField: View {
    
    // Will pass from out side
    var placeHolderText: String
    let action: (Bool) -> Void
    
    // internal value will be change
    @State private var content: String = ""
    @State private var textColor: Color = .white
    @State private var titleTextColor: Color = Color.init(red: 43/255, green: 55/255, blue: 79/255).opacity(0.6)
    @State private var bgColor:Color = Color.init(red: 43/255, green: 55/255, blue: 79/255).opacity(0.05)
    
    // CONSTANTS
    private let inActiveColor = Color.init(red: 43/255, green: 55/255, blue: 79/255)
    private let activeColor = Color.init(red: 0/255, green: 78/255, blue: 129/255)

    // update active and inactive based on active flag
    @State private var active: Bool = false{
        didSet{
            if active{
                textColor = activeColor
                bgColor = Color.init(red: 0/255, green: 78/255, blue: 129/255).opacity(0.1)
            }else{
                textColor = inActiveColor
                bgColor =  Color.init(red: 43/255, green: 55/255, blue: 79/255).opacity(0.05)
            }
        }
    }
    
    var body: some View {
        // Textfield configure
        TextField("", text: $content) { isFouced in
            active = isFouced
            action(active)
        } onCommit: {
            debugPrint("commit")
        }
        .placeholder(when: content.isEmpty) {
            Text(placeHolderText).foregroundColor(.gray)
        }
        .padding(.leading, 10)
        .padding(.top, 10)
        .padding(.bottom, 10)
        .padding(.trailing, 10)
//        .foregroundColor(textColor)
//        .textFieldStyle(.plain)
        .keyboardType(.default)
    }
}

// TextField Icon
struct CustomTextFieldIcon: View {
    enum EnumIconType {
        case left(String?), right(String?)
    }
    var enumIconType: EnumIconType = .left("")
    
    // Left and Right Side Padding space main container
    var leftSidePadding: CGFloat? = 5
    var rightSidePadding: CGFloat? = 5
    var iconSize: CGFloat? = 25
    
    var body: some View {
        switch enumIconType {
        case .left(let name):
            if let icon = name, !icon.isEmpty{
                Spacer().padding(0).frame(width: 5, height: 20, alignment: .leading)
                Image.init(decorative: icon).resizable().frame(width: iconSize, height: iconSize, alignment: .center)
                    .padding(.leading, leftSidePadding)
            }
        case .right(let name):
            if let icon = name, !icon.isEmpty{
                Image.init(decorative: icon).resizable().frame(width: iconSize, height: iconSize, alignment: .center)
                    .padding(.trailing, rightSidePadding)
            }
        }
    }
}

// Textfield Custom
struct CustomTextField: View {
    
    // Will pass from out side
    var labelTitle: String
    var placeHolderText: String
    var leftIcon: String?
    var rightIcon: String?
    
    // Left and Right Side Padding space main container
    var leftSidePadding: CGFloat? = 20
    var rightSidePadding: CGFloat? = 20
    var iconSize: CGFloat? = 25
    
    // internal value will be change
    @State private var content: String = ""
    @State private var textColor: Color = .white
    @State private var titleTextColor: Color = Color.init(red: 43/255, green: 55/255, blue: 79/255).opacity(0.6)
    @State private var bgColor:Color = Color.init(red: 43/255, green: 55/255, blue: 79/255).opacity(0.05)
    @State private var colorChange: Color = .white

    // CONSTANTS
    private let inActiveColor = Color.init(red: 43/255, green: 55/255, blue: 79/255)
    private let activeColor = Color.init(red: 0/255, green: 78/255, blue: 129/255)
    
    // update active and inactive based on active flag
    @State private var active: Bool = false{
        didSet{
            if active{
                textColor = activeColor
                bgColor = Color.init(red: 0/255, green: 78/255, blue: 129/255).opacity(0.1)
            }else{
                textColor = inActiveColor
                bgColor =  Color.init(red: 43/255, green: 55/255, blue: 79/255).opacity(0.05)
            }
        }
    }
    
    var body: some View {
        // VStack containing title label and (textfield, Left-Icon, Right-Icon)
        VStack(alignment: .leading, spacing: 5) {

            // configure title label
            CustomTextFieldTitleLabel(leftSidePadding: leftSidePadding, labelTitle: labelTitle, titleTextColor: titleTextColor)
            
            // HStack containg left icon, textfield, right icon
            HStack(alignment: .center, spacing: 0) {
                // left side icon
                CustomTextFieldIcon(enumIconType: .left(leftIcon))
                
                // configure textfield
                CustomGenericTextField(placeHolderText:placeHolderText, action:{ flagActiveUnActive in
                    active =  flagActiveUnActive
                })
                
                // right side icon
                CustomTextFieldIcon(enumIconType: .right(rightIcon))
            }
            .background(RoundedRectangle.init(cornerRadius: 6.7).fill(bgColor))
            .padding(.leading, leftSidePadding).padding(.trailing, rightSidePadding) // outer stack view set L-20 T-20
        }
    }
}

// Extension of View For placeholde
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}


/*
 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 CustomTextField(labelTitle: "First name", placeHolderText: "Enter first name",leftIcon: "chilkoottrail", rightIcon: "charleyrivers")
 //        ContentView().previewDevice(PreviewDevice.init(rawValue: "iPhone 13 Pro"))
 }
 }
 
 public struct PlaceholderStyle: ViewModifier {
 var showPlaceHolder: Bool
 var placeholder: String
 
 public func body(content: Content) -> some View {
 ZStack(alignment: .leading) {
 if showPlaceHolder {
 Text(placeholder)
 .padding(.horizontal, 15)
 }
 content
 .foregroundColor(Color.pink)
 .padding(5.0)
 }
 }
 }
 struct TextFieldModifier: ViewModifier {
 let color: Color
 let padding: CGFloat // <- space between text and border
 let lineWidth: CGFloat
 
 func body(content: Content) -> some View {
 Spacer().padding(0).frame(width: 20, height: 20, alignment: .leading)
 content
 .overlay(RoundedRectangle(cornerRadius: padding)
 .stroke(color, lineWidth: lineWidth))
 Spacer().padding(0).frame(width: 20, height: 20, alignment: .trailing)
 }
 }
 
 extension View {
 func customTextField(color: Color = .secondary, padding: CGFloat = 3, lineWidth: CGFloat = 1.0) -> some View { // <- Default settings
 self.modifier(TextFieldModifier(color: color, padding: padding, lineWidth: lineWidth)).font(.title)
 }
 }
 */

