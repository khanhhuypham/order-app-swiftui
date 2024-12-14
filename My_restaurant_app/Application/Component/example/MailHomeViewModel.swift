//
//  MailHomeViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 17/09/2024.
//

import UIKit

class MailHomeViewModel: ObservableObject {
    @Published var mails: [Mail] = []
    @Published var pinned: [Mail] = []
    
    func getAll() {
        mails = Mail.sampleData
    }
    
    func updateReadStatus(mail: Mail, readStatus: ReadStatus) {
        if let idx = getIndex(for: mail) {
            mails[idx].readStatus = readStatus
        }
    }
    
    func moveToPinned(mail: Mail) {
        if let idx = getIndex(for: mail) {
            pinned.append(mail)
            mails.remove(at: idx)
        }
    }
    
    private func getIndex(for mail: Mail) -> Int? {
        if let idx = mails.firstIndex(where: { $0.id == mail.id }) {
            return idx
        }
        return nil
    }
}
