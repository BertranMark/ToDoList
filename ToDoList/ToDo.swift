//
//  ToDo.swift
//  ToDoList
//
//  Created by Bertran on 22.10.2018.
//  Copyright © 2018 Bertran. All rights reserved.
//

import Foundation

struct ToDo: Codable {
    
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var note: String?
    
    
    static func loadToDos() -> [ ToDo ]? {
       
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let file_url = dir.appendingPathComponent("todosavefile").appendingPathExtension("plist")
        let dec = PropertyListDecoder()
        if let data = try? Data(contentsOf: file_url), let decodedTodos = try? dec.decode(Array<ToDo>.self, from: data) {
            return decodedTodos
        }
        else {
            return nil
        }
    }
    
    static func saveToDos(from: [ToDo]) {
        let enc = PropertyListEncoder()
        let codeDate = try? enc.encode(from)
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let file_url = dir.appendingPathComponent("todosavefile").appendingPathExtension("plist")
        try? codeDate?.write(to: file_url, options: .noFileProtection)
        
        
    }
    
    static func LoadSampleToDos() -> [ToDo]? {
        return [
            ToDo(title: "Дело 1", isComplete: false, dueDate: Date(), note: "Заметка 1"),
            ToDo(title: "Дело 2", isComplete: false, dueDate: Date(), note: "Заметка 2"),
            ToDo(title: "Дело 3", isComplete: false, dueDate: Date(), note: "Заметка 3"),
            ToDo(title: "Дело 4", isComplete: false, dueDate: Date(), note: "Заметка 4"),
        ]
        
    }
    
    static let DueDateFormatte : DateFormatter = {
        let form = DateFormatter()
        form.dateStyle = .short
        form.timeStyle = .short
        return form
        
    }()
    
}
