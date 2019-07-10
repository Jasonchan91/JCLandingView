//
//  JCLandingView.swift
//  JCLandingView
//
//  Created by Jason Chan on 11/12/18.
//


import UIKit
import ObjectiveC

public enum JCLandingContentAlignment {
    case left, center, right
}

public enum JCSizeType {
    case auto
    case value(CGFloat)
    case ratio(CGFloat)
}

public class JCSize: NSObject {
    let width: JCSizeType
    let height: JCSizeType
    public init(width: JCSizeType, height: JCSizeType) {
        self.width = width
        self.height = height
    }
}

public class JCLandingView: UIView {
    
    public var autoHideLastSeparator: Bool = true
    
    public override var landingViewContentInset: UIEdgeInsets {
        didSet {
            tableView.contentInset = landingViewContentInset
        }
    }
    
    public var autoHideKeyboardWhenScroll: Bool = true
    public var isScrollEnabled = true {
        didSet {
            tableView.isScrollEnabled = isScrollEnabled
        }
    }
    public var shouldObserveKeyboard = true {
        didSet {
            if !shouldObserveKeyboard {
                removeKeyboardEventsObserver()
            }
        }
    }
    public var shouldObserveOrientationChange = true {
        didSet {
            if !shouldObserveOrientationChange {
                removeOrietationChangeEventsObserver()
            }
        }
    }
    
    private var views = [[UIView]]()
    
    private var cells: [JCLandingViewCell] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        if #available(iOS 11, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(JCLandingViewCell.self, forCellReuseIdentifier: String(describing: JCLandingViewCell.self))
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isScrollEnabled = isScrollEnabled
        tableView.estimatedRowHeight = 50
        tableView.backgroundColor = backgroundColor
        tableView.separatorStyle = landingViewSeparatorIsHidden ? .none : .singleLine
        tableView.tableFooterView = UIView()
        tableView.separatorInset = landingViewSeparatorInset
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraint()
        observeKeyboardEvents()
        observeRotation()
        landingViewSeparatorInset = landingViewSeparatorIsHidden ? UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0) : landingViewSeparatorInset
    }
    
    deinit {
        removeObserver()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        [tableView].forEach { addSubview($0) }
    }
    
    private func setupConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}



// public function

extension JCLandingView {
    
