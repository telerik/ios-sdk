//
//  AlertSettingsInfo.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import Foundation

class AlertSettingsInfo: NSObject {
    var title = "Alert"
    var message = "Hello world"
    var allowParallax = false
    var backgroundStyle = TKAlertBackgroundStyle.Dim
    var actionsLayout = TKAlertActionsLayout.Horizontal
    var dismissMode = TKAlertDismissMode.None
    var dismissDirection  = TKAlertSwipeDismissDirection.Horizontal
    var animationDuration: CGFloat = 0.3
    var backgroundDim: CGFloat = 0.3
}
