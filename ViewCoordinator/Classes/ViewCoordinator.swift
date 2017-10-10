
import Foundation
import UIKit

/*
Todo:
- handling views on rotation
- handling autolayouts
- adding test
*/



///Wrapper is just a struct that add uid to your UIView
public struct ViewWrapper {
	public let view:UIView
	public let uid:String
	
	public init(view:UIView, uid:String) {
		self.view = view
		self.uid = uid
		self.view.accessibilityIdentifier = uid
	}
}

public protocol ViewCoordinatorProtocol: class  {
	func currentlyPresentedWrapper(_ wrapper:ViewWrapper)
	func numberOfWrappersCurrentlyInContainer(_ wrappers: [ViewWrapper]?)
}

///ViewCoordinator is an elegant way to present and dismiss your UIViews onto
/// a UIViewController.
/// All you need to do is wrapped any views that you wish to display inside a ViewWrapper, which takes few metadata such as UID to reference to that particular View. Then you take that array of ViewWrappers then drop it into the ViewCoordinator's container. Simple as that, and also
/// dont' forget to subscribe to ViewRecyclerProtocol.
final public class ViewCoordinator {
	private  var parent:UIViewController?
	
	//Todo: optimize with BST instead
	private  var wrapperContainer:[ViewWrapper] {
		didSet {
			if !wrapperContainer.isEmpty {
				rootWrapper = wrapperContainer.first
				hasRootWrapper = true
				delegate?.numberOfWrappersCurrentlyInContainer(wrapperContainer)
			} else {
				rootWrapper = nil
				hasRootWrapper = false
				delegate?.numberOfWrappersCurrentlyInContainer(nil)
			}
		}
		
	}
	
	// TODO: what if we wan't to swap current with previous
	//private var previousWrapper:ViewWrapper? = nil
	
	private var isEmpty : Bool { return wrapperContainer.isEmpty }
	
	
	public weak var delegate:ViewCoordinatorProtocol? = nil
	
	public var hasRootWrapper:Bool = false
	
	/// the wrapper that is at the root
	private var rootWrapper:ViewWrapper? = nil
	
	/// the wrapper that is currently presented into screen
	private var presentedWrapper:ViewWrapper? = nil {
		didSet {
			if presentedWrapper != nil, let presented = presentedWrapper {
				delegate?.currentlyPresentedWrapper(presented)
			}
		}
	}
	
	required public init(attachedToParentViewController _parent:UIViewController) {
		parent = _parent
		wrapperContainer = []
	}
	
	
	public func addMultipleViewsToStack(_ wrappers:[ViewWrapper]) {
		wrappers.forEach { wrapperContainer.append($0)  }
	}
	
	/// presentTopView: would present the first wrapper from
	/// the coordinator's container, if you wish to present a different wrapper use this method
	/// presentViewWrapperBy(uid:String)
	public func presentTopView() {
		if let first = rootWrapper {
			presentViewWrapperBy(uid: first.uid)
		}
	}
	
	/// dismissTopView: would dismiss the first wrapper from
	/// the coordinator's container, if you wish to dismiss a different wrapper use
	/// this method dismissViewWrapperBy
	public func dismissTopView() {
		if let first = rootWrapper {
			dismissViewWrapperBy(uid: first.uid)
		}
	}
	
	
	///presentViewWrapperBy: provide the associated uid of the specific wrapper
	/// that you want to display
	public func presentViewWrapperBy(uid:String) {
		if isEmpty != true {
			perform(action: .display, with: uid)
		}
	}
	
	///presentAll: would display all wrappers on top of each like a stack
	public func presentAll() {
		if isEmpty != true  {
			wrapperContainer.forEach { presentViewWrapperBy(uid: $0.uid) }
		}
	}
	
	
	
	/// passing the uid of the wrapper that you wish
	/// to remove from parent controller
	public func dismissViewWrapperBy(uid:String) {
		if isEmpty != true {
			perform(action: .remove, with: uid)
		}
	}
	
	///dismissAll: would remove all wrappers from screens
	/// including the root wrapper, if you don't wish to
	/// remove the root wrapper use this popUntilRootWrapper()
	public func dismissAll() {
		if isEmpty != true {
			wrapperContainer.forEach { dismissViewWrapperBy(uid: $0.uid) }
		}
	}
	
	
	///Get the list of uid from your recycler
	
	public func listAllUIDs() -> [String] {
		return wrapperContainer.map {  $0.uid }
	}
	
	
	//TODO: flip between screens
	//TODO: go back to from init screen
	
	public func popUntilRootWrapper() {
		if isEmpty != true {
			var uids = wrapperContainer.map { $0.uid }
			// remove first wrapper
			uids.removeFirst()
			_ = uids.map { perform(action: .remove, with: $0) }
		}
	}
	
	public func singlePop() {
		// check view position in the list
		if isEmpty != true {
			if let last = wrapperContainer.last {
				perform(action: .remove, with: last.uid)
			}
		}
	}
	
	
	private enum Actions {
		case remove
		case display
	}
	
	private func lookForWrapperWith(uid:String) -> ViewWrapper? {
		return wrapperContainer.filter ({ $0.uid == uid }).first
	}
	
	private func perform(action:Actions, with uid:String) {
		let duration: TimeInterval = 0.5
		guard let selectedWrapper = lookForWrapperWith(uid: uid) else {   return	}
		
		switch action {
		case .display:
			presentedWrapper = selectedWrapper
			UIView.animate(withDuration: duration) { [weak self] in
				guard let strongSelf = self else { return }
				strongSelf.addSubViewToParent(selectedWrapper.view)
			}
		case .remove:
			UIView.animate(withDuration: duration) { [weak self] in
				guard let strongSelf = self else { return }
				strongSelf.removeViewFromParent(selectedWrapper.view)
			}
		}
	}
	
	
	private func addSubViewToParent(_ view:UIView) {
		parent?.view.addSubview(view)
	}
	
	private func removeViewFromParent(_ view:UIView) {
		view.removeFromSuperview()
	}
	
	///Should remove all the wrappers into the ViewCoordinator's Container
	public func clear() {
		wrapperContainer.removeAll()
	}
	
	deinit {
		dismissAll()
		clear()
		rootWrapper = nil
		presentedWrapper = nil
		delegate = nil
		parent = nil
	}
	
}

