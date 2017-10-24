//
//  MapaController.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class MapaController: BaseController {
    fileprivate var goGMSMapView: GMSMapView!
    private var goPresenter: ListVehiclePresenter!
    fileprivate var goTimer: Timer?
    fileprivate var gaoListVehicle = [Vehicle]()
    private static let gdSeconds: TimeInterval = 2
    
    override func viewDidLoad() {
        cycleLife = self
        super.viewDidLoad()
        
        let loGMSCameraPosition = GMSCameraPosition.camera(withLatitude: Constant.Ubication.Peru.LATITUDE,
                                                           longitude: Constant.Ubication.Peru.LONGITUDE,
                                                           zoom: 11)
        goGMSMapView = GMSMapView.map(withFrame: CGRect.zero, camera: loGMSCameraPosition)
        self.view.layoutIfNeeded()
        self.view = goGMSMapView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        goTimer = Timer.scheduledTimer(timeInterval: MapaController.gdSeconds, target: self, selector: #selector(callListVehicle), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        goTimer?.invalidate()
        goTimer = nil
    }
    
    @objc private func callListVehicle() {
        goPresenter.actionGetListVehicle(psIdUser: "0")
    }
    
    @IBAction func onClickCloseSession(_ sender: Any) {
        goTimer?.invalidate()
        goTimer = nil
        self.navigationController?.popViewController(animated: true)
        AppDelegate.getInstance().goUser = nil
    }
}

extension MapaController: CycleLife {
    func initView() {
        goPresenter = ListVehiclePresenter(poView: self)
    }
    
    func ui() {
    }
}

extension MapaController: ListVehicleView {
    func renderListVehicle(paoListVehicle: [Vehicle]) {
        gaoListVehicle.removeAll()
        goGMSMapView.clear()
        
        gaoListVehicle = paoListVehicle
        for loVehicle in gaoListVehicle {
            let latitude = (loVehicle.numLatitud as NSString).doubleValue
            let longitude = (loVehicle.numLongitud as NSString).doubleValue
            let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
            let point = GMSMarker(position: coordinate)
            point.title = loVehicle.nomConductor
            point.map = goGMSMapView
        }
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func messageError(message: String) {
        //showAlert(psMessage: message, withCompletion: nil)
        print("_ERROR \(message)")
    }
}
