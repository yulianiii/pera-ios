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
//   ALGBlockRequest.swift


import Foundation

final class ALGBlockRequest {
    let localAccounts: [AccountInformation]

    let cachedAccounts: AccountCollection
    let cachedAssetDetails: AssetDetailCollection

    let cachedCurrency: CurrencyProvider

    let blockchainRequests: BlockchainBatchRequest

    init(
        localAccounts: [AccountInformation],
        cachedAccounts: AccountCollection,
        cachedAssetDetails: AssetDetailCollection,
        cachedCurrency: CurrencyProvider,
        blockchainRequests: BlockchainBatchRequest
    ) {
        self.localAccounts = localAccounts
        self.cachedAccounts = cachedAccounts
        self.cachedAssetDetails = cachedAssetDetails
        self.cachedCurrency = cachedCurrency
        self.blockchainRequests = blockchainRequests
    }
}
