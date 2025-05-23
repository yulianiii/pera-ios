// Copyright 2022-2025 Pera Wallet, LDA

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//    http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//   CopyToClipboardActionController.swift

import Foundation
import MacaroonUIKit
import UIKit

protocol CopyToClipboardController {
    func copy(
        _ item: ClipboardItem
    )
}

extension CopyToClipboardController {
    func copyAddress(
        _ account: Account
    ) {
        copyAddress(account.address)
    }

    func copyURL(
        _ url: String
    ) {
        let interaction = CopyToClipboardInteraction(
            title: String(localized: "url-copied-to-clipboard"),
            body: url
        )
        let item = ClipboardItem(copy: url, interaction: interaction)
        copy(item)
    }

    func copyAddress(
        _ address: String
    ) {
        let interaction = CopyToClipboardInteraction(
            title: String(localized: "address-copied-to-clipboard"),
            body: address.shortAddressDisplay
        )
        let item = ClipboardItem(copy: address, interaction: interaction)
        copy(item)
    }

    func copyID(
        _ asset: Asset
    ) {
        let idCopy = String(asset.id)
        let interaction = CopyToClipboardInteraction(
            title: String(localized: "id-copied-to-clipboard"),
            body: "#\(idCopy)"
        )
        let item = ClipboardItem(copy: idCopy, interaction: interaction)
        return copy(item)
    }

    func copyID(
        _ asset: AssetDecoration
    ) {
        let idCopy = String(asset.id)
        let interaction = CopyToClipboardInteraction(
            title: String(localized: "id-copied-to-clipboard"),
            body: "#\(idCopy)"
        )
        let item = ClipboardItem(copy: idCopy, interaction: interaction)
        return copy(item)
    }

    func copyID(
        _ id: AssetID
    ) {
        let idCopy = String(id)
        let interaction = CopyToClipboardInteraction(
            title: String(localized: "id-copied-to-clipboard"),
            body: "#\(idCopy)"
        )
        let item = ClipboardItem(copy: idCopy, interaction: interaction)
        return copy(item)
    }

    func copyID(
        _ transaction: Transaction
    ) {
        let idCopy = (transaction.id ?? transaction.parentID).someString
        let interaction = CopyToClipboardInteraction(
            title: String(localized: "id-copied-to-clipboard"),
            body: "#\(idCopy)"
        )
        let item = ClipboardItem(copy: idCopy, interaction: interaction)
        return copy(item)
    }

    func copyNote(
        _ transaction: Transaction
    ) {
        let noteCopy = transaction.noteRepresentation().someString
        let interaction = CopyToClipboardInteraction(
            title: String(localized: "note-copied-to-clipboard"),
            body: nil
        )
        let item = ClipboardItem(copy: noteCopy, interaction: interaction)
        return copy(item)
    }

    func copyApplicationCallAppID(
        _ transaction: Transaction
    ) {
        let idCopy = String(transaction.applicationCall!.appID ?? .zero)
        let interaction = CopyToClipboardInteraction(
            title: String(localized: "id-copied-to-clipboard"),
            body: "#\(idCopy)"
        )
        let item = ClipboardItem(copy: idCopy, interaction: interaction)
        return copy(item)
    }

    func copyText(
        _ someText: String
    ) {
        let interaction = CopyToClipboardInteraction(
            title: String(localized: "title-copied-to-clipboard"),
            body: nil
        )
        let item = ClipboardItem(copy: someText, interaction: interaction)
        return copy(item)
    }
    
    func copyImage(
        _ someImage: UIImage
    ) {
        let interaction = CopyToClipboardInteraction(
            title: String(localized: "image-copied-to-clipboard"),
            body: nil
        )
        let item = ClipboardItem(image: someImage, interaction: interaction)
        return copy(item)
    }
}

struct ClipboardItem {
    let copy: String
    let image: UIImage?
    /// The message to interact with the user as the result of the copy action.
    let interaction: ClipboardInteraction?

    init(
        copy: String = "",
        image: UIImage? = nil,
        interaction: ClipboardInteraction? = nil
    ) {
        self.copy = copy
        self.image = image
        self.interaction = interaction
    }
}

protocol ClipboardInteraction {
    typealias Message = ToastViewModel
    typealias Theme = ToastViewTheme

    var message: Message { get }
    var theme: Theme { get }
}

struct CopyToClipboardInteraction: ClipboardInteraction {
    private(set) var message: Message
    private(set) var theme: Theme

    init(
        title: String?,
        body: String?,
        customTheme: Theme? = nil
    ) {
        self.message = InMessage(title: title, body: body)
        self.theme = customTheme ?? ToastViewTheme().configuredForSingleLineBody()
    }
}

extension CopyToClipboardInteraction {
    private struct InMessage: Message {
        var title: TextProvider?
        var body: TextProvider?

        init(
            title: String?,
            body: String?
        ) {
            self.title = title?.bodyMedium(
                alignment: .center,
                lineBreakMode: .byWordWrapping
            )
            self.body = body?.footnoteRegular(
                alignment: .center,
                lineBreakMode: .byTruncatingMiddle
            )
        }
    }
}
