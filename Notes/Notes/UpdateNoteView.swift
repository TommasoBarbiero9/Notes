//
//  ModifyView.swift
//  Note
//
//  Created by Francesco Panariello on 14/12/21.
//

import SwiftUI
import CoreData

struct UpdateNoteView: View {
    
    let note : Note
    
    @State private var titleText = ""
    @State private var contentText = ""
    @Environment(\.managedObjectContext) var moc
    
    
    var body: some View {
        
        VStack{
            TextEditor(text: $titleText)
                .onAppear{titleText = note.title ?? ""}
                .padding()
                .font(.largeTitle.bold())
                
            
            
            TextEditor(text: $contentText)
                .onAppear{contentText = note.content ?? ""}
                .foregroundColor(.secondary)
                .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(){
                    addItem()
            
                }label:{
                    Text("Done")
                }
                
            }
        }
    }
    
    
    private func addItem() {
            deleteNote(note: note)
            let newNote = Note(context: moc)
            newNote.title = titleText
            newNote.content = contentText
//            newNote.image = ""
            newNote.lastModify = Date()
            
        try? moc.save()
//        InFolderView(folder: folder)

        
    }
    
    private func deleteNote(note: Note) {
            moc.delete(note)
            do {
                try moc.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
}




private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//struct ModifyView_Previews: PreviewProvider {
//    static var previews: some View {
//        ModifyView()
//    }
//}
