//
// AppDelegate.swift


import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    var window: UIWindow?
    private let rootNavigationController = UINavigationController()
    private var appFlowController: AppFlowController!
    private var appDependencyContainer: AppDependencyContainerType!

    // MARK: - Application Launch
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootNavigationController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()

        appDependencyContainer = AppDependencyContainer()
        appFlowController = AppFlowController(
            rootNavigationController: rootNavigationController,
            dependency: appDependencyContainer
        )
        
        appFlowController.startFlow(in: window!)

        return true
    }
}

