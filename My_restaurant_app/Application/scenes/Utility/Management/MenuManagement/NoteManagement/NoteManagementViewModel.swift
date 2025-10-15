//
//  NoteManagementViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 22/10/2024.
//

import SwiftUI


class NoteManagementViewModel: ObservableObject, NotFoodDelegate {
   
    
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
                self.createNote(note: first)
            }else{
                var newNote = Note()
                newNote.content = content
                self.createNote(note: newNote)
            }
        })
    }
    
    
    func callBackNoteFood(id: Int, note: String) {
        if var first = self.NoteList.first{$0.id == id}{
            first.content = note
            createNote(note: first)
        }else{
            var newNote = Note()
            newNote.content = note
            newNote.branch_id = branchId
            createNote(note: newNote)
        }
        
    }
    
}


extension NoteManagementViewModel{
    func getNotes(){

        
        NetworkManager.callAPI(netWorkManger: .notesManagement(branch_id:branchId,status: ACTIVE)){[weak self] (result: Result<APIResponse<[Note]>, Error>) in
            guard let self = self else { return }
            
            switch result {

                case .success(var res):
                if res.status == .ok{
                    for (i,_) in res.data.enumerated(){
                        res.data[i].branch_id = branchId
                    }

                    NoteList = res.data
                }
             
                    
                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    func createNote(note:Note){
        

        NetworkManager.callAPI(netWorkManger: .createNote(note:note)){[weak self] (result: Result<PlainAPIResponse, Error>) in
            guard let self = self else { return }
            
            switch result {

                case .success(let data):
                    getNotes()
                    
                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    
   
    
}
