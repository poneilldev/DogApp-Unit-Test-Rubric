//
//  AppointmentsViewModel.swift
//  Dog-app
//
//  Created by Paul O'Neill on 3/30/21.
//

import Foundation
import Combine
import CoreData

class AppointmentsViewModel {
    let appointments = CurrentValueSubject<[Appointment], Never>([])
    
    init() {
        getAppointments()
    }
    
    func getAppointments() {
        print("Fetching appointments")
    }
}
