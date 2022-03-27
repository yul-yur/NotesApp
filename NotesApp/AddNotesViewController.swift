import UIKit
import CoreData


class AddNotesViewController: UIViewController {

	//@IBOutlet var nameField: UITextField!
	@IBOutlet var nameField: UITextField!
	@IBOutlet var contentTextField: UITextField!
	//@IBOutlet var contentTextField: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func saveTapped(_ sender: UIBarButtonItem) {
		let name = nameField.text ?? ""
		let content = contentTextField.text ?? ""

		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		let context = appDelegate.persistentContainer.viewContext

		let newNote = Notes(context: context)
		newNote.name = name
		newNote.content = content

		newNote.noteId = UUID().uuidString
		if let uniqueId = newNote.noteId {
			print("noteId: \(uniqueId)")
		}
		do{
			try context.save()
		} catch let error {
			print("Не удалось сохранить из-за ошибки \(error).")

		}

		dismiss(animated: true, completion: nil)
	}

	@IBAction func cancelTapped(_ sender: UIBarButtonItem) {
		dismiss(animated: true, completion: nil)
	}

}


