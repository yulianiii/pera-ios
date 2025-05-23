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
//  TabBarItems.swift

import Foundation
import MacaroonUIKit
import UIKit

struct HomeTabBarItem: TabBarItem {
    let id: String
    let barButtonItem: MacaroonUIKit.TabBarButtonItem
    let screen: UIViewController?

    init(
        _ screen: UIViewController
    ) {
        self.id = TabBarItemID.home.rawValue
        self.barButtonItem =
            TabBarButtonItem(
                icon: [
                    .normal("tabbar-icon-accounts"),
                    .selected("tabbar-icon-accounts-selected"),
                    .disabled("tabbar-icon-accounts-disabled")
                ],
                title: String(localized: "title-home")
            )
        self.screen = screen
    }
}

struct DiscoverTabBarItem: TabBarItem {
    let id: String
    let barButtonItem: MacaroonUIKit.TabBarButtonItem
    let screen: UIViewController?

    init(
        _ screen: UIViewController
    ) {
        self.id = TabBarItemID.discover.rawValue
        self.barButtonItem =
            TabBarButtonItem(
                icon: [
                    .normal("tabbar-icon-discover"),
                    .selected("tabbar-icon-discover-selected"),
                    .disabled("tabbar-icon-discover-disabled")
                ],
                title: String(localized: "title-discover")
            )
        self.screen = screen
    }
}

struct CollectiblesTabBarItem: TabBarItem {
    let id: String
    let barButtonItem: MacaroonUIKit.TabBarButtonItem
    let screen: UIViewController?

    init(
        _ screen: UIViewController
    ) {
        self.id = TabBarItemID.collectibles.rawValue
        self.barButtonItem =
            TabBarButtonItem(
                icon: [
                    .normal("tabbar-icon-collectibles"),
                    .selected("tabbar-icon-collectibles-selected"),
                    .disabled("tabbar-icon-collectibles-disabled")
                ],
                title: String(localized: "title-collectibles")
            )
        self.screen = screen
    }
}

struct SettingsTabBarItem: TabBarItem {
    let id: String
    let barButtonItem: MacaroonUIKit.TabBarButtonItem
    let screen: UIViewController?

    init(
        _ screen: UIViewController
    ) {
        self.id = TabBarItemID.settings.rawValue
        self.barButtonItem =
            TabBarButtonItem(
                icon: [
                    .normal("tabbar-icon-settings"),
                    .selected("tabbar-icon-settings-selected"),
                    .disabled("tabbar-icon-settings-disabled")
                ],
                title: String(localized: "title-settings")
            )
        self.screen = screen
    }
}

enum TabBarItemID: String {
    case home
    case discover
    case collectibles
    case settings
}
