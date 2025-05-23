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

//   HomePortfolioNavigationViewModel.swift

import Foundation
import MacaroonUIKit

struct HomePortfolioNavigationViewModel: PortfolioViewModel {
    private(set) var primaryValue: TextProvider?
    private(set) var secondaryValue: TextProvider?

    private(set) var currencyFormatter: CurrencyFormatter?

    init(
        _ model: TotalPortfolioItem?
    ) {
        bind(model)
    }
}

extension HomePortfolioNavigationViewModel {
    mutating func bind(
        _ portfolioItem: TotalPortfolioItem?
    ) {
        self.currencyFormatter = portfolioItem?.currencyFormatter

        bindPrimaryValue(portfolioItem)
        bindSecondaryValue(portfolioItem)
    }

    mutating func bindPrimaryValue(
        _ portfolioItem: TotalPortfolioItem?
    ) {
        let text = format(
            portfolioValue: portfolioItem?.portfolioValue,
            currencyValue: portfolioItem?.currency.primaryValue,
            isAmountHidden: portfolioItem?.isAmountHidden ?? false,
            in: .standalone()
        )
        primaryValue = text?.bodyMedium(
            alignment: .center,
            lineBreakMode: .byTruncatingTail
        )
    }

    mutating func bindSecondaryValue(
        _ portfolioItem: TotalPortfolioItem?
    ) {
        let text = format(
            portfolioValue: portfolioItem?.portfolioValue,
            currencyValue: portfolioItem?.currency.secondaryValue,
            isAmountHidden: portfolioItem?.isAmountHidden ?? false,
            in: .standalone()
        )
        secondaryValue = text?.captionMedium(
            alignment: .center,
            lineBreakMode: .byTruncatingTail
        )
    }
}
