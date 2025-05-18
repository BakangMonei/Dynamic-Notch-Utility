import SwiftUI

struct ClipboardModule: View {
    @StateObject private var clipboardService = ClipboardService()
    @State private var isExpanded = false
    
    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 8) {
                Image(systemName: "doc.on.clipboard")
                    .font(.system(size: 16))
                
                if let current = clipboardService.currentItem {
                    switch current {
                    case .text(let string):
                        Text(string)
                            .font(.system(size: 12))
                            .lineLimit(1)
                    case .image:
                        Text("Image")
                            .font(.system(size: 12))
                    }
                } else {
                    Text("Clipboard empty")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.black.opacity(0.7))
            .cornerRadius(8)
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(clipboardService.clipboardItems, id: \.self) { item in
                        HStack {
                            switch item {
                            case .text(let string):
                                Text(string)
                                    .font(.system(size: 10))
                                    .lineLimit(1)
                            case .image:
                                Image(systemName: "photo")
                                    .font(.system(size: 10))
                            }
                            Spacer()
                            Button(action: { clipboardService.copyItem(item) }) {
                                Image(systemName: "arrow.clockwise")
                                    .font(.system(size: 10))
                            }
                        }
                        .padding(.vertical, 2)
                    }
                }
                .padding(8)
                .background(Color.black.opacity(0.7))
                .cornerRadius(8)
            }
        }
    }
} 

#Preview {
    ClipboardModule()
}
