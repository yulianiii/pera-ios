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

//   AppCallTransactionAssetInformationViewTheme.swift

import MacaroonUIKit
import UIKit

struct AppCallTransactionAssetInformationViewTheme:
    LayoutSheet,
    StyleSheet {
    var contentPaddings: LayoutPaddings
    var title: TextStyle
    var minimumSpacingBetweenTitleAndAssetInfo: LayoutMetric
    var assetInfo: AppCallAssetPreviewStackViewTheme
    var assetInfoLeadingPadding: LayoutMetric

    init(
        _ family: LayoutFamily
    ) {
        contentPaddings = (12, 24, 12, 24)
        title = [
            .textOverflow(FittingText()),
            .textColor(Colors.Text.gray),
        ]
        minimumSpacingBetweenTitleAndAssetInfo = 16
        assetInfo = AppCallAssetPreviewStackViewTheme()
        assetInfoLeadingPadding = 137
    }
}
