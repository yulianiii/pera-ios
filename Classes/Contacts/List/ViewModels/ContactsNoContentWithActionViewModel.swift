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
//   ContactsNoContentWithActionViewModel.swift

import Foundation
import MacaroonUIKit

struct ContactsNoContentWithActionViewModel: NoContentWithActionViewModel {
    private(set) var icon: Image?
    private(set) var title: TextProvider?
    private(set) var body: TextProvider?
    private(set) var primaryAction: Action?
    private(set) var secondaryAction: Action?

    init() {
        bindIcon()
        bindTitle()
        bindBody()
        bindActionTitle()
    }
}

extension ContactsNoContentWithActionViewModel {
    private mutating func bindIcon() {
        icon = "icon-contacts-empty"
    }

    private mutating func bindTitle() {
        title = String(localized: "contacts-empty-text")
    }

    private mutating func bindBody() {
        body = String(localized: "contacts-empty-detail-text")
    }

    private mutating func bindActionTitle() {
        primaryAction = Action(
            title: .string(String(localized: "contacts-add")),
            image: nil
        )
    }
}
