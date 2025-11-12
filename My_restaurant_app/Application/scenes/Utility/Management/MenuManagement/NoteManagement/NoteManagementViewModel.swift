//
//  NoteManagementViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 22/10/2024.
//

import SwiftUI


class NoteManagementViewModel: ObservableObject {
   
    let branchId = Constants.branch.id
    let brandId = Constants.brand.id
    
    @Published var NoteList:[Note] = []
    @Published var isPresent = false
    @Published var popup:(any View)? = nil
    

 
    func showPopup(note:Note){
        let binding = Binding(
           get: { self.isPresent },
           set: { self.isPresent = $0 }
        )
        isPresent = true
        popup = NoteView(isPresent: binding, id: note.id ,inputText:note.content,completion:{id,content in
            if var first = self.NoteList.first{$0.id == id}{
                first.content = content
                Task{
                    await self.createNote(note: first)
                }
            }else{
                var newNote = Note()
                newNote.content = content
                Task{
                    await self.createNote(note: newNote)
                }
            }
        })
    }
    
    
    func callBackNoteFood(id: Int, note: String) {
        if var first = self.NoteList.first{$0.id == id}{
            first.content = note
            Task{
                await createNote(note: first)
            }
        }else{
            var newNote = Note()
            newNote.content = note
            newNote.branch_id = branchId
            Task{
                await createNote(note: newNote)
            }
        }
        
    }
    
}


extension NoteManagementViewModel{
    func getNotes() async{
        let result:Result<APIResponse<[Note]>, Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .notesManagement(branch_id:branchId,status: ACTIVE))
                
        switch result {

            case .success(var res):
                if res.status == .ok,var data = res.data{
                    for (i,_) in data.enumerated(){
                        data[i].branch_id = branchId
                    }

                    NoteList = data
                }
         
                
            case .failure(let error):
               dLog("Error: \(error)")
        }

    }
    
    func createNote(note:Note) async{
        
        let result:Result<PlainAPIResponse, Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .createNote(note:note))
       
        switch result {

            case .success(let data):
               await getNotes()
                
            case .failure(let error):
               dLog("Error: \(error)")
        }
        
    }
    
    
   
    
}
