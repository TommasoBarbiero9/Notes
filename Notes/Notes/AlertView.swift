//
//  AlertView.swift
//  Notes
//
//  Created by Tommaso Barbiero on 13/12/21.
//

import SwiftUI

struct AlertView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    
    let screenSize = UIScreen.main.bounds
    @Binding var isShown: Bool
//    @Binding var name: String
    
    @State private var name = ""
    
    var title: String = "New Folder"
    var message : String = "Enter a name for this folder"
    
    var body: some View {
        ZStack {
            VStack {
                Text(title)
                Text(message)
                
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }

                    Button {
                        let newFolder = Folder(context: moc)
                        newFolder.name = name
                        try? moc.save()
                        dismiss()
                    } label: {
                        Text("Save")
                    }

                }
            }            .padding()
            .frame(width: screenSize.width * 0.6, height: screenSize.height * 0.3)

            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
    }
}


struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(isShown: .constant(true))
    }
}
