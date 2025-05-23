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

//   AlgoAssetItem.swift

import Foundation

final class AlgoAssetItem {
    let asset: Algo
    let amount: Decimal?
    let currency: CurrencyProvider
    let currencyFormatter: CurrencyFormatter
    let currencyFormattingContext: CurrencyFormattingContext?

    init(
        account: AccountHandle,
        currency: CurrencyProvider,
        currencyFormatter: CurrencyFormatter,
        currencyFormattingContext: CurrencyFormattingContext? = nil
    ) {
        self.asset = account.value.algo
        self.amount = account.isAvailable
            ? account.value.algo.amount.toAlgos
            : nil
        self.currency = currency
        self.currencyFormatter = currencyFormatter
        self.currencyFormattingContext = currencyFormattingContext
    }

    init(
        account: Account,
        currency: CurrencyProvider,
        currencyFormatter: CurrencyFormatter,
        currencyFormattingContext: CurrencyFormattingContext? = nil
    ) {
        self.asset = account.algo
        self.amount = account.algo.amount.toAlgos
        self.currency = currency
        self.currencyFormatter = currencyFormatter
        self.currencyFormattingContext = currencyFormattingContext
    }
}
