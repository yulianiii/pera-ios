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
//  LedgerDeviceCell.swift

import UIKit

final class LedgerDeviceCell: BaseCollectionViewCell<LedgerDeviceCellView> {
    override init(frame: CGRect) {
        super.init(frame: frame)

        customize(LedgerDeviceCellViewTheme())
    }

    private func customize(_ theme: LedgerDeviceCellViewTheme) {
        contextView.customize(theme)
    }

    func bindData(_ viewModel: LedgerDeviceListViewModel?) {
        contextView.bindData(viewModel)
    }
}
