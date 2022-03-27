import UIKit
import CoreData

class NotesTableViewController: UITableViewController {

	var notes = [Notes]()

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		let context = appDelegate.persistentContainer.viewContext

		let fetchRequest = Notes.fetchRequest() as NSFetchRequest<Notes>

		let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
		fetchRequest.sortDescriptors = [sortDescriptor]

		do {notes = try context.fetch(fetchRequest) } catch let error {
		print("Не удалось загрузить данные из-за ошибки: \(error).") }
		tableView.reloadData()
	}


	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return notes.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "noteCellIdentifier", for: indexPath)
		let note = notes[indexPath.row]

		let name = note.name ?? ""
		let content = note.content ?? ""

		cell.textLabel?.text = name 

		cell.detailTextLabel?.text = content
		return cell
	}

	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}


	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

		  if notes.count > indexPath.row {
			let note = notes[indexPath.row]
			let appDelegate = UIApplication.shared.delegate as! AppDelegate
			let context = appDelegate.persistentContainer.viewContext
			context.delete(note)
			notes.remove(at: indexPath.row)
			do {
				try context.save()
			} catch let error {
				print("Не удалось сохранить из-за ошибки \(error).")
			}
			tableView.deleteRows(at:[indexPath],with: .fade)
		}
	}

}

