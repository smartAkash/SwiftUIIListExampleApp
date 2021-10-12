//
//  SwiftUIIListExampleAppApp.swift
//  SwiftUIIListExampleApp
//
//  Created by Akash on 05/10/21.
//

import SwiftUI

@main
struct SwiftUIIListExampleAppApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack{
                Color.yellow
                CustomSegmentedPickerView(buttonTitlesArray: [.simple(title: "Jobs"), .simpleWithLeftSideIcon(title: "Search", icon: "searchAtLandingPage"), .simpleWithRightSideIcon(title: "Connect",icon: "umbagog")],tabHeight: 50, buttonTapAction: { enumSegmentType in
                    debugPrint(enumSegmentType)
                })
            }
//            CustomSegmentView(selectedSegment: .discover, buttonTitlesArray: [.search,.jobs]) { selectionType in
//                debugPrint(selectionType.title)
//            }
//            ContentView().environment(\.colorScheme, .light)
//            ContentView().environment(\.colorScheme, .dark)
        }
    }

}
