//
//  main.swift
//  Protocols and Delegates
//
//  Created by Sunggon Park on 2024/02/22.
//

import Foundation

let youri = EmergencyCallHandler()
//let sunggon = Parametic(handler: youri)
let jigyo = Doctor(handler: youri)

youri.medicalEmergency()
