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

//   SwapAvailableBalancePercentageCalculator.swift

import Foundation
import MagpieCore
import MagpieHipo

struct SwapAvailableBalancePercentageValidator: SwapAvailableBalanceValidator {
    var eventHandler: EventHandler?

    private let account: Account
    private let userAsset: Asset
    private let poolAsset: Asset?
    private let amount: UInt64
    private let api: ALGAPI

    init(
        account: Account,
        userAsset: Asset,
        poolAsset: Asset?,
        amount: UInt64,
        api: ALGAPI
    ) {
        self.account = account
        self.userAsset = userAsset
        self.poolAsset = poolAsset
        self.amount = amount
        self.api = api
    }

    /// <note>
    /// Returns the amount that needs to be set on the field for both success and failure cases.
    func validateAvailableSwapBalance() {
        if userAsset.isAlgo {
            validateAvailableBalanceForAlgoAmountIn()
            return
        }

        let isAlgoAmountOut = poolAsset?.isAlgo ?? false
        if isAlgoAmountOut {
            validateAvailableBalanceForAlgoAmountOut()
            return
        }

        validateAvailableBalanceForAsset()
    }
}

extension SwapAvailableBalancePercentageValidator {
    private func validateAvailableBalanceForAlgoAmountIn() {
        guard let algoBalanceAfterMinBalanceAndPadding = getAlgoBalanceAfterMinBalanceAndPadding(includingPadding: true) else {
            publishEvent(.failure(.insufficientAlgoBalance(0)))
            return
        }

        if algoBalanceAfterMinBalanceAndPadding == 0 {
            publishEvent(.validated(algoBalanceAfterMinBalanceAndPadding))
            return
        }

        let draft = PeraSwapFeeDraft(
            assetID: userAsset.id,
            amount: amount
        )
        api.calculatePeraSwapFee(draft) {
            response in
            switch response {
            case .success(let feeResult):
                if let peraFee = feeResult.fee {
                    let algoBalanceAfterPeraFeeResult = algoBalanceAfterMinBalanceAndPadding.subtractingReportingOverflow(peraFee)

                    if algoBalanceAfterPeraFeeResult.overflow {
                        self.publishEvent(.failure(.insufficientAlgoBalance(0)))
                        return
                    }

                    let algoBalanceAfterPeraFeeValue = algoBalanceAfterPeraFeeResult.partialValue

                    if algoBalanceAfterPeraFeeValue >= amount {
                        self.publishEvent(.validated(self.amount))
                    } else {
                        self.publishEvent(.validated(algoBalanceAfterPeraFeeValue))
                    }

                    return
                }
                self.publishEvent(.failure(.unavailablePeraFee(nil)))
            case .failure(let apiError, let hipApiError):
                let error = HIPNetworkError(
                    apiError: apiError,
                    apiErrorDetail: hipApiError
                )
                self.publishEvent(.failure(.unavailablePeraFee(error)))
            }
        }
    }

    private func validateAvailableBalanceForAlgoAmountOut() {
        if getAlgoBalanceAfterMinBalanceAndPadding(includingPadding: false) == nil {
            publishEvent(.failure(.insufficientAlgoBalance(0)))
            return
        }

        publishEvent(.validated(amount))
    }

    private func validateAvailableBalanceForAsset() {
        if amount == 0 {
            publishEvent(.failure(.insufficientAssetBalance(0)))
            return
        }

        let draft = PeraSwapFeeDraft(
            assetID: userAsset.id,
            amount: amount
        )

        api.calculatePeraSwapFee(draft) {
            response in

            switch response {
            case .success(let feeResult):
                if let peraFee = feeResult.fee {
                    guard let algoBalanceAfterMinBalanceAndPadding = self.getAlgoBalanceAfterMinBalanceAndPadding(includingPadding: true) else {
                        self.publishEvent(.failure(.insufficientAlgoBalance(0)))
                        return
                    }

                    let algoBalanceAfterPeraFeeResult = algoBalanceAfterMinBalanceAndPadding.subtractingReportingOverflow(peraFee)

                    if algoBalanceAfterPeraFeeResult.overflow {
                        self.publishEvent(.failure(.insufficientAlgoBalance(amount)))
                        return
                    }

                    self.publishEvent(.validated(amount))
                    return
                }

                self.publishEvent(.failure(.unavailablePeraFee(nil)))
            case .failure(let apiError, let hipApiError):
                let error = HIPNetworkError(
                    apiError: apiError,
                    apiErrorDetail: hipApiError
                )
                self.publishEvent(.failure(.unavailablePeraFee(error)))
            }
        }
    }
}

extension SwapAvailableBalancePercentageValidator {
    private func getAlgoBalanceAfterMinBalanceAndPadding(includingPadding: Bool) -> UInt64? {
        let algoBalance = account.algo.amount
        let minBalance = account.calculateMinBalance()
        let algoBalanceAfterMinBalanceResult = algoBalance.subtractingReportingOverflow(minBalance)

        if algoBalanceAfterMinBalanceResult.overflow {
            return nil
        }
        
        if !includingPadding {
            return algoBalanceAfterMinBalanceResult.partialValue
        }

        let algoBalanceAfterMinBalanceAndPaddingResult =
            algoBalanceAfterMinBalanceResult
            .partialValue
            .subtractingReportingOverflow(SwapQuote.feePadding)

        if algoBalanceAfterMinBalanceAndPaddingResult.overflow {
            return nil
        }

        return algoBalanceAfterMinBalanceAndPaddingResult.partialValue
    }
}
