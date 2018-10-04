
import Foundation
import UIKit

extension UIViewController {
  
  @objc func presentErrorAlertWith(message: String,
                                   preferredStyle: UIAlertController.Style = .alert,
                                   handler: AlertActionHandler? = nil) {
    guard Thread.isMainThread else {
      DispatchQueue.main.async(execute: {
        self.presentErrorAlertWith(
          message: message)
      })
      return
    }
    
    presentOkAlertWith(title: "Error", message: message, preferredStyle: preferredStyle, handler: handler)
  }
  
  @objc func presentAlertWith(title: String? = nil,
                              message: String,
                              preferredStyle: UIAlertController.Style = .alert,
                              actions: [UIAlertAction]) {
    guard Thread.isMainThread else {
      DispatchQueue.main.async(execute: {
        self.presentAlertWith(
          title: title,
          message: message,
          actions: actions)
      })
      return
    }
    let alertController = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .alert)
    for action in actions {
      alertController.addAction(action)
    }
    self.present(alertController,
                 animated: true,
                 completion: nil)
  }
  
  @objc func presentOkAlertWith(title: String? = nil,
                                message: String,
                                preferredStyle: UIAlertController.Style = .alert,
                                handler: AlertActionHandler? = nil) {
    guard Thread.isMainThread else {
      DispatchQueue.main.async(execute: {
        self.presentOkAlertWith(
          title: title,
          message: message,
          handler: handler)
      })
      return
    }
    presentAlertWith(
      title: title,
      message: message,
      actions: [UIAlertAction.okay(handler: handler)])
  }
  
  @objc func presentOkCancelAlertWith(title: String? = nil,
                                      message: String,
                                      preferredStyle: UIAlertController.Style = .alert,
                                      okActionHandler: AlertActionHandler? = nil,
                                      cancelActionHandler: AlertActionHandler? = nil) {
    guard Thread.isMainThread else {
      DispatchQueue.main.async(execute: {
        self.presentOkCancelAlertWith(
          title: title,
          message: message,
          okActionHandler: okActionHandler,
          cancelActionHandler: cancelActionHandler)
      })
      return
    }
    presentAlertWith(
      title: title,
      message: message,
      actions: [
        UIAlertAction.okay(handler: okActionHandler),
        UIAlertAction.cancel(handler: cancelActionHandler)
      ])
  }
  
  @objc func presentYesNoAlertWith(title: String? = nil,
                                   message: String,
                                   preferredStyle: UIAlertController.Style = .alert,
                                   yesActionHandler: AlertActionHandler? = nil,
                                   noActionHandler: AlertActionHandler? = nil) {
    guard Thread.isMainThread else {
      DispatchQueue.main.async(execute: {
        self.presentYesNoAlertWith(
          title: title,
          message: message,
          yesActionHandler: yesActionHandler,
          noActionHandler: noActionHandler)
      })
      return
    }
    presentAlertWith(
      title: title,
      message: message,
      actions: [
        UIAlertAction.yes(handler: yesActionHandler),
        UIAlertAction.no(handler: noActionHandler)
      ])
  }
  
}
