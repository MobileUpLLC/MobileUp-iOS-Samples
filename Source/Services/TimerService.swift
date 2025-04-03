import Foundation

class TimerService {
    private enum Constants {
        static let timerTolerance: TimeInterval = 0.1
    }
    
    var isTimerPassed: Bool { currentDate >= endDate }
    var isItFirstTimerStart: Bool { timer == nil }
    var isTimerOn = false
    
    var onRemainingTimeChangeAction: Closure.Generic<DateComponents?>? {
        didSet { onRemainingTimeChangeAction?(getRemainingTime) }
    }
    
    var getRemainingTime: DateComponents? {
        guard currentDate < endDate else {
            stopTimer()
            return nil
        }
        
        return calendar.dateComponents([.minute, .second], from: currentDate, to: endDate)
    }
        
    private let calendar = Calendar.current
    
    private let timerInterval: TimeInterval
    private let timerUpdateRate: TimeInterval
    
    private var timer: Timer?
    private var endDate = Date()
    private var currentDate = Date()
    
    init(timerInterval: TimeInterval, timerUpdateRate: TimeInterval) {
        self.timerInterval = timerInterval
        self.timerUpdateRate = timerUpdateRate
    }
    
    func startTimer(currentDate: Date = .now, endDate: Date? = nil) {
        self.currentDate = currentDate
        self.endDate = endDate ?? (currentDate + timerInterval)
        
        onRemainingTimeChangeAction?(getRemainingTime)
        isTimerOn = true
        createTimer()
    }
    
    func continueTimer() {
        isTimerOn = true
        onRemainingTimeChangeAction?(getRemainingTime)
        createTimer()
    }
    
    func createTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: timerUpdateRate, repeats: true) { [weak self] _ in
            guard let self else {
                return
            }
            
            currentDate.addTimeInterval(timerUpdateRate)
            
            onRemainingTimeChangeAction?(getRemainingTime)
        }
        
        timer?.tolerance = Constants.timerTolerance
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isTimerOn = false
    }
}
//
//  TimerService.swift
//  com.samples.app
//
//  Created by Кирилл Кошкарёв on 31.03.2025.
//
