//
//  MainScreen.swift
//  Events_7.03.21
//
//  Created by Alexey Golovnia on 7.03.21.
//

import SwiftUI

struct MainScreen: View {
    
    @EnvironmentObject var arrayEvents: ArrayEvents
    
    func makeBinding(_ idx: Int) -> Binding<Elements> {
        return Binding(
            get: { idx < self.arrayEvents.events.count ? self.arrayEvents.events[idx] : tempElement },
            set: { self.arrayEvents.events[idx] = $0 }
        )
    }
    
    func move(from source: IndexSet, to destination: Int) {
        arrayEvents.events.move(fromOffsets: source, toOffset: destination)
    }
    
    var body: some View {
        NavigationView {
            Form {
                ForEach(arrayEvents.events.indices, id: \.self) { value in
                    NavigationLink(destination: TimeSet(elements: makeBinding(value))) {
                        RowView(elements: makeBinding(value))
                    }
                }
                .onDelete(perform: { arrayEvents.events.remove(atOffsets: $0)})
                .onMove(perform: move)
            }
            .navigationBarTitle(Text("Events").font(.largeTitle), displayMode: .large)
            .navigationBarItems(trailing: NavigationBar())
        }
        //.environment(\.colorScheme, .dark)
    }
    
}

