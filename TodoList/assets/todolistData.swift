//
//  todolistData.swift
//  TodoList
//
//  Created by seobe22 on 11/14/23.
//

import Foundation

struct TodoListData {
    let id: Int
    let title: String
    let description: String
    let completed: Bool = false
}

let todoListData: [TodoListData] = [
  {
    "id": 1,
    "title": "Grocery shopping",
    "description": "Buy milk, eggs, bread, and cheese.",
    "completed": false
  },
  {
    "id": 2,
    "title": "iOS Project",
    "description": "Work on the SwiftUI to-do list app.",
    "completed": false
  },
  {
    "id": 3,
    "title": "Read SwiftUI Documentation",
    "description": "Read the latest SwiftUI tutorials on Apple's developer website.",
    "completed": false
  },
  {
    "id": 4,
    "title": "Fitness",
    "description": "Go for a 30-minute run in the park.",
    "completed": true
  },
  {
    "id": 5,
    "title": "Book Club",
    "description": "Finish reading 'The Midnight Library' for the book club meeting.",
    "completed": true
  },
  {
    "id": 6,
    "title": "Laundry",
    "description": "Wash and fold clothes for the upcoming week.",
    "completed": false
  },
  {
    "id": 7,
    "title": "Weekly Planning",
    "description": "Plan out the work schedule for the next week, set goals and priorities.",
    "completed": false
  },
  {
    "id": 8,
    "title": "Gardening",
    "description": "Plant new flower seeds in the garden and water the plants.",
    "completed": false
  },
  {
    "id": 9,
    "title": "Learn Guitar",
    "description": "Practice guitar chords for at least 20 minutes.",
    "completed": true
  },
  {
    "id": 10,
    "title": "Call Parents",
    "description": "Have a catch-up call with mom and dad.",
    "completed": true
  }
]
