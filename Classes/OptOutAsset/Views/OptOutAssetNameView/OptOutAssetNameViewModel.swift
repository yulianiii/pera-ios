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

//   OptOutAssetNameViewModel.swift

import Foundation
import MacaroonUIKit

struct OptOutAssetNameViewModel: PrimaryTitleViewModel {
    private(set) var primaryTitle: TextProvider?
    private(set) var primaryTitleAccessory: Image?
    private(set) var secondaryTitle: TextProvider?

    init(asset: Asset) {
        bindPrimaryTitle(asset: asset)
        bindPrimaryTitleAccessory(asset: asset)
        bindSecondaryTitle(asset: asset)
    }
}

extension OptOutAssetNameViewModel {
    mutating func bindPrimaryTitle(asset: Asset) {
        let title = asset.naming.name.unwrapNonEmptyString() ?? String(localized: "title-unknown")

        var attributes = Typography.titleSmallMediumAttributes(lineBreakMode: .byTruncatingTail)

        if asset.verificationTier.isSuspicious {
            attributes.insert(.textColor(Colors.Helpers.negative))
        }

        let destroyedText = makeDestroyedAssetTextIfNeeded(asset.isDestroyed)
        let assetText = title.attributed(attributes)

        primaryTitle = [ destroyedText, assetText ].compound(" ")
    }

    private func makeDestroyedAssetTextIfNeeded(_ isAssetDestroyed: Bool) -> NSAttributedString? {
        guard isAssetDestroyed else {
            return nil
        }

        let title = String(localized: "title-deleted-with-parantheses")
        var attributes = Typography.titleSmallMediumAttributes(lineBreakMode: .byTruncatingTail)
        attributes.insert(.textColor(Colors.Helpers.negative))
        return title.attributed(attributes)
    }

    mutating func bindPrimaryTitleAccessory(asset: Asset) {
        switch asset.verificationTier {
        case .trusted: primaryTitleAccessory = "icon-trusted"
        case .verified: primaryTitleAccessory = "icon-verified"
        case .unverified: primaryTitleAccessory = nil
        case .suspicious: primaryTitleAccessory = "icon-suspicious"
        }
    }

    mutating func bindSecondaryTitle(asset: Asset) {
        secondaryTitle = asset.naming.unitName?.bodyRegular(lineBreakMode: .byTruncatingTail)
    }
}
