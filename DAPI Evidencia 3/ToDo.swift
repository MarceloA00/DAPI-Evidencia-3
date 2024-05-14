//
//  ToDo.swift
//  DAPI Evidencia 3
//
//  Created by Alumno on 06/05/24.
//

import Foundation

struct ToDo : Equatable, Codable {
    let id : UUID
    var title : String
    var isComplete : Bool
    var dueDate : Date
    var notes : String?
    
    static let documentsDirectory =
       FileManager.default.urls(for: .documentDirectory,
       in: .userDomainMask).first!
    static let archiveURL =
       documentsDirectory.appendingPathComponent("toDos")
       .appendingPathExtension("plist")
    
    init(title: String, isComplete: Bool, dueDate: Date,
           notes: String?) {
        self.id = UUID()
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
    }
    
    static func ==(lhs: ToDo, rhs : ToDo) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func loadToDos() -> [ToDo]? {
        guard let codedToDos = try? Data(contentsOf: archiveURL) else
               {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self,
           from: codedToDos)
    }
    
    static func loadSampleToDos() -> [ToDo] {
        
        let toDo1 = ToDo(title: "To-Do One", isComplete: false, dueDate: Date(), notes: "Note 1")
        
        let toDo2 = ToDo(title: "To-Do Two", isComplete: false, dueDate: Date(), notes: "Note 2")
        
        let toDo3 = ToDo(title: "To-Do Three", isComplete: false, dueDate: Date(), notes: "Note 3")
        
        return [toDo1,toDo2,toDo3]
    }
    
    static func saveToDos(_ toDos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(toDos)
        try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
    }
}
