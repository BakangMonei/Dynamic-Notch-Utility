import Foundation
import AppKit
import ScriptingBridge

@objc protocol SpotifyApplication {
    @objc optional var currentTrack: String { get }
    @objc optional var artist: String { get }
    @objc optional var artwork: NSImage { get }
    @objc optional var playerState: String { get }
    
    @objc optional func playpause()
    @objc optional func nextTrack()
    @objc optional func previousTrack()
}

extension SBApplication: SpotifyApplication {}

class MusicService: ObservableObject {
    @Published var currentTrack: String = ""
    @Published var currentArtist: String = ""
    @Published var isPlaying: Bool = false
    @Published var artwork: NSImage?
    
    private var spotify: SpotifyApplication?
    private var timer: Timer?
    
    init() {
        setupSpotify()
        startMonitoring()
    }
    
    private func setupSpotify() {
        spotify = SBApplication(bundleIdentifier: "com.spotify.client")
    }
    
    private func startMonitoring() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateMusicInfo()
        }
    }
    
    private func updateMusicInfo() {
        guard let spotify = spotify else { return }
        
        if let track = spotify.currentTrack {
            currentTrack = track
        }
        
        if let artist = spotify.artist {
            currentArtist = artist
        }
        
        if let state = spotify.playerState {
            isPlaying = state == "playing"
        }
        
        if let art = spotify.artwork {
            artwork = art
        }
    }
    
    func togglePlayPause() {
        spotify?.playpause?()
    }
    
    func nextTrack() {
        spotify?.nextTrack?()
    }
    
    func previousTrack() {
        spotify?.previousTrack?()
    }
    
    deinit {
        timer?.invalidate()
    }
} 
