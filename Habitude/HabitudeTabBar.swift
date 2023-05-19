//
//  HabitudeTabBar.swift
//  Habitude
//
//  Created by Atacan Sevim on 3.05.2023.
//

import UIKit

final class HabitudeTabBar: UITabBarController {
    
    private var frameView: UIView!
    
    private var backgroundView: UIView = {
        let backgroundView = UIView(frame: .zero)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = UIColor.Habitute.secondaryDark
        backgroundView.layer.cornerRadius = 10
        
        return backgroundView
    }()
    
    private var tabbarItemStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 60
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = true
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
             appearance.configureWithOpaqueBackground()
             appearance.backgroundColor = UIColor.Habitute.primaryDark
             tabBar.standardAppearance = appearance
             tabBar.scrollEdgeAppearance = appearance
        } else {
            tabBar.backgroundColor = UIColor.clear // clears the background
            tabBar.backgroundImage = UIImage()
            tabBar.shadowImage = UIImage()  // removes the border
            tabBar.backgroundColor = UIColor.Habitute.primaryDark
        }
        tabBar.tintColor = UIColor.Habitute.accent
        tabBar.unselectedItemTintColor = UIColor.Habitute.secondaryLight
        delegate = self
        setupVCs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //setCustomBackgroundView()
        //setItemsStackView()
    }
    
    func setupVCs() {
        viewControllers = [
            createNavigationViewController(
                for: HomeViewController(viewModel: HomeViewModel(title: "Home")),
                image: Images.homePageUnselected.image
            ),
            createNavigationViewController(
                for: DrawViewController(viewModel: DrawViewModel()),
                image: Images.tickUnselected.image
            ),
            createNavigationViewController(
                for: ProfileViewController(viewModel: ProfileViewModel(title: "Profile")),
                image: Images.profileUnselected.image
            )
        ]
    }
    
    private func createNavigationViewController(
        for rootViewController: UIViewController,
        image: UIImage
    ) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image
        
        return navController
    }
    
    private func setCustomBackgroundView() {
        tabBar.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor, constant: 16),
            tabBar.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 16),
            tabBar.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 16),
            backgroundView.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func setItemsStackView() {
        backgroundView.addSubview(tabbarItemStack)
        NSLayoutConstraint.activate([
            tabbarItemStack.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10),
            tabbarItemStack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 18),
            backgroundView.trailingAnchor.constraint(equalTo: tabbarItemStack.trailingAnchor, constant: 18),
            backgroundView.bottomAnchor.constraint(equalTo: tabbarItemStack.bottomAnchor, constant: 10)
        ])
        
        tabbarItemStack.addArrangedSubview(getTabBarItem(with: Images.homePageUnselected.image))
        tabbarItemStack.addArrangedSubview(getTabBarItem(with: Images.tickUnselected.image))
        tabbarItemStack.addArrangedSubview(getTabBarItem(with: Images.gearUnselected.image))
        tabbarItemStack.addArrangedSubview(getTabBarItem(with: Images.profileUnselected.image))
    }
    
    private func getTabBarItem(with image: UIImage) -> UIView {
        let itemImageView = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
        itemImageView.tintColor = UIColor.Habitute.accent
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let itemBackgroundView = UIView()
        itemBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        itemBackgroundView.backgroundColor = UIColor.Habitute.primaryDark
        itemBackgroundView.layer.cornerRadius = 5
        
        itemBackgroundView.addSubview(itemImageView)
        NSLayoutConstraint.activate([
            itemImageView.heightAnchor.constraint(equalToConstant: 15),
            itemImageView.widthAnchor.constraint(equalToConstant: 15),
            itemBackgroundView.centerXAnchor.constraint(equalTo: itemImageView.centerXAnchor),
            itemBackgroundView.centerYAnchor.constraint(equalTo: itemImageView.centerYAnchor)
        ])
        
        return itemBackgroundView
    }
    
    func addTabbarIndicatorView(index: Int, isFirstTime: Bool = false){
        guard let tabView = tabBar.items?[index].value(forKey: "view") as? UIView else {
            return
        }
        if !isFirstTime && frameView != nil {
            frameView.removeFromSuperview()
        }

        frameView = UIView(
            frame: CGRect(
                x: tabView.frame.midX - 20,
                y: tabView.frame.minY - 3,
                width: 40,
                height: 40
            )
        )
        frameView.backgroundColor = UIColor.Habitute.primaryDark
        frameView.layer.cornerRadius = 10
        frameView.layer.zPosition = -1
        tabBar.addSubview(frameView)
    }
}

extension HabitudeTabBar: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        //addTabbarIndicatorView(index: self.selectedIndex)
    }
}
