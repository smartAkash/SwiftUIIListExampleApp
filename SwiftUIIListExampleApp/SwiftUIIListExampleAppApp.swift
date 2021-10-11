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
                CustomSegmentedPickerView(buttonTitlesArray: [.jobs, .search, .discover],tabHeight: 50, buttonAction: { enumSegmentType in
                    debugPrint(enumSegmentType.title)
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
