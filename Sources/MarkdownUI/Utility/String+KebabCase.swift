import Foundation

extension String {
  func kebabCased() -> String {
    self.components(separatedBy: .alphanumerics.inverted)
      .map { $0.lowercased() }
      .joined(separator: "-")
  }
}


public extension String {
  func toAttributedString() -> AttributedString {
    let blocks = [BlockNode](markdown: self)

    let baseURL: URL? = nil
    let softBreakMode: SoftBreak.Mode = .space
    let attributes = AttributeContainer()
    let myTheme = Theme()

    let attributedString = blocks.reduce(into: AttributedString()) { result, block in
      switch block {
      case .paragraph(let inlineNodes):
        for node in inlineNodes {
          result += node.renderAttributedString(
            baseURL: baseURL,
            textStyles: InlineTextStyles(
              code: myTheme.code,
              emphasis: myTheme.emphasis,
              strong: myTheme.strong,
              strikethrough: myTheme.strikethrough,
              link: myTheme.link
            ),
            softBreakMode: softBreakMode,
            attributes: attributes
          )
        }
        result += AttributedString("\n\n")
      default:
        break
      }
    }
    return attributedString
  }
}
