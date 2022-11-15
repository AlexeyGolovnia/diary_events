//
//  NavigationBar.swift
//  Events_7.03.21
//
//  Created by Alexey Golovnia on 7.03.21.
//

import SwiftUI

struct NavigationBar: View {
    
    @EnvironmentObject var arrayEvents: ArrayEvents
    
    var body: some View {
        HStack {
            EditButton()
            Spacer()
            Button("Add") {
                arrayEvents.events.append(tempElement)
            }
        }
        .font(.largeTitle)
        
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}
