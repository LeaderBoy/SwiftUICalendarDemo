//
//  PageViewController.swift
//  SwiftUICalendar
//
//  Created by 杨志远 on 2020/3/21.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import SwiftUI
import UIKit

struct PageViewController: UIViewControllerRepresentable {
    var controllers: [UIViewController]
    
    @ObservedObject var pageManager : PageManager
    
    var currentPage: Int {
        return pageManager.currentPage
    }
    
    var direction : UIPageViewController.NavigationDirection {
        return pageManager.direction
    }

//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
//        pageViewController.delegate = context.coordinator
//        pageManager.onPageChange = {(page,direction) in
//            if page >= self.controllers.count || page < 0  {
//                print("Warning ⚠️ : page beyond index of range" )
//                return
//            }
//            pageViewController.setViewControllers([self.controllers[page]], direction: direction, animated: true)
//        }
        return pageViewController
    }

    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers([controllers[currentPage]], direction: direction, animated: true)
    }

//    class Coordinator: NSObject, UIPageViewControllerDelegate {
//        var parent: PageViewController
//
//        init(_ pageViewController: PageViewController) {
//            self.parent = pageViewController
//        }
//    }
}
