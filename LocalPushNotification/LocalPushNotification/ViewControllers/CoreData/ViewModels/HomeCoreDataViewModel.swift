//
//  HomeCoreDataViewModel.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 10/06/2022.
//

import CoreData

class HomeCoreDataViewModel {
    /// MARK: Constructor
    init() {
        getExistingTasks()
    }

    /// MARK: Properties
    private var taskList = [TaskModel]()

    private var taskManagedObjectList = [NSManagedObject]()

    var currentTaskList: [TaskModel] {
        get {
            return taskList
        }
    }

    var reloadTaskList: (() -> ())?

    /// MARK: Functions
    func taskName(at index: Int) -> String {
        return currentTaskList[index].name
    }

    func taskCreatedDate(at index: Int) -> String {
        return "Created Date: \(currentTaskList[index].createdDate.formattedDate(.type3))"
    }

    func saveNewTask(_ task: String?) {
        guard let task = task else { return }

        let now = Date()

        let newTask = TaskEntity(context: CoreDataManager.shared.managedContext())

        newTask.setValue(task, forKey: TaskEntityKeyName.name.rawValue)

        newTask.setValue(now, forKey: TaskEntityKeyName.createdDate.rawValue)

        CoreDataManager.shared.saveContext()

        taskManagedObjectList.append(newTask)

        taskList.append(TaskModel(name: task,
                                  createdDate: now))

        reloadTaskList?()
    }

    func deleteExistingTask(at indexPath: IndexPath) {
        let index = indexPath.row

        CoreDataManager.shared.deleteObject(taskManagedObjectList[index])

        taskList.remove(at: index)

        reloadTaskList?()
    }

    func getExistingTasks() {
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
