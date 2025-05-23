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
//  TransactionData.swift

import Foundation

final class TransactionData {
    private(set) var sender: String
    private(set) var unsignedTransaction: Data?
    private(set) var signedTransaction: Data?
    private(set) var index: Int = 0
    
    init(
        sender: String,
        unsignedTransaction: Data? = nil,
        signedTransaction: Data? = nil,
        index: Int
    ) {
        self.sender = sender
        self.unsignedTransaction = unsignedTransaction
        self.signedTransaction = signedTransaction
        self.index = index
    }

    var isUnsignedTransactionComposed: Bool {
        return unsignedTransaction != nil
    }

    var isTransactionSigned: Bool {
        return signedTransaction != nil
    }

    func setUnsignedTransaction(_ data: Data) {
        unsignedTransaction = data
    }

    func setSignedTransaction(_ data: Data) {
        signedTransaction = data
    }
}
