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

    
    var loadingToast = AlertToast(type: .loading)
    
    var subject = PassthroughSubject<Bool, Never>()
    var cancellables = Set<AnyCancellable>()
    
    
    var alertSubject = PassthroughSubject<AlertToast, Never>()
    var alertCancellables = Set<AnyCancellable>()
    

}

