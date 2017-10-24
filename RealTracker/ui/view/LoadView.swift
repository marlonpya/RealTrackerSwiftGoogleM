//
//  LoadView.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

protocol LoadView {
    
    func showLoading()
    func hideLoading()
    func messageError(message: String)
}
