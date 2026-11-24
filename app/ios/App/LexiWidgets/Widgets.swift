import WidgetKit
import SwiftUI

private let groupId = "group.tr.rahimov.lexirace"

struct Card: Codable {
    let w: String
    let m: String
}

private func loadCards() -> [Card] {
    guard let s = UserDefaults(suiteName: groupId)?.string(forKey: "deck"),
          let data = s.data(using: .utf8),
          let cards = try? JSONDecoder().decode([Card].self, from: data) else { return [] }
    return cards
}

struct WordEntry: TimelineEntry {
    let date: Date
    let card: Card?
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WordEntry {
        WordEntry(date: Date(), card: Card(w: "address", m: "Adres; bir yerin konum bilgisi"))
    }

    func getSnapshot(in context: Context, completion: @escaping (WordEntry) -> Void) {
        completion(WordEntry(date: Date(), card: loadCards().first ?? Card(w: "address", m: "Adres; bir yerin konum bilgisi")))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WordEntry>) -> Void) {
        let cards = loadCards()
        let now = Date()
        var entries: [WordEntry] = []
        if cards.isEmpty {
            entries.append(WordEntry(date: now, card: nil))
        } else {
            let step: TimeInterval = 30 * 60
            let n = min(cards.count, 48)
            let start = Int(now.timeIntervalSince1970 / step) % cards.count
            for k in 0..<n {
                let c = cards[(start + k) % cards.count]
                entries.append(WordEntry(date: now.addingTimeInterval(Double(k) * step), card: c))
            }
        }
        let end = now.addingTimeInterval(Double(max(entries.count, 1)) * 30 * 60)
        completion(Timeline(entries: entries, policy: .after(end)))
    }
}

private let bgColor = Color(red: 0.24, green: 0.17, blue: 0.15)
private let cream = Color(red: 1.0, green: 0.93, blue: 0.88)

struct WordView: View {
    @Environment(\.widgetFamily) var family
    let entry: WordEntry

    private var isHome: Bool { family == .systemSmall || family == .systemMedium }

    @ViewBuilder var content: some View {
        switch family {
        case .accessoryInline:
            Text(entry.card.map { "\($0.w) · \($0.m)" } ?? "LexiRace kartların boş")
        case .accessoryRectangular:
            VStack(alignment: .leading, spacing: 2) {
                Text(entry.card?.w ?? "Kartların boş")
                    .font(.headline)
                    .widgetAccentable()
                Text(entry.card?.m ?? "Kaçırdığın kelimeleri kartlara ekle")
                    .font(.caption)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        default:
            VStack(spacing: 6) {
                Spacer(minLength: 0)
                Text((entry.card?.w ?? "Kartların boş").uppercased())
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(cream)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                Text(entry.card?.m ?? "Oyun sonunda kaçırdığın kelimeleri kartlara ekle, burada görünsün.")
                    .font(.system(size: 15))
                    .foregroundColor(cream.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.7)
                    .lineLimit(4)
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    var body: some View {
        if #available(iOS 17.0, *) {
            content.containerBackground(for: .widget) {
                if isHome { bgColor } else { Color.clear }
            }
        } else {
            ZStack {
                if isHome { bgColor }
                content.padding()
            }
        }
    }
}

@main
struct LexiWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "LexiWordWidget", provider: Provider()) { entry in
            WordView(entry: entry)
        }
        .configurationDisplayName("Kelime Kartı")
        .description("Bilmediğin kelimeler sırayla görünür.")
        .supportedFamilies([.accessoryInline, .accessoryRectangular, .systemSmall, .systemMedium])
    }
}
