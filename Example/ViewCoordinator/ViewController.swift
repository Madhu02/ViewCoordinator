import UIKit
import ViewCoordinator

class ViewController: UIViewController, ViewCoordinatorProtocol {
	
	var viewCoordinator:ViewCoordinator? = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		
		
		let showButton = UIButton(frame: CGRect(x: view.frame.midX / 2, y: 0, width: 200, height: 40))
		showButton.backgroundColor = .black
		showButton.frame.origin.y  = view.center.y
		showButton.setTitle("Press Me", for: .normal)
		view.addSubview(showButton)
		showButton.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
		
		viewCoordinator = ViewCoordinator(attachedToParentViewController: self)
		
		actualTest()
		
	}
	
	func actualTest() {
		let colors:[UIColor]  = [.blue, .purple, .orange, .green]
		var wrappers = [ViewWrapper]()
		for i in 0...3 {
			let _view = UIView(frame: view.frame)
			let tag:String = "view#\(i)"
			_view.backgroundColor = colors[i]
			_view.accessibilityIdentifier = tag
			_view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnGesture(gesture:))))
			wrappers.append(ViewWrapper(view: _view, uid:tag ))
		}
		viewCoordinator?.addMultipleViewsToStack(wrappers)
	}
	
	
	
	@objc func didTapOnGesture(gesture:UIGestureRecognizer) {
		//		viewCoordinator?.dismissTopView()
		//viewCoordinator?.presentViewWrapperBy(uid: "secondView")
		
		let viewAssociated = gesture.view
		
		// present all
		if let tag = viewAssociated?.accessibilityIdentifier {
			switch tag {
			case "view#0":
				viewCoordinator?.presentAllWrappersOnScreen()
			case "view#1":
				break;
			case "view#2":
				//	viewCoordinator?.popUntilRootWrapper()
				viewCoordinator?.dismissAllWrappersOnScreen()
			case "view#3":
				viewCoordinator?.singlePop()
			default:
				break
			}
		}
		
	}
	
	@objc func didTapButton(sender:UIButton) {
		viewCoordinator?.presentTopView()
	}
	
}


