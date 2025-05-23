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
//  MaximumBalanceWarningViewModel.swift

import UIKit
import MacaroonUIKit

final class MaximumBalanceWarningViewModel: ViewModel {
    private(set) var description: String?

    init(
        _ account: Account,
        _ transactionParams: TransactionParams
    ) {
        bindDescription(
            from: account,
            with: transactionParams
        )
    }
}

extension MaximumBalanceWarningViewModel {
    private func bindDescription(
        from account: Account,
        with transactionParams: TransactionParams
    ) {
        let minimumAmountForAccount = "\(calculateMininmumAmount(for: account, and: transactionParams).toAlgos)"

        if !account.hasAuthAccount() {
            description = String(format: String(localized: "maximum-balance-standard-account-warning-description"), minimumAmountForAccount)
            return
        }

        description = String(format: String(localized: "maximum-balance-warning-description"), minimumAmountForAccount)
    }

    private func calculateMininmumAmount(
        for account: Account,
        and params: TransactionParams
    ) -> UInt64 {
        let feeCalculator = TransactionFeeCalculator(transactionDraft: nil, transactionData: nil, params: params)
        let calculatedFee = params.getProjectedTransactionFee()
        let minimumAmountForAccount = feeCalculator.calculateMinimumAmount(
            for: account,
               with: .algo,
               calculatedFee: calculatedFee,
               isAfterTransaction: true
        ) - calculatedFee
        return minimumAmountForAccount
    }
}
