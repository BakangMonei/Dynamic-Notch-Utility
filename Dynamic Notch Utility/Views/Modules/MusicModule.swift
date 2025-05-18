import SwiftUI

struct MusicModule: View {
    @StateObject private var musicService = MusicService()
    
    var body: some View {
        HStack(spacing: 8) {
            if let artwork = musicService.artwork {
                Image(nsImage: artwork)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .cornerRadius(4)
            } else {
                Image(systemName: "music.note")
                    .frame(width: 24, height: 24)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(musicService.currentTrack)
                    .font(.system(size: 12, weight: .medium))
                    .lineLimit(1)
                
                Text(musicService.currentArtist)
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            
            HStack(spacing: 4) {
                Button(action: musicService.previousTrack) {
                    Image(systemName: "backward.fill")
                        .font(.system(size: 12))
                }
                
                Button(action: musicService.togglePlayPause) {
                    Image(systemName: musicService.isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 12))
                }
                
                Button(action: musicService.nextTrack) {
                    Image(systemName: "forward.fill")
                        .font(.system(size: 12))
                }
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.black.opacity(0.7))
        .cornerRadius(8)
    }
} 