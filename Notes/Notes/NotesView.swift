//
//  NotesView.swift
//  Notes
//
//  Created by Tommaso Barbiero on 07/12/21.
//

import SwiftUI

struct NotesView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello world")
            }
            .navigationTitle("Notes")
        }
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
