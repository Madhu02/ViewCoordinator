import Foundation
import UIKit

///Wrapper is just a struct that add uid to your UIView
public struct ViewWrapper {
	let view:UIView
	let uid:String
	
	public init(view:UIView, uid:String) {
		self.view = view
		self.uid = uid
		self.view.accessibilityIdentifier = uid
	}
}

public protocol ViewCoordinatorProtocol: class  {
	func currentlyPresentedWrapper(_ wrapper:ViewWrapper)
}


/// dont' forget to subscribe to ViewRecyclerProtocol
final public class ViewCoordinator {
	private  let parent:UIViewController!
	
	private  var wrapperContainer:[ViewWrapper] {
		didSet {
			if !wrapperContainer.isEmpty {
				rootWrapper = wrapperContainer.first
				hasRootWrapper = true
			} else {
				rootWrapper = nil
				hasRootWrapper = false
			}
		}
		
	}
	
	//private var previous:ViewWrapper?  { return wrapperContainer.last }
	
	private var isEmpty : Bool { return wrapperContainer.isEmpty }
	
	
	// optimize with binary tree instead
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
	
	
	public func presentTopView() {
		 if let first = rootWrapper {
				presentViewWrapperBy(uid: first.uid)
		}
	}
	
	public func dismissTopView() {
		if let first = rootWrapper {
			dismissViewWrapperBy(uid: first.uid)
		}
	}

	
	/// passing the uid of the wrapper that you wish
	/// to present
	public func presentViewWrapperBy(uid:String) {
		if isEmpty != true {
			perform(action: .display, with: uid)
		}
	}
	
	///Would present each wrapper from containers
	/// on top of each other like stack onto your parent
	public func presentAllWrappersOnScreen() {
		if isEmpty != true  {
			UIView.animate(withDuration: 0.5) { [weak self] in
				guard let strongSelf = self else { return	}
				strongSelf.wrapperContainer.forEach { strongSelf.addSubViewToParent($0.view) }
			}
		}
	}
	

	
	/// passing the uid of the wrapper that you wish
	/// to remove from parent controller
	public func dismissViewWrapperBy(uid:String) {
		if isEmpty != true {
			perform(action: .remove, with: uid)
		}
	}
	
	///Would remove each wrapper from containers
	/// that were on screen
	public func dismissAllWrappersOnScreen() {
		if isEmpty != true {
			UIView.animate(withDuration: 0.5) { [weak self] in
				guard let strongSelf = self else { return	}
				strongSelf.wrapperContainer.forEach { strongSelf.removeViewFromParent($0.view) }
			}
		}
	}
	
	
	///Get the list of uid from your recycler
	
	public func listAllUIDs() -> [String] {
		return wrapperContainer.map {  $0.uid }
	}
	
	
	//TODO: flip between screens
	//TODO: go back to from init scree

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
	
	
	deinit {
		dismissAllWrappersOnScreen()
		//parent.view = nil 
	}
	
}

