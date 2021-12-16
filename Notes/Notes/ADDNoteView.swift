//
//  ADDNoteView.swift
//  Note
//
//  Created by Francesco Panariello on 09/12/21.
//

import SwiftUI

struct ADDNoteView: View {
    
    let folder : Folder
    let screenSize = UIScreen.main.bounds
    
    @State private var titleText = "title"
    @State private var contentText = "content"
    @Environment(\.managedObjectContext) private var moc
    
    
    var body: some View {
        
        VStack{
            TextEditor(text: $titleText)
                .font(.largeTitle.bold())
            
            TextEditor(text: $contentText)
                .foregroundColor(.secondary)
            //                .padding(.horizontal)
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
        withAnimation {
            let newNote = Note(context: moc)
            newNote.title = titleText
            newNote.content = contentText
            //            newNote.image = ""
            newNote.lastModify = Date()
            
            newNote.inFolder = folder
            
            try? moc.save()
            
            //            InFolderView(folder: folder)
            
        }
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
    
    //    private func deleteNotes(offsets: IndexSet) {
    //        withAnimation {
    //            offsets.map { notes[$0] }.forEach(viewContext.delete)
    //
    //            do {
    //                try viewContext.save()
    //            } catch {
    //                // Replace this implementation with code to handle the error appropriately.
    //                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    //                let nsError = error as NSError
    //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    //            }
    //        }
    //    }
}



private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


//    struct ADDNoteView_Previews: PreviewProvider {
//        static var previews: some View {
//            ADDNoteView(folder: folder)
//        }
//    }
