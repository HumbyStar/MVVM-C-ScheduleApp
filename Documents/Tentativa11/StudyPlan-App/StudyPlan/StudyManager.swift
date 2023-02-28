//
//  StudyManager.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 16/01/23.
//

import Foundation
import UserNotifications

final class StudyManager {
    static let shared = StudyManager()
    let ud = UserDefaults.standard
    var studyPlan: [StudyPlan] = []
    
    private init() {
        if let data = ud.data(forKey: "study"), let plans = try? JSONDecoder().decode([StudyPlan].self, from: data) {
            self.studyPlan = plans
        }
    }
    
    func savePlans() {
        if let data = try? JSONEncoder().encode(studyPlan) {
            ud.set(data, forKey: "study")
        }
    }
    
    func addPlan(_ plan: StudyPlan) {
        studyPlan.append(plan)
        savePlans()
    }
    
    func removePlan(index: Int) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [studyPlan[index].id])
        studyPlan.remove(at: index)
        savePlans()
    }
    
    func setDonePlan(id: String) {
        if let studyPlan = studyPlan.first(where: {$0.id == id}) {
            studyPlan.done = true
        }
    }
    
    func getPlanNote(id: String) -> StudyPlan? {
        return studyPlan.first(where: {$0.id == id})
    }
}
