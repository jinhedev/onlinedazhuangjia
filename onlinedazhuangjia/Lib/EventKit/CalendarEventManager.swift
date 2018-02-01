//
//  CalendarEventManager.swift
//  BitCoinClient
//
//  Created by rightmeow on 1/11/18.
//  Copyright © 2018 rightmeow. All rights reserved.
//

import Foundation
import EventKit

protocol CalendarEventDelegate: NSObjectProtocol {
    func calendarEvent(_ manager: CalendarEventManager, didErr error: Error)
    func calendarEvent(_ manager: CalendarEventManager, didAdd event: EKEvent)
}

extension CalendarEventDelegate {
    func calendarEvent(_ manager: CalendarEventManager, didAdd event: EKEvent) {}
}

class CalendarEventManager: NSObject {

    let resourceName = "EventSeeds"
    let resourceExtension = "plist"
    var events = [NSDictionary]()
    let eventStore = EKEventStore()
    weak var delegate: CalendarEventDelegate?

    func addEvent(title: String, startDate: Date, endDate: Date) {
        if !isSeeded() {
            let newEvent = self.createEvent(title: title, startDate: startDate, endDate: endDate)
            eventStore.requestAccess(to: EKEntityType.event) { (granted, error) in
                if granted {
                    do {
                        try self.eventStore.save(newEvent, span: EKSpan.thisEvent, commit: true)
                        UserDefaults.standard.set(true, forKey: "\(self.resourceName).\(self.resourceExtension)")
                        self.delegate?.calendarEvent(self, didAdd: newEvent)
                    } catch let err {
                        self.delegate?.calendarEvent(self, didErr: err)
                    }
                } else if let err = error {
                    self.delegate?.calendarEvent(self, didErr: err)
                } else {
                    // granted == false
                    return
                }
            }
        }
    }

    private func createEvent(title: String, startDate: Date, endDate: Date) -> EKEvent {
        let newEvent = EKEvent(eventStore: eventStore)
        newEvent.title = title
        newEvent.startDate = startDate
        newEvent.endDate = endDate
        newEvent.calendar = eventStore.defaultCalendarForNewEvents
        return newEvent
    }

    private func isSeeded() -> Bool {
        let defaults = UserDefaults.standard
        let isSeeded = defaults.bool(forKey: "\(resourceName).\(resourceExtension)")
        return isSeeded
    }

}

extension CalendarEventManager {

    // MARK: - Localized Helpers

    fileprivate func fetchArray(forResource: String, extensionType: String) -> NSArray {
        guard let pathToFile = Bundle.main.path(forResource: forResource, ofType: extensionType) else {
            fatalError("undefined path to file: \(forResource).\(extensionType)")
        }
        guard let targetFile = NSArray(contentsOfFile: pathToFile) else {
            fatalError("Incompatible format for content.")
        }
        return targetFile
    }

    fileprivate func writeArray(arrayToWrite: NSArray, forResource: String, extensionType: String) {
        guard let pathToFile = Bundle.main.path(forResource: forResource, ofType: extensionType) else {
            fatalError("undefined path to file: \(forResource).\(extensionType)")
        }
        let url = URL(fileURLWithPath: pathToFile)
        arrayToWrite.write(to: url, atomically: true)
    }

}
