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

//   CollectibleDetailDataSource.swift

import Foundation
import MacaroonUIKit
import UIKit

final class CollectibleDetailDataSource: UICollectionViewDiffableDataSource<CollectibleDetailSection, CollectibleDetailItem> {
    init(
        collectionView: UICollectionView,
        mediaPreviewController: CollectibleMediaPreviewViewController,
        collectibleDescriptionProvider: @escaping () -> CollectibleDescriptionViewModel?
    ) {
        super.init(collectionView: collectionView) {
            collectionView, indexPath, itemIdentifier in

            switch itemIdentifier {
            case .loading:
                return collectionView.dequeue(
                    CollectibleDetailLoadingCell.self,
                    at: indexPath
                )
            case .error(let viewModel):
                let cell = collectionView.dequeue(
                    CollectibleMediaErrorCell.self,
                    at: indexPath
                )
                cell.bindData(viewModel)
                return cell
            case .name(let item):
                let cell = collectionView.dequeue(
                    CollectibleDetailNameCell.self,
                    at: indexPath
                )
                cell.bindData(item.viewModel)
                return cell
            case .accountInformation(let item):
                let cell = collectionView.dequeue(
                    CollectibleDetailAccountInformationCell.self,
                    at: indexPath
                )
                cell.bindData(item.viewModel)
                return cell
            case .media:
                let cell = collectionView.dequeue(
                    CollectibleMediaPreviewCell.self,
                    at: indexPath
                )
                cell.contextView = mediaPreviewController.view
                return cell
            case .quickActions:
                let cell = collectionView.dequeue(
                    CollectibleDetailQuickActionsCell.self,
                    at: indexPath
                )
                return cell
            case .optOutAction:
                let cell = collectionView.dequeue(
                    CollectibleDetailOptOutActionCell.self,
                    at: indexPath
                )
                return cell
            case .description:
                let cell = collectionView.dequeue(
                    CollectibleDescriptionCell.self,
                    at: indexPath
                )
                let viewModel = collectibleDescriptionProvider()
                cell.bindData(viewModel)
                return cell
            case .information(let info):
                let cell = collectionView.dequeue(
                    CollectibleDetailInformationCell.self,
                    at: indexPath
                )
                let viewModel = CollectibleTransactionInfoViewModel(info)
                cell.bindData(viewModel)
                return cell
            case .creatorAccount(let item):
                let cell = collectionView.dequeue(
                    CollectibleDetailCreatorAccountItemCell.self,
                    at: indexPath
                )
                cell.bindData(item.viewModel)
                return cell
            case .assetID(let item):
                let cell = collectionView.dequeue(
                    CollectibleDetailAssetIDItemCell.self,
                    at: indexPath
                )
                cell.bindData(item.viewModel)
                return cell
            case .properties(let viewModel):
                let cell = collectionView.dequeue(
                    CollectiblePropertyCell.self,
                    at: indexPath
                )
                cell.bindData(viewModel)
                return cell
            }
        }

        supplementaryViewProvider = {
            [weak self] collectionView, kind, indexPath in
            guard let section = self?.snapshot().sectionIdentifiers[safe: indexPath.section] else {
                return nil
            }

            let header = collectionView.dequeueHeader(
                TitleSupplementaryHeader.self,
                at: indexPath
            )

            switch section {
            case .name,
                 .accountInformation,
                 .media,
                 .action,
                 .loading:
                return header
            case .properties:
                header.bindData(
                    CollectibleDetailHeaderViewModel(
                        SingleLineIconTitleItem(
                            icon: nil,
                            title: String(localized: "collectible-detail-properties")
                        )
                    )
                )
                return header
            case .description:
                header.bindData(
                    CollectibleDetailHeaderViewModel(
                        SingleLineIconTitleItem(
                            icon: nil,
                            title: String(localized: "collectible-detail-description")
                        )
                    )
                )
                return header
            }
        }

        [
            CollectibleDetailLoadingCell.self,
            CollectibleMediaErrorCell.self,
            CollectibleDetailNameCell.self,
            CollectibleDetailAccountInformationCell.self,
            CollectibleDetailQuickActionsCell.self,
            CollectibleDetailOptOutActionCell.self,
            CollectibleDescriptionCell.self,
            CollectibleDetailCreatorAccountItemCell.self,
            CollectibleDetailAssetIDItemCell.self,
            CollectibleDetailInformationCell.self,
            CollectibleMediaPreviewCell.self,
            CollectiblePropertyCell.self
        ].forEach {
            collectionView.register($0)
        }

        collectionView.register(header: TitleSupplementaryHeader.self)
    }
}
