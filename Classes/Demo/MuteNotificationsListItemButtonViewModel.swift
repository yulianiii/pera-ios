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

//   MuteNotificationsListItemButtonViewModel.swift

import Foundation
import MacaroonUIKit

struct MuteNotificationsListItemButtonViewModel:
    ListItemButtonViewModel,
    PairedViewModel {
    private(set) var title: EditText?
    private(set) var icon: Image?
    private(set) var subtitle: EditText?
    
    init(
        _ model: Account
    ) {
        bind(model)
    }
}

extension MuteNotificationsListItemButtonViewModel {
    mutating func bind(
        _ account: Account
    ) {
        bindIcon(account)
        bindTitle(account)
    }
    
    mutating func bindIcon(
        _ account: Account
    ) {
        icon = account.receivesNotification
            ? "icon-options-mute-notification"
            : "icon-options-unmute-notification"
    }
    
    mutating func bindTitle(
        _ account: Account
    ) {
        title = account.receivesNotification
            ? Self.getTitle(String(localized: "options-mute-notification"))
            : Self.getTitle(String(localized: "options-unmute-notification"))
    }
}
