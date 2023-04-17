//
//  RewardedAdManager.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 14.01.2023.
//

import GoogleMobileAds

class RewardedAdManager: NSObject, GADFullScreenContentDelegate {
    var rewardedAd: GADRewardedAd?

    func loadRewardedAd() {
        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID: "ca-app-pub-4749079164629106/8705519785", request: request) { [self] ad, error in
            if let error = error {
                print("Failed to load reward ad with error: \(error.localizedDescription)")
                return
            }
            rewardedAd = ad
            rewardedAd?.fullScreenContentDelegate = self
        }
    }


    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        loadRewardedAd()
    }


    func showRewardedAd(viewController: UIViewController) {
        if rewardedAd != nil {
            rewardedAd!.present(fromRootViewController: viewController, userDidEarnRewardHandler: {
                let reward = self.rewardedAd!.adReward
                print("\(reward.amount) \(reward.type)")
            })
        } else {
            print("RewardedAd wasn't ready")
        }
    }
}
