import SwiftUI

public struct SegmentButtonItem: Identifiable {
    public let id = UUID()
    public let icon: String
    public let title: String

    public init(icon: String, title: String) {
        self.icon = icon
        self.title = title
    }
}

public struct SegmentButtonsView: View {
    @Binding var selectedIndex: Int
    let items: [SegmentButtonItem]
    let selectedBackgroundColor: Color
    let unselectedTextColor: Color
    let cornerRadius: CGFloat

    public init(
        items: [SegmentButtonItem],
        selectedIndex: Binding<Int>,
        selectedBackgroundColor: Color = .blue,
        unselectedTextColor: Color = .gray,
        cornerRadius: CGFloat = 25
    ) {
        self.items = Array(items.prefix(4)) // 限制最多4个
        self._selectedIndex = selectedIndex
        self.selectedBackgroundColor = selectedBackgroundColor
        self.unselectedTextColor = unselectedTextColor
        self.cornerRadius = cornerRadius
    }

    public var body: some View {
        GeometryReader { geometry in
            let horizontalPadding: CGFloat = 16
            let totalWidth = geometry.size.width - horizontalPadding * 2
            let unitWidth = totalWidth / 5
            let spacing: CGFloat = 8

            HStack(spacing: spacing) {
                ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                    Button(action: {
                        withAnimation(.spring(duration: 0.3)) {
                            selectedIndex = index
                        }
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: item.icon)
                                .font(.system(size: 16))

                            if selectedIndex == index {
                                Text(item.title)
                                    .font(.system(size: 14))
                                    .transition(.opacity.combined(with: .move(edge: .leading)))
                            }
                        }
                        .foregroundColor(selectedIndex == index ? .white : unselectedTextColor)
                        .frame(width: selectedIndex == index ? unitWidth * 2 : unitWidth, height: 44)
                        .background(
                            Capsule()
                                .fill(selectedIndex == index ? selectedBackgroundColor : Color(.systemGray6))
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, horizontalPadding) // ✅ 左右对称
        }
        .frame(height: 60)
    }
}