    private func appendViews(_ views: [UIView] , beforeViews: [UIView], animated: Bool) {
        if let index = self.views.index(where: {$0 == beforeViews }) {
            self.views.insert(views, at: index)
            if let cell = createCell(ofViews: views) {
                self.cells.insert(cell, at: index)
            }
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: animated ? .fade : .none)
            tableView.endUpdates()
        }
    }
    
    private func appendViews(_ views: [UIView], afterViews: [UIView], animated: Bool) {
        if let index = self.views.index(where: {$0 == afterViews }) {
            self.views.insert(views, at: index + 1)
            if let cell = createCell(ofViews: views) {
                self.cells.insert(cell, at: index + 1)
            }
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: index + 1, section: 0)], with: animated ? .fade : .none)
            tableView.endUpdates()
        }
    }
    
    /* Add a single view to the top of the selected view */
    
    public func appendView(_ view: UIView, aboveView: UIView, animated: Bool = true) {
        if let index = self.views.index(where: { $0.contains(aboveView)}) {
            let targetView = self.views[index]
            appendViews([view], beforeViews: targetView, animated: animated)
        }
    }
    
    /* Add a collection of views to the top of the selected view */
    
    public func appendViews(_ views: [UIView], aboveView: UIView, animated: Bool = true) {
        if let index = self.views.index(where: { $0.contains(aboveView)}) {
            let targetView = self.views[index]
            appendViews(views, beforeViews: targetView, animated: animated)
        }
    }
    
    /* Add a single view to the bottom of the seclected view */
    
    public func appendView(_ view: UIView, belowView: UIView, animated: Bool = true) {
        if let index = self.views.index(where: { $0.contains(belowView)}) {
            let targetView = self.views[index]
            appendViews([view], afterViews: targetView, animated: animated)
        }
    }
    
    /* Add a collection of views to the bottom of the selected view */
    
    public func appendViews(_ views: [UIView], belowView: UIView, animated: Bool = true) {
        if let index = self.views.index(where: { $0.contains(belowView)}) {
            let targetView = self.views[index]
            appendViews(views, afterViews: targetView, animated: animated)
        }
    }
    
    /* Add a single view in front of the selected view */
    public func appendView(_view: UIView, beforeView: UIView) {
        if let index = self.views.index(where: { $0.contains(beforeView)}) {
            var targetView = self.views[index]
            let cell = self.cells[index]
            
        }
    }
    
    public func appendView(_ view: UIView, beforeView: UIView, animated: Bool = true) {
        if let index = self.views.index(where: { $0.contains(beforeView)}) {
            var targetView = self.views[index]
            tableView.beginUpdates()
            if let indexOfSubview = targetView.index(where: {$0 == beforeView }) {
                targetView.insert(view, at: indexOfSubview)
            }
            self.views[index] = targetView
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
            tableView.endUpdates()
        }
    }
    
    /* Add a single view behind of the selected view */
    
    public func appendView(_ view: UIView, afterView: UIView, animated: Bool = true) {
        if let index = self.views.index(where: { $0.contains(afterView)}) {
            var targetView = self.views[index]
            tableView.beginUpdates()
            if let indexOfSubview = targetView.index(where: {$0 == afterView }) {
                targetView.insert(view, at: indexOfSubview + 1)
            }
            self.views[index] = targetView
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
            tableView.endUpdates()
        }
    }
    
    /* Add a single view to the last position */
    
    public func appendView(_ view: UIView) {
        views.append([view])
        reload()
    }
    
    /* Add a collection of views to the last position */
    
    public func appendViews(_ views: [UIView]) {
        self.views.append(views)
        reload()
    }
    
    /* Force reload the whole landingView */
    
    public func reload() {
        reloadCells()
        tableView.reloadData()
    }
    
    private func reloadCells() {
        cells = []
        createCells()
    }
    
    private func createCell(ofViews views: [UIView]) -> JCLandingViewCell? {
        let cell = JCLandingViewCell(landingContentViews: views)
        cell.landingViewSeparatorInset = landingViewSeparatorInset
        return cell
    }
    
    private func createCells() {
        for view in views.enumerated() {
            if let cell = createCell(ofViews: view.element) {
                if let lastView = views.last, view.element == lastView {
                    cell.landingViewSeparatorIsHidden = autoHideLastSeparator
                }
                cells.append(cell)
            }
        }
    }
    
    /* Determind the view is exist in the landing view */
    
    public func contains(_ view: UIView) -> Bool {
        if let _ = self.views.index(where: { $0.contains(view)}) {
            return true
        }
        return false
    }
    
    /* Force reload a respective view */
    
    public func reloadView(_ view: UIView) {
        if let index = self.views.index(where: {$0 == [view] }) {
            tableView.beginUpdates()
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
            tableView.endUpdates()
        } else {
            if let index = self.views.index(where: { $0.contains(view) }) {
                tableView.beginUpdates()
                tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                tableView.endUpdates()
            }
        }
    }
    
    /* Remove a collection of views from the landing view */
    
    public func removeViews(_ views: [UIView]) {
        for view in views {
            if let index = self.views.index(where: {$0 == [view] }) {
                self.views.remove(at: index)
                self.cells.remove(at: index)
                tableView.beginUpdates()
                tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                tableView.endUpdates()
            } else {
                if let index = self.views.index(where: { $0.contains(view) }) {
                    tableView.beginUpdates()
                    var newViews = self.views[index]
                    if let indexOfSubview = newViews.index(where: {$0 == view }) {
                        newViews.remove(at: indexOfSubview)
                    }
                    self.views[index] = newViews
                    //                    tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                    tableView.endUpdates()
                }
            }
        }
    }
    
    public func removeView(_ view: UIView) {
        if let index = self.views.index(where: {$0 == [view] }) {
            self.views.remove(at: index)
            self.cells.remove(at: index)
            tableView.beginUpdates()
            tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
            tableView.endUpdates()
        } else {
            if let index = self.views.index(where: { $0.contains(view) }) {
                tableView.beginUpdates()
                var newViews = self.views[index]
                if let indexOfSubview = newViews.index(where: {$0 == view }) {
                    newViews.remove(at: indexOfSubview)
                }
                self.views[index] = newViews
                tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                tableView.endUpdates()
            }
        }
    }
}

