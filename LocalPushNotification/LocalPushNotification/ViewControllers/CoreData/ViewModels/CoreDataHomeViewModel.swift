//
//  HomeCoreDataViewModel.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 10/06/2022.
//

import CoreData

final class CoreDataViewModel {
    /// MARK: Constructor
    init() {
        getExistingTasks()
    }

    /// MARK: Properties
    private(set) var taskList = [TaskModel]()

    private(set) var taskManagedObjectList = [NSManagedObject]()

    var currentTaskList: [TaskModel] {
        get {
            return taskList
        }
    }

    var reloadTaskList: (() -> ())?

    /// MARK: Functions
    final func scrollToIndexIfNeeded() -> Bool {
        return !taskList.isEmpty
    }

    final func indexPathForScrolling(_ showingKeyboard: Bool) -> IndexPath {
        if showingKeyboard {
            return IndexPath(row: taskList.count - 1,
                             section: 0)
        } else {
            return IndexPath(row: 0,
                             section: 0)
        }
    }

    final func taskName(at index: Int) -> String {
        return currentTaskList[index].name
    }

    final func taskCreatedDate(at index: Int) -> String {
        return "Created Date: \(currentTaskList[index].createdDate.formattedDate(.type3))"
    }

    final func saveNewTask(_ task: String?) {
        guard let task = task else { return }

        let tempTask = task.isEmpty ? "Anonymous task :]]" : task

        let now = Date()

        let newTask = TaskEntity(context: CoreDataManager.shared.managedContext())

        newTask.setValue(tempTask,
                         forKey: TaskEntityKeyName.name.rawValue)

        newTask.setValue(now,
                         forKey: TaskEntityKeyName.createdDate.rawValue)

        CoreDataManager.shared.saveContext()

        taskManagedObjectList.append(newTask)

        taskList.append(TaskModel(name: tempTask,
                                  createdDate: now))

        reloadTaskList?()
    }

    final func deleteExistingTask(at indexPath: IndexPath) {
        let index = indexPath.row

        CoreDataManager.shared.deleteObject(taskManagedObjectList[index])

        taskList.remove(at: index)

        reloadTaskList?()
    }

    final func getExistingTasks() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: EntityName.Task.rawValue)

        guard let savedTasks = CoreDataManager.shared.fetchRequest(fetchRequest) as? [NSManagedObject]
        else { return }

        taskManagedObjectList = savedTasks

        taskList = savedTasks.map({ managedObject in
            let name = (managedObject.value(forKey: TaskEntityKeyName.name.rawValue) as? String) ?? "Unknown"
            let createdDate = (managedObject.value(forKey: TaskEntityKeyName.createdDate.rawValue) as? Date) ?? Date()

            return TaskModel(name: name,
                             createdDate: createdDate)
        })
    }

}
