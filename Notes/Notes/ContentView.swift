//
//  ContentView.swift
//  Notes
//
//  Created by Tommaso Barbiero on 07/12/21.
//

import SwiftUI
import CoreData


struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var folders: FetchedResults<Folder>
    
    let screenSize = UIScreen.main.bounds
    @State private var isShown = false
    @State private var name = ""
    
    @State private var searchText = ""
    
    var body: some View {
        
            ZStack {
                NavigationView {
                        
                            List {
                                ForEach(folders, id: \.self) {folder in
                                    NavigationLink {
                                        InFolderView(folder: folder)
                                           
                                    } label: {
                                        HStack {
                                            Image(systemName: "folder")
                                            
                                            //Text(folder.wra ppedName)
                                            Text(folder.wrappedName)
                                        }
                                    }
                                }
                                .onDelete(perform: deleteFolder)
                            }
                            .navigationTitle("Folders")
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    EditButton()
                                }
                            }
                            
                            .toolbar {
                                ToolbarItemGroup(placement: .bottomBar) {
                                    Button {
                                        isShown.toggle()
                                    } label: {
                                        Image(systemName: "folder.badge.plus")
                                    }
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "square.and.pencil")
                                    }
                                
                            }
                        
                    }
                }
                .sheet(isPresented: $isShown) {
                    AlertView(isShown: $isShown)
                }
        }
    }
    
    
   
    
    
    func deleteFolder(at offsets: IndexSet) {
        for offset in offsets {
            let folder = folders[offset]
            moc.delete(folder)
        }
        
        try? moc.save()
    }
}
//    func filterData() -> [Folder] {
//        var tasksToShow = FolderDataController.folders.filter({(($0).name.contains(searchText) || searchText.isEmpty)})
//
//        return tasksToShow
//    }




struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
