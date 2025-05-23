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

//   SortAccountListDataController.swift

import UIKit

protocol SortAccountListDataController: AnyObject {
    typealias Snapshot = NSDiffableDataSourceSnapshot<SortAccountListSection, SortAccountListItem>

    var eventHandler: ((SortAccountListDataControllerEvent) -> Void)? { get set }

    var selectedSortingAlgorithm: AccountSortingAlgorithm { get }

    func load()

    func selectItem(
        at indexPath: IndexPath
    )
    func moveItem(
        from source: IndexPath,
        to destination: IndexPath
    )

    func performChanges()
}

enum SortAccountListSection:
    Hashable {
    case sortOptions
    case reordering
}

enum SortAccountListItem: Hashable {
    case sortOption(SelectionValue<SingleSelectionViewModel>)
    case reordering(AccountListItemViewModel)
}

enum SortAccountListDataControllerEvent {
    case didUpdate(SortAccountListDataController.Snapshot)
    case didComplete

    var snapshot: SortAccountListDataController.Snapshot? {
        switch self {
        case .didUpdate(let snapshot): return snapshot
        default: return nil
        }
    }
}
