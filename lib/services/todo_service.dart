import 'package:hive_flutter/adapters.dart';
import 'package:note_nest_application/models/todo_model.dart';

class TodoService {
  List<TodoModel> todos = [
    TodoModel(
      title: "Playing a Game",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    TodoModel(
      title: "Watching a Movie",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    TodoModel(
      title: "Riding a Bike",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
  ];
  //Datebase reference for Todo
  final _myBox = Hive.box('todos');

  //Check weather the user is NewUser
  Future<bool> isNewUser() async{
    return _myBox.isEmpty; 
  }
  //If user is new Create initial todos
  Future<void> createInitialTodos() async{
    if(_myBox.isEmpty){
        await _myBox.put('todos', todos);
    }
  }
  //Load the Todos
  Future<List<TodoModel>> loadTodos() async{
    final dynamic todos = await _myBox.get('todos');
    if(todos != null && todos is List<dynamic>){
        return todos.cast<TodoModel>().toList();
    }
    return [];
  }

}
