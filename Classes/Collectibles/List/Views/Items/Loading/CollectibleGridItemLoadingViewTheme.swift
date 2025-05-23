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

//   CollectibleGridItemLoadingViewTheme.swift

import MacaroonUIKit

struct CollectibleGridItemLoadingViewTheme:
    LayoutSheet,
    StyleSheet {
    let titleViewHeight: LayoutMetric
    let titleTopPadding: LayoutMetric
    let titleWidthMultiplier: LayoutMetric

    let subtitleViewHeight: LayoutMetric
    let subtitleTopPadding: LayoutMetric
    let subtitleWidthMultiplier: LayoutMetric
    
    let corner: Corner

    init(
        _ family: LayoutFamily
    ) {
        titleTopPadding = 12
        titleViewHeight = 16
        titleWidthMultiplier = 0.29

        subtitleTopPadding = 8
        subtitleViewHeight = 20
        subtitleWidthMultiplier = 0.75

        corner = Corner(radius: 4)
    }
}
