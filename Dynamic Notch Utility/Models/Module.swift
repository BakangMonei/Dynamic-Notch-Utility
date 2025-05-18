import SwiftUI

protocol Module: Identifiable {
    var id: String { get }
    var name: String { get }
    var icon: String { get }
    var isEnabled: Bool { get set }
    var view: AnyView { get }
}

struct BaseModule: Module {
    let id: String
    let name: String
    let icon: String
    var isEnabled: Bool
    let view: AnyView
    
    init(id: String, name: String, icon: String, isEnabled: Bool = true, view: some View) {
        self.id = id
        self.name = name
        self.icon = icon
        self.isEnabled = isEnabled
        self.view = AnyView(view)
    }
} 