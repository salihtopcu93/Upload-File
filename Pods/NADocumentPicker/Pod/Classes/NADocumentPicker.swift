//
//  NADocumentPicker.swift
//  Encapsulates UIKit document picker UI
//  iDiffView
//
//  "Why doesn't Dropbox support iOS's open dialog?" - see discussion here: https://www.dropboxforum.com/hc/en-us/community/posts/204836509-Why-doesn-t-Dropbox-support-iOS-s-open-dialog-
//
//  Created by Nick Ager on 25/01/2016.
//  Copyright © 2016 RocketBox Ltd. All rights reserved.
//

import UIKit
import MobileCoreServices
import BrightFutures
import Result

/**
 Error type for `NADocumentPicker`
 
  - NoDocumentPicked: is the error returned by the `Future`
 from `show` when no document is choosen by the user.
 */
public enum NADocumentPickerErrors: Error {
    case noDocumentPicked
    
    func asAnyError() -> AnyError {
        return AnyError(self)
    }
}

/**
 Encapsulates UIKit document picker UI, providing a simple API.
 `show` is the only API entry.
*/
open class NADocumentPicker : NSObject {
    fileprivate let parentViewController: UIViewController
    fileprivate var keepInMemory: NADocumentPicker?
    /*private*/ let promise = Promise<URL, AnyError>()
    
    /**
     Shows the document picker, returning a `Future` containing the document picked
     or `NoDocumentPicked`.
     
     See also: 
     - [nickager.com](http://nickager.com/blog/2016/03/07/DocumentPicker)
     - [github](https://github.com/NickAger/NADocumentPicker)
     
     - Parameter view:  The view from which the popover document menu appears
     - Parameter parentViewController: The associated parent view controller
     - Parameter documentTypes: An array of document types to be opened, by default PlainText
     
     - Returns: A `Future` containing the document picked or `NoDocumentPicked`
     */
    open class func show(from view: UIView, parentViewController: UIViewController, documentTypes: [String] = [kUTTypePlainText as String]) -> Future<URL, AnyError> {
        let instance = NADocumentPicker(parentViewController: parentViewController)
        return instance.showDocumentPicker(from: view, parentViewController: parentViewController, documentTypes: documentTypes)
    }

    /*private*/ init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
        super.init()

        keepInMemoryUntilComplete()
    }

    private func showDocumentPicker(from view: UIView, parentViewController: UIViewController, documentTypes: [String]) -> Future<URL, AnyError> {
        let documentPicker = UIDocumentPickerViewController(documentTypes:documentTypes, in: UIDocumentPickerMode.open)
        documentPicker.delegate = self

        parentViewController.present(documentPicker, animated: true)
        return promise.future
    }

    private func keepOurselvesInMemory() {
        keepInMemory = self
    }

    private func freeOurselvesFromMemory() {
        keepInMemory = nil
    }

    private func keepInMemoryUntilComplete() {
        keepOurselvesInMemory()
        self.promise.future.onComplete { [unowned self] _ in
            self.freeOurselvesFromMemory()
        }
    }
}

// MARK: UIDocumentPickerDelegate
extension NADocumentPicker : UIDocumentPickerDelegate {
    public func documentPicker(_: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        promise.success(url)
    }

    public func documentPickerWasCancelled(_: UIDocumentPickerViewController) {
        promise.failure(NADocumentPickerErrors.noDocumentPicked.asAnyError())
    }
}
