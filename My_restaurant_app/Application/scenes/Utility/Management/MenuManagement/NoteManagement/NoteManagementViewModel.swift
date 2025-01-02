//
//  NoteManagementViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 22/10/2024.
//

import SwiftUI


class NoteManagementViewModel: ObservableObject {
    let branchId = Constants.branch.id ?? 0
    let brandId = Constants.brand.id ?? 0
    
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
   
    
}


extension NoteManagementViewModel{
    func getNotes(){
        
        NetworkManager.callAPI(netWorkManger:.note(branch_id:branchId,status: ACTIVE)){[weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                case .success(let data):

                    guard var res = try? JSONDecoder().decode(APIResponse<[Note]>.self, from: data) else{
                        dLog("Parse model sai")
                        return
                    }
                    
                    for (i,note) in res.data.enumerated(){
                        res.data[i].branch_id = branchId
                    }
                
                    NoteList = res.data

                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func createNote(note:Note){
        
        NetworkManager.callAPI(netWorkManger:.createNote(note:note)){[weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                case .success(let data):

                    guard var res = try? JSONDecoder().decode(PlainAPIResponse.self, from: data) else{
                        dLog("Parse model sai")
                        return
                    }
                    
                   getNotes()

                case .failure(let error):
                print(error)
            }
        }
    }
    
    
   
    
}
