//
//  HomeViewModel.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 01/06/2022.
//

import UIKit

public enum CaseStudy: String, CaseIterable {
    case CoreData = "Practice CoreData"
    case MapKit = "Practice MapKit"
    case HealthKit = "Practice HealthKit"
    case CallKit = "Practice CallKit"
    case AVKit = "Practice AVKit"
    case PDFKit = "Practice PDFKit"
    case MVP = "Practice MVP"
}

class HomeViewModel {
    init() {
        initCaseStudyData()
    }

    var showRequestNotiDeniedAlert: (() -> ())?

    var showRequestNotiFailedAlert: ((String) -> ())?

    var dismissWarningAlert: (() -> ())?

    private(set) var caseStudyList = [CaseStudy]()

    var currentCaseStudyList: [CaseStudy] {
        get {
            return caseStudyList
        }
    }

    func initCaseStudyData() {
        caseStudyList.append(.CoreData)
        caseStudyList.append(.MapKit)
        caseStudyList.append(.HealthKit)
        caseStudyList.append(.CallKit)
        caseStudyList.append(.AVKit)
        caseStudyList.append(.PDFKit)
        caseStudyList.append(.MVP)
    }

    func checkNotificationAuthorizationStatus() {
        MainNotificationManager.shared.appPermissionStatus { [weak self] status in
            if status == .notDetermined {
                self?.requestNotificationAuthorization()
            } else if (status == .denied) {
                self?.showRequestNotiDeniedAlert?()
            } else if (status == .authorized) {
//                self?.dismissWarningAlert?()
            }
        }
    }

    private func requestNotificationAuthorization() {
        MainNotificationManager.shared.requestAuthorization { [weak self] granted, error in
            if let error = error {
                self?.showRequestNotiFailedAlert?(error.localizedDescription)
            } else {
                if granted {
                    LocalNotificationManager.shared.sendTimeIntervalLocalNotification("Devil May Cry", "OK lun bạn ơi")
                } else {
                    self?.showRequestNotiDeniedAlert?()
                }
            }
        }
    }

    func destinationViewController(_ caseStudy: CaseStudy) -> UIViewController? {
        switch caseStudy {
        case .CoreData:
            return HomeCoreDataViewController()
        case .MapKit:
            return nil
        case .HealthKit:
            return nil
        case .CallKit:
            return CallKitHomeViewController()
        case .AVKit:
            return nil
        case .PDFKit:
            return nil
        case .MVP:
            return TrafficLightViewController()
        }
    }

}
