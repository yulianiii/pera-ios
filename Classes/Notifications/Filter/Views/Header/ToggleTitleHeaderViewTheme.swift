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

//
//   ToggleTitleHeaderViewTheme.swift

import Foundation
import MacaroonUIKit
import UIKit

struct ToggleTitleHeaderViewTheme: StyleSheet, LayoutSheet {
    let titleLabel: TextStyle
    let horizontalPadding: LayoutMetric
    let topPadding: LayoutMetric 

    init(_ family: LayoutFamily) {
        self.titleLabel = [
            .textOverflow(SingleLineText()),
            .textAlignment(.left),
            .textColor(Colors.Text.gray),
            .font(Fonts.DMSans.regular.make(13)),
            .text(String(localized: "notification-filter-show-for"))
        ]
        self.horizontalPadding = 24
        self.topPadding = 36
    }
}
