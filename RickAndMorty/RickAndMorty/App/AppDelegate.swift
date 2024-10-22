//
// AppDelegate.swift


import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Propreties
    lazy var window: UIWindow? = UIWindow()
    lazy var rootNavigationController = UINavigationController()
    private var rmAppflowController: RMAppFlowController!
    var appDependencyContainer: AppDependencyContainerType!
    
    // MARK: - Application launch
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
        window?.backgroundColor = .red
        
        appDependencyContainer = AppDependencyContainer()
        
        rmAppflowController = RMAppFlowController(
            rootNavigationController: rootNavigationController,
            dependency: appDependencyContainer
        )
        
        rmAppflowController.startFlow(window: window!)
        
        return true
    }
    
}

