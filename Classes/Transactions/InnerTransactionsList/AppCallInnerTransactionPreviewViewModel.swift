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

//   AppCallInnerTransactionPreviewViewModel.swift

import Foundation
import MacaroonUIKit

struct AppCallInnerTransactionPreviewViewModel:
    InnerTransactionPreviewViewModel {
    var title: EditText?
    var amountViewModel: TransactionAmountViewModel?

    init(
        _ transaction: Transaction
    ) {
        bindTitle(transaction)
        bindAmount(transaction)
    }
}

extension AppCallInnerTransactionPreviewViewModel {
    private mutating func bindTitle(
        _ transaction: Transaction
    ) {
        title = Self.getTitle(
            transaction.sender.shortAddressDisplay
        )
    }

    private mutating func bindAmount(
        _ transaction: Transaction
    ) {
        guard let innerTransactions = transaction.innerTransactions,
              !innerTransactions.isEmpty else {
            return
        }

        amountViewModel = TransactionAmountViewModel(
            innerTransactionCount: innerTransactions.count
        )
    }
}
