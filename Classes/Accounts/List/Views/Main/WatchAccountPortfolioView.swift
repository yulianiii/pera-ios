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

//   WatchAccountPortfolioView.swift

import MacaroonUIKit
import UIKit

final class WatchAccountPortfolioView:
    View,
    ViewModelBindable,
    ListReusable,
    UIInteractable {
    
    enum Event {
        case onAmountTap
    }
    
    // MARK: - Properties
    
    let uiInteractions: [Event: MacaroonUIKit.UIInteraction] = [
        .onAmountTap: TargetActionInteraction()
    ]
    
    private lazy var titleView = Label()
    private lazy var valueView = Label()
    private lazy var valueButton = MacaroonUIKit.Button()
    private lazy var secondaryValueView = Label()
    
    // MARK: - Initialisers
    
    init() {
        super.init(frame: .zero)
        setupGestures()
    }
    
    // MARK: - Setups
    
    private func setupGestures() {
        startPublishing(event: .onAmountTap, for: valueButton)
    }

    func customize(
        _ theme: WatchAccountPortfolioViewTheme
    ) {
        addTitle(theme)
        addValue(theme)
        addSecondaryValue(theme)
    }

    func customizeAppearance(
        _ styleSheet: NoStyleSheet
    ) {}

    func prepareLayout(
        _ layoutSheet: LayoutSheet
    ) {}

    func bindData(
        _ viewModel: WatchAccountPortfolioViewModel?
    ) {
        if let title = viewModel?.title {
            title.load(in: titleView)
        } else {
            titleView.text = nil
            titleView.attributedText = nil
        }

        if let primaryValue = viewModel?.primaryValue {
            primaryValue.load(in: valueView)
        } else {
            valueView.text = nil
            valueView.attributedText = nil
        }

        if let secondaryValue = viewModel?.secondaryValue {
            secondaryValue.load(in: secondaryValueView)
        } else {
            secondaryValueView.text = nil
            secondaryValueView.attributedText = nil
        }
    }

    class func calculatePreferredSize(
        _ viewModel: WatchAccountPortfolioViewModel?,
        for theme: WatchAccountPortfolioViewTheme,
        fittingIn size: CGSize
    ) -> CGSize {
        guard let viewModel = viewModel else {
            return CGSize((size.width, 0))
        }

        let width = size.width
        let titleSize = viewModel.title?.boundingSize(
            multiline: false,
            fittingSize: CGSize((width, .greatestFiniteMagnitude))
        ) ?? .zero
        let valueSize = viewModel.primaryValue?.boundingSize(
            multiline: false,
            fittingSize: .greatestFiniteMagnitude
        ) ?? .zero
        let secondaryValueSize = viewModel.secondaryValue?.boundingSize(
            multiline: false,
            fittingSize: .greatestFiniteMagnitude
        ) ?? .zero
        let preferredHeight =
            theme.titleTopPadding +
            titleSize.height +
            theme.spacingBetweenTitleAndValue +
            valueSize.height +
            theme.spacingBetweenTitleAndValue +
            secondaryValueSize.height
        return CGSize((size.width, min(preferredHeight.ceil(), size.height)))
    }
}

extension WatchAccountPortfolioView {
    private func addTitle(
        _ theme: WatchAccountPortfolioViewTheme
    ) {
        titleView.customizeAppearance(theme.title)

        addSubview(titleView)
        titleView.fitToIntrinsicSize()
        titleView.snp.makeConstraints {
            $0.top == 0
            $0.leading == theme.contentHorizontalPaddings.leading
            $0.trailing == theme.contentHorizontalPaddings.trailing
        }
    }

    private func addValue(
        _ theme: WatchAccountPortfolioViewTheme
    ) {
        valueView.customizeAppearance(theme.value)

        [valueView, valueButton].forEach(addSubview)
        
        valueView.fitToIntrinsicSize()
        valueView.snp.makeConstraints {
            $0.top == titleView.snp.bottom + theme.spacingBetweenTitleAndValue
            $0.leading == theme.contentHorizontalPaddings.leading
            $0.trailing == theme.contentHorizontalPaddings.trailing
        }
        
        valueButton.snp.makeConstraints {
            $0.edges.equalTo(valueView)
        }
    }

    private func addSecondaryValue(
        _ theme: WatchAccountPortfolioViewTheme
    ) {
        secondaryValueView.customizeAppearance(theme.secondaryValue)

        addSubview(secondaryValueView)
        secondaryValueView.fitToIntrinsicSize()
        secondaryValueView.snp.makeConstraints {
            $0.top == valueView.snp.bottom + theme.spacingBetweenTitleAndValue
            $0.leading == theme.contentHorizontalPaddings.leading
            $0.bottom == 0
            $0.trailing == theme.contentHorizontalPaddings.trailing
        }
    }
}
