//
//  FolderView.swift
//  Notes
//
//  Created by Tommaso Barbiero on 07/12/21.
//

import SwiftUI
import CoreData

struct InFolderView: View {
    let folder: Folder
    
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.lastModify, ascending: true)],
        animation: .default) private var notes: FetchedResults<Note>
    
    @State private var showingSheet = false
    @State private var searchText = ""
    
    var body: some View {
        ScrollView {
            VStack {
                List {
                    ForEach(notes) { note in
                        NavigationLink {
                            //UpdateNoteView(notetitle: note.title ?? "", notecontent: note.content ?? "")
                            
                            UpdateNoteView(note: note)
                            
                            //Text(note.title ?? "Ciao")
                        }label: {
                            VStack(alignment: .leading){
                                Text(note.title ?? "TITOLO TEST")
                                    .font(.title3.bold())
                                    .foregroundColor(.black)
                                HStack(){
                                    Text("\(note.lastModify!, formatter: itemFormatter)")
                                        .font(.callout)
                                    Text(note.content ?? "CONTENUTO TEST")
                                        .font(.callout)
                                }
                                .foregroundColor(Color(.systemGray))
                                
                            }
                            
                        }
                    }
                    .onDelete(perform: deleteNotes)
                    
                }
                
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(){
                            showingSheet.toggle()
                        }label:{
                            
                            Label("Add Item", systemImage: "ellipsis.circle")
                            //TODO                    EditButton()
                        }.sheet( isPresented: $showingSheet){
                            SheetView()
                        }
                    }
                    
                    
                }
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            ZStack {
                                HStack(){
                            Text(".")
                            
                            NavigationLink(destination: ADDNoteView(folder: folder)) {
                                Label("Add Item", systemImage: "square.and.pencil")
                            }
                                }
                                Text("\(folder.note!.count) notes")
                                    .foregroundColor(Color(.systemGray4))
                        }
                        }
                        
                    }
//                    .toolbar {
//                        ToolbarItem(placement: .bottomBar) {
//
//                        }
//                    }
                
//                .navigationTitle("Notes")
                
            }
//            .toolbar(content: {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//
//                    }
//                    label : {
//                        Label("Add Book", systemImage: "ellipsis.circle")
//                    }
//                }
//
//            }
//
//            )
//            .toolbar {
//                ToolbarItemGroup(placement: .bottomBar) {
//                    Button {
//
//                    } label: {
//                        Image(systemName: "square.and.pencil")
//                            .opacity(0)
//                    }
//
//                    Button {
//
//                    } label: {
//                        Image(systemName: "square.and.pencil")
//                    }
//                }
//
//
//
//            }
           
//            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle(folder.wrappedName)
            .navigationBarTitleDisplayMode(.automatic)
            .foregroundColor(Color(.systemYellow))
            .background(Color(.systemGray6))
            .searchable(text: $searchText, placement: .automatic)
            .onChange(of: searchText) { newValue in
                notes.nsPredicate = searchPredicate(searchText: newValue)
            }
    }
}
    
    
    private func searchPredicate(searchText: String) -> NSPredicate? {
        if searchText.isEmpty { return nil }
        return NSPredicate(format: "%K BEGINSWITH[cd] %@",
                           #keyPath(Note.title), searchText)
    }
    
    private func deleteNotes(offsets: IndexSet) {
        withAnimation {
            offsets.map { notes[$0] }.forEach(moc.delete)
            
            try? moc.save()
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    //    formatter.timeStyle = .medium
    return formatter
}()


struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "folder")
                Text("Notes")
                Spacer()
                Button() {
                    dismiss()
                }label: {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            
            Form(){
                Button(){
                    //TODO visualizza come galleria
                }label: {
                    HStack{
                        Text("Gallery View")
                        Spacer()
                        Image(systemName: "square.grid.2x2")
                    }
                }
            }
            .frame(width: .infinity, height: 100, alignment: .center)
            
            Form(){
                Button(){
                    //                EditButton()
                    dismiss()
                }label: {
                    HStack{
                        Text("select Notes")
                        Spacer()
                        Image(systemName: "checkmark.circle")
                    }
                }
                Button(){
                }label: {
                    HStack{
                        Text("Ordina note per")
                        Spacer()
                        Image(systemName: "arrow.up.arrow.down")
                    }
                    
                }
                Button(){
                }label: {
                    HStack{
                        Text("Show allegati")
                        Spacer()
                        Image(systemName: "paperclip")
                    }
                }
                
                
            }
            .frame(width: .infinity, height: 200, alignment: .center)
            .background(Color(.systemGray2))
        }
        
    }
}


//
//struct InFolderView_Previews: PreviewProvider {
//    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//    
//    static var previews: some View {
//        
//        let folder = Note(context: moc)
//        folder.name = "Test book"
//        
//        let note = Note(context: moc)
//        note.title = "Test book"
//        note.content = "Test author"
//        
//        
//        return NavigationView {
//            InFolderView(folder: folder)
//        }
//    }
//}

