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

//   AlgoRemoteCurrency.swift

import Foundation

final class AlgoRemoteCurrency: RemoteCurrency {
    var isFault: Bool {
        return usdValue == nil
    }

    let id: CurrencyID
    let name: String?
    let symbol: String?
    let algoValue: Decimal?
    let usdValue: Decimal?
    let lastUpdateDate: Date

    init(
        baseCurrency: FiatCurrency
    ) {
        let local = AlgoLocalCurrency(pairID: baseCurrency.id)

        self.id = local.id
        self.name = local.name
        self.symbol = local.symbol
        self.algoValue = 1
        self.usdValue = baseCurrency.usdToAlgoValue
        self.lastUpdateDate = baseCurrency.lastUpdateDate
    }
}
