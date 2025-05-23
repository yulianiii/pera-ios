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

//   AssetVerificationTierInfoBoxViewModel.swift

import Foundation
import MacaroonUIKit

struct AssetVerificationTierInfoBoxViewModel: InfoBoxViewModel {
    var icon: Image?
    var title: TextProvider?
    var message: TextProvider?
    var style: InfoBoxViewStyle?

    init(
        _ verificationTier: AssetVerificationTier
    ) {
        bindIcon(verificationTier)
        bindTitle(verificationTier)
        bindMessage(verificationTier)
        bindStyle(verificationTier)
    }
}

extension AssetVerificationTierInfoBoxViewModel {
    private mutating func bindIcon(
        _ verificationTier: AssetVerificationTier
    ) {
        switch verificationTier {
        case .trusted:
            icon = "icon-trusted-24"
        case .verified:
            icon = "icon-verified-24"
        case .unverified:
            break
        case .suspicious:
            icon = "icon-suspicious-24"
        }
    }

    private mutating func bindTitle(
        _ verificationTier: AssetVerificationTier
    ) {
        switch verificationTier {
        case .trusted:
            title = String(localized: "asa-verification-title-trusted")
                .bodyMedium()
                .add([
                    .textColor(Colors.ASABanners.trustedBannerContent.uiColor)
                ])
        case .verified:
            title = String(localized: "asa-verification-title-verified")
                .bodyMedium()
                .add([
                    .textColor(Colors.ASABanners.verifiedBannerContent.uiColor)
                ])
        case .unverified:
            break
        case .suspicious:
            title = String(localized: "asa-verification-title-suspicious")
                .bodyMedium()
                .add([
                    .textColor(Colors.ASABanners.suspiciousBannerContent.uiColor)
                ])
        }
    }

    private mutating func bindMessage(
        _ verificationTier: AssetVerificationTier
    ) {
        switch verificationTier {
        case .trusted:
            message = String(localized: "asa-verification-detail-trusted")
                .bodyRegular()
                .add([
                    .textColor(Colors.ASABanners.trustedBannerContent.uiColor)
                ])
                .addAttributes(
                    to: String(localized: "asa-verification-detail-trusted-bold"),
                    newAttributes: [
                        .font(Fonts.DMSans.medium.make(15).uiFont)
                    ]
                )
        case .verified:
            message = String(localized: "asa-verification-detail-verified")
                .bodyRegular()
                .add([
                    .textColor(Colors.ASABanners.verifiedBannerContent.uiColor)
                ])
                .addAttributes(
                    to: String(localized: "asa-verification-detail-verified-bold"),
                    newAttributes: [
                        .font(Fonts.DMSans.medium.make(15).uiFont)
                    ]
                )
        case .unverified:
            break
        case .suspicious:
            message = String(localized: "asa-verification-detail-suspicious")
                .bodyRegular()
                .add([
                    .textColor(Colors.ASABanners.suspiciousBannerContent.uiColor)
                ])
                .addAttributes(
                    to: String(localized: "asa-verification-detail-suspicious-bold"),
                    newAttributes: [
                        .font(Fonts.DMSans.medium.make(15).uiFont)
                    ]
                )
        }
    }

    private mutating func bindStyle(
        _ verificationTier: AssetVerificationTier
    ) {
        switch verificationTier {
        case .trusted:
            style = InfoBoxViewStyle(
                background: [
                    .backgroundColor(Colors.ASABanners.trustedBannerBackground)
                ],
                corner: Corner(radius: 12)
            )
        case .verified:

            style = InfoBoxViewStyle(
                background: [
                    .backgroundColor(Colors.ASABanners.verifiedBannerBackground)
                ],
                corner: Corner(radius: 12)
            )
        case .unverified:
            break
        case .suspicious:
            style = InfoBoxViewStyle(
                background: [
                    .backgroundColor(Colors.ASABanners.suspiciousBannerBackground)
                ],
                corner: Corner(radius: 12)
            )
        }
    }
}
