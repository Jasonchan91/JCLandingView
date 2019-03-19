//
//  JCLandingViewCell.swift
//  JCLandingView
//
//  Created by Jason Chan on 25/1/19.
//

import UIKit

class JCLandingViewCell: UITableViewCell {
    
    public private (set)var landingContentViews: [UIView]?
    
    init(landingContentViews: [UIView]?) {
        super.init(style: .default, reuseIdentifier: nil)
        selectionStyle = .none
        guard let views = landingContentViews else { return }
        self.landingContentViews = views
        contentView.subviews.forEach{ $0.removeFromSuperview() }
        views.forEach {
            $0.loading = $0.loading
        }
        configureCell(withViews: views)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSeparator(withView view: UIView) {
        if view.landingViewSeparatorIsHidden || landingViewSeparatorIsHidden {
            separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
        } else if view.landingViewSeparatorInset != .zero {
            separatorInset = view.landingViewSeparatorInset
        } else {
            separatorInset = landingViewSeparatorInset
        }
    }
    
    private func configureCell(withViews views: [UIView]) {
        
        guard !views.isEmpty else { return }
        
        if views.count == 1 {
            views[0].loading = views[0].loading
            configureCell(withView: views[0])
            configureSeparator(withView: views[0])
            return
        }
        
        let topInset: CGFloat = views.map{ $0.landingViewContentInset.top }.max() ?? 0
        let bottomInset: CGFloat = views.map{ $0.landingViewContentInset.bottom}.max() ?? 0
        let horizontalInset: CGFloat = getTotalHorizontalInset(oflandingSubviews: views)
        
        let totalDefinedContentRatio = views.reduce(into: CGFloat()) { (result, view) in
            switch view.landingViewContentSize.width {
            case .ratio(let ratio):
                result += ratio
            default:
                break
            }
        }
        
        var currentSubview: UIView?
        if let firstView = views.first {
            backgroundColor = firstView.landingViewBackgroundColor
        }
        views.forEach {
            contentView.addSubview($0)
            configureSeparator(withView: $0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            var leading, top, trailing, bottom: NSLayoutConstraint?
            
            let contentSize = $0.landingViewContentSize
            
            
            switch contentSize.width {
            case .auto:
                break
            case .value(let width):
                $0.widthAnchor.constraint(equalToConstant: width).isActive = true
                break
            case .ratio(let ratio):
                $0.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: totalDefinedContentRatio > 1 ? ratio / totalDefinedContentRatio : ratio, constant: -(horizontalInset/CGFloat(views.count))).isActive = true
                break
            }
            
            switch contentSize.height {
            case .auto:
                break
            case .value(let height):
                $0.heightAnchor.constraint(equalToConstant: height).isActive = true
                break
            case .ratio(_):
                break
            }
            
            if let currentView = currentSubview {
                leading = $0.leadingAnchor.constraint(equalTo: currentView.trailingAnchor, constant: (currentView.landingViewContentInset.right + $0.landingViewContentInset.left))
            } else {
                // this is the first subview
                
                leading = $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: $0.landingViewContentInset.left)
            }
            
            if let lastView = views.last, $0 == lastView {
                trailing = $0.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -$0.landingViewContentInset.right)
            }
            
            top = $0.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: topInset)
            bottom = $0.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -bottomInset)
            
            
            [top, bottom, leading].forEach {
                if let constraint = $0 {
                    constraint.priority = UILayoutPriority(999)
                    constraint.isActive = true
                }
            }
            [trailing].forEach {
                if let constraint = $0 {
                    constraint.priority = UILayoutPriority(998)
                    constraint.isActive = true
                }
            }
            
            if $0.landingViewContentInset.top == 0 && $0.landingViewContentInset.bottom == 0 {
                let centerY = $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
                [centerY].forEach {
                    $0.priority = UILayoutPriority(997)
                    $0.isActive = true
                }
            }
            
            currentSubview = $0
        }
        
    }
    
    private func getTotalHorizontalInset(oflandingSubviews views: [UIView]) -> CGFloat {
        return views.reduce(into: 0, { (result, view) in
            result += (view.landingViewContentInset.left + view.landingViewContentInset.right)
        })
    }
    
    private func configureCell(withView view: UIView) {
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = view.landingViewBackgroundColor
        let totalHorizontalInset = getTotalHorizontalInset(oflandingSubviews: [view])
        let contentSize = view.landingViewContentSize
        
        
        
        switch contentSize.width {
        case .auto:
            let leading = view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: view.landingViewContentInset.left)
            let trailing = view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -view.landingViewContentInset.right)
            
            [leading, trailing].forEach {
                $0.priority = UILayoutPriority(999)
                $0.isActive = true
            }
            break
        case .value(let width):
            view.widthAnchor.constraint(equalToConstant: width).isActive = true
            break
        case .ratio(let ratio):
            view.widthAnchor.constraint(greaterThanOrEqualTo: contentView.widthAnchor, multiplier: ratio, constant: -totalHorizontalInset).isActive = true
            break
        }
        
        switch contentSize.height {
        case .auto:
            break
        case .value(let height):
            view.heightAnchor.constraint(equalToConstant: height).isActive = true
        case .ratio(_):
            break
        }
        
        
        let top = view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: view.landingViewContentInset.top)
        let bottom = view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -view.landingViewContentInset.bottom)
        
        [top, bottom].forEach {
            $0.priority = UILayoutPriority(999)
            $0.isActive = true
        }
        
        if view.landingViewContentInset.top == 0 && view.landingViewContentInset.bottom == 0 {
            let centerY = view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
            [centerY].forEach {
                $0.priority = UILayoutPriority(997)
                $0.isActive = true
            }
            
        }
        
        switch view.landingViewContentHorizontalAlignment {
        case .center:
            view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        case .left:
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: view.landingViewContentInset.left).isActive = true
            break
        case .right:
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -view.landingViewContentInset.right).isActive = true
        }
    }
}
