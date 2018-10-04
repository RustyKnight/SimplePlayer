
import Foundation
import UIKit

typealias AlertActionHandler = (_ action: UIAlertAction) -> Void

extension UIAlertAction {
  static var okay: UIAlertAction {
    return UIAlertAction(title: Strings.General.ok, style: .default, handler: nil)
  }
  //
  //  static var cancel: UIAlertAction {
  //    return UIAlertAction(title: GlobalStrings.Alert.cancel, style: .default, handler: nil)
  //  }
  
  static var destructiveCancel: UIAlertAction {
    return UIAlertAction(title: Strings.General.cancel, style: .destructive, handler: nil)
  }
  
  static func okay(handler: AlertActionHandler?) -> UIAlertAction{
    return UIAlertAction(title: Strings.General.ok, style: .default, handler: handler)
  }
  
  static func cancel(style: UIAlertAction.Style = .default, handler: AlertActionHandler? = nil) -> UIAlertAction{
    return UIAlertAction(title: Strings.General.cancel, style: style, handler: handler)
  }
  
  static func yes(style: UIAlertAction.Style = .default, handler: AlertActionHandler? = nil) -> UIAlertAction{
    return UIAlertAction(title: Strings.General.yes, style: style, handler: handler)
  }
  
  static func no(style: UIAlertAction.Style = .default, handler: AlertActionHandler? = nil) -> UIAlertAction{
    return UIAlertAction(title: Strings.General.no, style: style, handler: handler)
  }
  
  // This will create cancel actions
  // On a table, this will create a "default" cancel operation and a "cancel" operation, so that
  // if the user taps anywhere on the screen, the "cancel" operation will be called
  // On a handset, this will only create the "cancel" operation
  static func cancelActions(performing: ((UIAlertAction) -> Void)? = nil) -> [UIAlertAction] {
    var actions: [UIAlertAction] = []
    if Device.isTablet() {
      actions.append(UIAlertAction.cancel(style: .default, handler: performing))
    }
    actions.append(UIAlertAction.cancel(style: .cancel, handler: performing))
    
    return actions
  }
  
  static func noActions(performing: ((UIAlertAction) -> Void)? = nil) -> [UIAlertAction] {
    var actions: [UIAlertAction] = []
    if Device.isTablet() {
      actions.append(UIAlertAction.no(style: .default, handler: performing))
    }
    actions.append(UIAlertAction.no(style: .cancel, handler: performing))
    
    return actions
  }
  
}
