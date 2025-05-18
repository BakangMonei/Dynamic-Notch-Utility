import SwiftUI

struct PomodoroModule: View {
    @State private var timeRemaining: TimeInterval = 25 * 60 // 25 minutes
    @State private var isRunning = false
    @State private var timer: Timer?
    @State private var isBreak = false
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: isBreak ? "cup.and.saucer.fill" : "timer")
                .foregroundColor(isBreak ? .green : .orange)
            
            Text(timeString(from: timeRemaining))
                .font(.system(size: 12, weight: .medium))
                .monospacedDigit()
            
            Button(action: toggleTimer) {
                Image(systemName: isRunning ? "pause.fill" : "play.fill")
                    .font(.system(size: 12))
            }
            
            Button(action: resetTimer) {
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 12))
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.black.opacity(0.7))
        .cornerRadius(8)
    }
    
    private func toggleTimer() {
        isRunning.toggle()
        if isRunning {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    timer?.invalidate()
                    isRunning = false
                    isBreak.toggle()
                    timeRemaining = isBreak ? 5 * 60 : 25 * 60 // 5 min break or 25 min work
                }
            }
        } else {
            timer?.invalidate()
        }
    }
    
    private func resetTimer() {
        timer?.invalidate()
        isRunning = false
        isBreak = false
        timeRemaining = 25 * 60
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
} 