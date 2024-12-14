//
//  ToastUtils.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 25/09/2024.
//

import SwiftUI
import AlertToast
import Combine
class ToastUtils {

//    @Published var alertToast = AlertToast(type: .regular)
//    {
//        didSet{
//            showAlert.toggle()
//        }
//    }
    
    var loadingToast = AlertToast(type: .loading)
    
//    @Published var showAlert:Bool = false
    var subject = PassthroughSubject<Bool, Never>()
    var cancellables = Set<AnyCancellable>()
//    var showLoading = Binding(
//        get: { [weak self] in
//            (self?.subject ?? false)
//        },
//        set: { [weak self] in
//            self?.subject = $0
//        }
//    )
    
}

