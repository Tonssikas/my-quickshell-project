pragma Singleton
import QtQuick
import Quickshell
import qs.core.model

Singleton {

    property var todoList: []


    function addTodoItem(name, strikeout = false) {
        todoList.push({
            name: name,
            strikeout: strikeout
        });
    }

    function deleteTodoItem(item): void {
        if (!item) { return }

        const index = todoList.indexOf(item);

        if (index === -1) { return; }
        
        todoList.splice(index, 1)
        
    }

    function toggleStrikeout(item): void {
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

