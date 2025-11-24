pragma Singleton
import QtQuick
import Quickshell
import qs.core.models

Singleton {

    property list<TodoItem> todoList: []


    function addTodoItem(name, strikeout = false) {
        const comp = Qt.createComponent("../models/TodoItem.qml")
        if (comp.status === Component.Ready) {
            const item = comp.createObject(null, {
                name: name,
                strikeout: strikeout
            })

            todoList.push(item);
        }
    }

    function deleteTodoItem(item: TodoItem): void {
        if (!item) { return }

        const index = todoList.indexOf(item);

        if (index === -1) { return; }
        
        todoList.splice(index, 1)
        
    }

    function toggleStrikeout(item: TodoItem): void {
        if (!item) { return }

        item.strikeout = !item.strikeout

        /*
        const index = todoList.indexOf(item);

        if (index === -1) { return }

        todoList[index].strikeout = !todoList[index].strikeout
        */
    }



    Component.onCompleted: {
        addTodoItem("test1", false)
        addTodoItem("test2", false)
        addTodoItem("test3", false)
        addTodoItem("test4", false)
        addTodoItem("test5", false)
        addTodoItem("test6", false)
        toggleStrikeout(todoList[0])
        console.log("todolist: ", todoList.length)
    }
}

