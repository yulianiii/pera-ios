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
//  SDKTransactionSigner.swift

import Foundation

final class SDKTransactionSigner: TransactionSignable {
    private let algorandSDK = AlgorandSDK()
    
    var eventHandler: ((TransactionSignableEvent) -> Void)?
    
    func sign(
        _ data: Data?,
        with privateData: Data?
    ) -> Data? {
        var transactionError: NSError?

        guard let unsignedTransactionData = data,
              let privateData = privateData,
              let signedTransactionData = algorandSDK.sign(
                privateData,
                with: unsignedTransactionData,
                error: &transactionError
              ) else {
            eventHandler?(
                .didFailedSigning(
                    error: .inapp(
                        .sdkError(error: transactionError)
                    )
                )
            )
            return nil
        }

        return signedTransactionData
    }
}
