//
//  SwipeActionView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 17/09/2024.
//

import SwiftUI

enum ReadStatus {
    case read
    case unread
}


struct Mail: Identifiable {
    let id = UUID()
    var from: String
    var initials: String
    var background: Color
    var subject: String
    var detail: String
    var readStatus: ReadStatus
    var time: String
}



struct MailCell: View {
    var mail: Mail
    
    var body: some View {
        HStack(alignment: .top) {
            HStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 5, height: 5)
                    .opacity(mail.readStatus == .read ? 0.0 : 1.0)
                Text(mail.initials)
                    .padding()
                    .background(mail.background)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(mail.from)
                        .bold()
                    
                    Spacer()
                    
                    Text(mail.time)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Text(mail.subject)
                    .bold()
                    .font(.subheadline)
                
                Text(mail.detail)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct MailHome: View {
    
    @ObservedObject var vm = MailHomeViewModel()
    
    var body: some View {
        NavigationView {
            List {
                if !vm.pinned.isEmpty {
                    Section(header: Text("Pinned mails")) {
                        ForEach(vm.pinned) { mail in
                            MailCell(mail: mail).swipeActions(allowsFullSwipe: false) {
                                    readUnreadActionButton(mail: mail)
                            }
                        }
                    }
                }
                
                if !vm.mails.isEmpty {
                    Section(header: vm.pinned.isEmpty ? Text("") : Text("Unpinned mails")) {
                        ForEach(vm.mails) { mail in
                            MailCell(mail: mail)
                                .swipeActions(allowsFullSwipe: false) {
                                    readUnreadActionButton(mail: mail)
                                }
                                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                    pinnedActionButton(mail: mail)
                                }
                        }
                    }
                }
                
            }
            .navigationTitle("Inbox")
            .onAppear {
                vm.getAll()
            }
        }
    }
    
    private func readUnreadActionButton(mail: Mail) -> some View {
        Button {
            vm.updateReadStatus(mail: mail, readStatus: mail.readStatus == .read ? .unread : .read)
        } label: {
            Label(mail.readStatus == .read ? "Unread" : "Read", systemImage: mail.readStatus == .read ? "envelope.fill" : "envelope.open.fill")
        }
        .tint(.red)
    }
    
    private func pinnedActionButton(mail: Mail) -> some View {
        Button {
            vm.moveToPinned(mail: mail)
        } label: {
            Label("Pin", systemImage: "pin.fill")
        }
        .tint(.yellow)
    }
}


#Preview {
    MailHome()
}



extension Mail {
    static var sampleData: [Mail] {
        [
            Mail(from: "Albus Dumbledore", initials: "AD", background: Color.pink.opacity(0.5), subject: "About Nicolas Flamel", detail: "To the well-organized mind, death is but the next great adventure.", readStatus: .unread, time: "8:25 PM"),
            Mail(from: "Kingsley Shacklebolt", initials: "KS", background: Color.orange.opacity(0.5), subject: "Battle of Hogwarts", detail: "Every human life is worth the same, and worth saving.", readStatus: .read, time: "12:25 PM"),
            Mail(from: "Hermione Granger", initials: "HG", background: Color.blue.opacity(0.5), subject: "Wrong vs Right", detail: "Dumbledore says people find it far easier to forgive others for being wrong than being right.", readStatus: .read, time: "12:25 PM"),
            Mail(from: "Luna Lovegood", initials: "LL", background: Color.purple.opacity(0.5), subject: "Crumple-Horned Snorkack", detail: "You can laugh, but people used to believe there were no such things as the Blibbering Humdinger or the Crumple-Horned Snorkack!", readStatus: .unread, time: "2:25 PM"),
            Mail(from: "Albus Dumbledore", initials: "AD", background: Color.pink.opacity(0.5), subject: "Thing about pain", detail: "Numbing the pain for a while will make it worse when you finally feel it", readStatus: .unread, time: "7:55 AM"),
        ]
    }
}
