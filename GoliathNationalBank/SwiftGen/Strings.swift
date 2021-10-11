// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Data source
  internal static let dataSourceAlertTitle = L10n.tr("Localizable", "dataSourceAlertTitle")
  /// You do not have an internet connection available, the data has been loaded from the cache.
  internal static let internetUnavailableMessage = L10n.tr("Localizable", "internetUnavailableMessage")
  /// You must specify a valid name.
  internal static let invalidNameMessage = L10n.tr("Localizable", "invalidNameMessage")
  /// Invalid name.
  internal static let invalidNameTitle = L10n.tr("Localizable", "invalidNameTitle")
  /// OK
  internal static let ok = L10n.tr("Localizable", "ok")
  /// Transactions with SKU - %@
  internal static func transactionsWithSKU(_ p1: Any) -> String {
    return L10n.tr("Localizable", "transactionsWithSKU", String(describing: p1))
  }
  /// Welcome again, %@!
  internal static func welcomeMessage(_ p1: Any) -> String {
    return L10n.tr("Localizable", "welcomeMessage", String(describing: p1))
  }
  /// Welcome to the work of your life, from today you are an agent at Goliath National Bank, to address you with the respect that such a legendary position deserves, we need to know your name, and you know the golden rule; questions are not allowed.
  internal static let welcomeText = L10n.tr("Localizable", "welcomeText")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