extension JCLandingView: UITableViewDataSource, UITableViewDelegate {
    
    private func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return views.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.row]
    }
    
    private func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? JCLandingViewCell, let landingContentViews = cell.landingContentViews else { return }
        
        let textFieldsView = landingContentViews.filter { (view) -> Bool in
            if let _ = view as? UITextField {
                return true
            }
            return false
        }
        if let textField = textFieldsView.first {
            textField.becomeFirstResponder()
        }
    }
}


// MARK - UIScrollViewDelegate

extension JCLandingView: UIScrollViewDelegate {
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard autoHideKeyboardWhenScroll else { return }
        endEditing(true)
    }
}

// MARK - Keyboard Observing

extension JCLandingView {
    
    private func observeRotation() {
        NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
                                                self.rotated()
        }
    }
    
    private func observeKeyboardEvents() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(withNotification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(withNotification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeOrietationChangeEventsObserver() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIDevice.orientationDidChangeNotification,
                                                  object: nil)
    }
    
    private func removeKeyboardEventsObserver() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    private func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func rotated() {
        guard shouldObserveOrientationChange else { return }
        tableView.reloadData()
    }
    
    @objc private func keyboardWillShow(withNotification notification: Notification) {
        guard let userInfo = (notification as NSNotification).userInfo else {
            return
        }
        
        let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! Int
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size.height
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIView.AnimationCurve(rawValue: curve)!)
        UIView.setAnimationDuration(duration)
        UIView.setAnimationBeginsFromCurrentState(true)
        
        adjustTableView(withKeyboardHeight: keyboardHeight)
        UIView.commitAnimations()
    }
    
    @objc private func keyboardWillHide(withNotification notification: Notification) {
        guard let userInfo = (notification as NSNotification).userInfo else {
            return
        }
        
        let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! Int
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIView.AnimationCurve(rawValue: curve)!)
        UIView.setAnimationDuration(duration)
        UIView.setAnimationBeginsFromCurrentState(true)
        
        adjustTableView(withKeyboardHeight: 0)
        UIView.commitAnimations()
    }
    
    @objc private func dismissKeyboard() {
        tableView.endEditing(true)
    }
    
    private func adjustTableView(withKeyboardHeight keyboardHeight: CGFloat) {
        
        let bottomInset = keyboardHeight > 0 ? 0 : self.landingViewContentInset.bottom
        if keyboardHeight > 0 {
            // Adjust content offset to show first responder view in the middle of table view.
            guard let responder = UIResponder.findFirstResponder() else {
                return
            }
            if !(responder is UIView) {
                return
            }
            let responderView = responder as! UIView
            let relativeView = UIApplication.shared.keyWindow ?? self
            
            let responderViewCoordinateY = responderView.convert(CGPoint.zero, to: relativeView).y
            
            if responderViewCoordinateY > self.bounds.size.height - keyboardHeight  {
                let nextOffsetY = (responderViewCoordinateY + 22 + 22) - (self.bounds.size.height - keyboardHeight)
                tableView.contentOffset = CGPoint(x: 0, y: (tableView.contentOffset.y + nextOffsetY))
            }
        }
        tableView.contentInset = UIEdgeInsets(top: tableView.contentInset.top, left: 0, bottom: bottomInset + keyboardHeight, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
    }
}
