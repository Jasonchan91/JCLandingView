//
//  UIView+Extension.swift
//  JCLandingView
//
//  Created by Jason Chan on 11/12/18.
//

import UIKit

extension UIView {
    
    private struct AssociatedKeys {
        static var LandingViewContentInsetDescriptiveName = "landing_view_content_inset_nsh_DescriptiveName"
        static var LandingViewContentSizeDescriptiveName = "landing_view_content_size_nsh_DescriptiveName"
        static var LandingViewContentSeparatorDescriptiveName = "landing_view_content_separator_nsh_DescriptiveName"
        static var LandingViewContentAlignmentDescriptiveName = "landing_view_content_alignment_nsh_DescriptiveName"
        static var LandingViewContentBackgroundColorDescriptiveName = "landing_view_content_background_color_nsh_DescriptiveName"
        static var LandingViewContentSeparatorInsetDescriptiveName = "landing_view_content_separator_inset_nsh_DescriptiveName"
        static var LoadingDescriptiveName = "loading_nsh_DescriptiveName"
        static var LoadingViewDescriptiveName = "loading_view_nsh_DescriptiveName"
    }
    
    @objc public var landingViewContentInset: UIEdgeInsets {
        get {
            guard let inset = objc_getAssociatedObject(self, &AssociatedKeys.LandingViewContentInsetDescriptiveName) as? UIEdgeInsets else { return .zero }
            return inset
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.LandingViewContentInsetDescriptiveName,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var landingViewContentSize: JCSize {
        get {
            guard let size = objc_getAssociatedObject(self, &AssociatedKeys.LandingViewContentSizeDescriptiveName) as? JCSize else { return JCSize(width: .auto, height: .auto) }
            return size
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.LandingViewContentSizeDescriptiveName,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var landingViewContentHorizontalAlignment: JCLandingContentAlignment{
        get {
            guard let alignment = objc_getAssociatedObject(self, &AssociatedKeys.LandingViewContentAlignmentDescriptiveName) as? JCLandingContentAlignment else { return .center }
            return alignment
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.LandingViewContentAlignmentDescriptiveName,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var landingViewSeparatorInset: UIEdgeInsets {
        get {
            guard let inset = objc_getAssociatedObject(self, &AssociatedKeys.LandingViewContentSeparatorInsetDescriptiveName) as? UIEdgeInsets else { return .zero }
            return inset
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.LandingViewContentSeparatorInsetDescriptiveName,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var landingViewSeparatorIsHidden: Bool {
        get {
            guard let isHidden = objc_getAssociatedObject(self, &AssociatedKeys.LandingViewContentSeparatorDescriptiveName) as? Bool else { return false }
            return isHidden
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.LandingViewContentSeparatorDescriptiveName,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var landingViewBackgroundColor: UIColor {
        get {
            guard let color = objc_getAssociatedObject(self, &AssociatedKeys.LandingViewContentBackgroundColorDescriptiveName) as? UIColor else { return UIColor.white }
            return color
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.LandingViewContentBackgroundColorDescriptiveName,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    @objc public var loading: Bool {
        get {
            guard let isLoading = objc_getAssociatedObject(self, &AssociatedKeys.LoadingDescriptiveName) as? Bool else { return false }
            return isLoading
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.LoadingDescriptiveName,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            updateLoadingView(shouldShow: newValue)
        }
    }
    
    private func updateLoadingView(shouldShow: Bool) {
        if shouldShow {
            loadingView.startAnimating()
            addSubview(loadingView)
            loadingView.isHidden = false
            
            if let superview = loadingView.superview {
                loadingView.backgroundColor = superview.backgroundColor
                loadingView.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
                loadingView.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
                
            }
        } else {
            UIView.transition(with: self,
                              duration: 0.35,
                              options: .transitionCrossDissolve,
                              animations: { [weak self] in
                                self?.loadingView.removeFromSuperview()
                }, completion: nil)
        }
    }
    
    private var loadingView: UIActivityIndicatorView {
        
        if let view = objc_getAssociatedObject(self, &AssociatedKeys.LoadingViewDescriptiveName) as? UIActivityIndicatorView {
            return view
        } else {
            let loadingView = UIActivityIndicatorView(style: .gray)
            loadingView.hidesWhenStopped = true
            loadingView.clipsToBounds = true
            loadingView.stopAnimating()
            loadingView.translatesAutoresizingMaskIntoConstraints = false
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.LoadingViewDescriptiveName,
                                     loadingView,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return loadingView
        }
    }
    
}
