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
//  LedgerTransactionSigner.swift

import Foundation

final class LedgerTransactionSigner: TransactionSignable {
    private let algorandSDK = AlgorandSDK()
    private var signerAddress: PublicKey?
    
    var eventHandler: ((TransactionSignableEvent) -> Void)?

    init(
        signerAddress: PublicKey?
    ) {
        self.signerAddress = signerAddress
    }

    func sign(
        _ data: Data?,
        with privateData: Data?
    ) -> Data? {
        return signTransaction(
            data, 
            with: privateData
        )
    }
}

extension LedgerTransactionSigner {
    private func signTransaction(
        _ data: Data?,
        with privateData: Data?
    ) -> Data? {
        var transactionError: NSError?

        guard let transactionData = data,
              let privateData = privateData else {
            eventHandler?(
                .didFailedSigning(
                    error: .inapp(
                        .sdkError(error: transactionError)
                    )
                )
            )
            return nil
        }

        if let signerAddress {
            return signRekeyedAccountTransaction(
                transactionData,
                with: privateData,
                for: signerAddress,
                transactionError: &transactionError
            )
        }

        return signLedgerAccountTransaction(
            transactionData,
            with: privateData,
            transactionError: &transactionError
        )
    }

    private func signRekeyedAccountTransaction(
        _ transactionData: Data,
        with privateData: Data,
        for signerAddress: PublicKey,
        transactionError: inout NSError?
    ) -> Data? {
        guard let signedTransactionData = algorandSDK.getSignedTransaction(
            with: signerAddress,
            transaction: transactionData,
            from: privateData,
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

    private func signLedgerAccountTransaction(
        _ transactionData: Data,
        with privateData: Data,
        transactionError: inout NSError?
    ) -> Data? {
        guard let signedTransactionData = algorandSDK.getSignedTransaction(
            transactionData,
            from: privateData,
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
