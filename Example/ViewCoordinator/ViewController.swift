import UIKit
import ViewCoordinator

class ViewController: UIViewController, ViewCoordinatorProtocol {
	
	enum ExampleMode {
		case single
		case stack
	}
	
	private var viewCoordinator:ViewCoordinator? = nil
	private var mode:ExampleMode? = nil
	
	required init(withMode mode: ExampleMode) {
		super.init(nibName: nil, bundle: nil)
		viewCoordinator = ViewCoordinator(attachedToParentViewController: self)
		viewCoordinator?.delegate = self 
		self.mode = mode
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		 addButton()
		
		if let _mode = mode {
			switch _mode {
			case .single:
				    singleViewManipulation()
			case .stack:
				    stackOfViewsManipulations()
			}
		}
		
		
	}
	
	private func addButton() {
		let showButton = UIButton(frame: CGRect(x: view.frame.midX / 2, y: 0, width: 200, height: 40))
		showButton.backgroundColor = .black
		showButton.frame.origin.y  = view.center.y
		showButton.setTitle("Press Me", for: .normal)
		view.addSubview(showButton)
		showButton.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
	}
	
	
	/*
	   Present and Dismissing a Single UIView
	*/
	
	private func singleViewManipulation() {
		let _view = UIView(frame: view.frame)
		let tag = "SingleViewTag"
		//_view.accessibilityIdentifier = tag
		_view.backgroundColor = .red
		_view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnGesture(gesture:))))
	    viewCoordinator?.addMultipleViewsToStack([ ViewWrapper(view: _view, uid: tag)])
	}
	
	
	/*
	     Present and Dismissing a multiples UIViews
	*/
	
	private func stackOfViewsManipulations() {
		let colors:[UIColor]  = [.blue, .purple, .orange, .green]
		var wrappers = [ViewWrapper]()
		for i in 0...3 {
			let _view = UIView(frame: view.frame)
			_view.backgroundColor = colors[i]
			_view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnGesture(gesture:))))
			wrappers.append(ViewWrapper(view: _view, uid: "view#\(i)" ))
		}
		viewCoordinator?.addMultipleViewsToStack(wrappers)
	}
	
	
	//MARK:- GestureRecognizer
	@objc func didTapOnGesture(gesture:UIGestureRecognizer) {
		
		if let tag = gesture.view?.accessibilityIdentifier {
			switch tag {
				case "SingleViewTag":
					viewCoordinator?.dismissTopView()
				case "view#0":
					viewCoordinator?.presentAll()
				case "view#1":
					break;
				case "view#2":
					//	viewCoordinator?.popUntilRootWrapper()
					viewCoordinator?.dismissAll()
				case "view#3":
					viewCoordinator?.singlePop()
				default:
					break
			}
		}
		
	}
	
	//MARK:- Button TargetAction
	@objc func didTapButton(sender:UIButton) {
		viewCoordinator?.presentTopView()
	}
	
	// MARK:-  ViewCoordinatorProtocol
	func currentlyPresentedWrapper(_ wrapper:ViewWrapper) {
		print("info of current presented wrapper \(wrapper)")
	}

	func numberOfWrappersCurrentlyInContainer(_ wrappers: [ViewWrapper]?) {
		print("# of wrappers into the coordinator containers \(wrappers?.count ?? 0)" )
	}
	
	
}


