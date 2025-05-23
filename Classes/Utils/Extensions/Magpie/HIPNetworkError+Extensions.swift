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
//   HIPNetworkError+Extensions.swift


import Foundation
import MagpieCore
import MagpieExceptions
import MagpieHipo

extension HIPNetworkError {
    var isCancelled: Bool {
        switch self {
        case .connection(let connectionError): return connectionError.isCancelled
        default: return false
        }
    }
    
    var prettyDescription: String {
        let defaultMessage = String(localized: "title-generic-api-error")
        
        switch self {
        case .client(_, let detail),
             .server(_, let detail):
            let apiDetail = detail as? HIPAPIError
            return apiDetail?.message() ?? defaultMessage
        default:
            return defaultMessage
        }
    }
}
