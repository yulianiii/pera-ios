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

//   Constants.swift

import Foundation

enum Constants {
    enum DispatchQueues {
        static let collectibleDetailSnapshot = "collectibleDetailSnapshot"
        static let manageAssetListSnapshot = "manageAssetListSnapshot"
        static let collectibleListSnapshot = "collectibleListSnapshot"
        static let swapPoolAssetSnapshot = "swapPoolAssetSnapshot"
        static let swapLocalAssetSnapshot = "swapLocalAssetSnapshot"
    }

    enum Notification {
        static let collectibleListDidAddCollectible = "collectibleListDidAddCollectible"
        static let collectibleListDidRemoveCollectible = "collectibleListDidRemoveCollectible"
        static let collectibleListDidSendCollectible = "collectibleListDidSendCollectible"
    }
    
    enum Cards {
        static let singleAccount = "singleAccount"
        static let selectedAccount = "selectedAccount"
    }
}
