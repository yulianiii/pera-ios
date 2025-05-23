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

//   TransactionActionViewTheme.swift

import MacaroonUIKit
import UIKit

struct TransactionActionInformationViewTheme: StyleSheet, LayoutSheet {
    let title: TextStyle
    let minimumSpacingBetweenTitleAndItems: LayoutMetric
    
    let description: TextStyle
    let descriptionLeadingPadding: LayoutMetric
    
    let actionWithData: ButtonStyle
    let actionWithoutData: ButtonStyle
    let actionTopPadding: LayoutMetric

    init(_ family: LayoutFamily) {
        self.title = [
            .textAlignment(.left),
            .textOverflow(FittingText()),
            .textColor(Colors.Text.gray),
            .font(Typography.bodyRegular())
        ]
        self.minimumSpacingBetweenTitleAndItems = 16

        self.description = [
            .textAlignment(.left),
            .textOverflow(FittingText()),
            .textColor(Colors.Text.main),
            .font(Typography.bodyRegular())
        ]
        self.descriptionLeadingPadding = 137
        
        self.actionWithData = [
            .title(String(localized: "title-edit")),
            .font(Typography.bodyMedium()),
            .titleColor([
                .normal(Colors.Helpers.positive)
            ]),
            .backgroundColor(Colors.Defaults.background),
            .icon([
                .normal("icon-edit-positive")
            ])
        ]
        self.actionWithoutData = [
            .title(String(localized: "title-add-note")),
            .font(Typography.bodyMedium()),
            .titleColor([
                .normal(Colors.Helpers.positive)
            ]),
            .backgroundColor(Colors.Defaults.background),
            .icon([
                .normal("icon-plus-positive")
            ])
        ]
        self.actionTopPadding = 8
    }
}
