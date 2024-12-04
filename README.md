# CoreFlow

CoreFlow is a lightweight and modular state management library built using Flutter's **InheritedWidget**.

---

## **Features**

1. **Define and Manage State**
    - CoreFlow allows you to define a state object (e.g., a class or primitive) and wrap it in the `CoreFlow` widget.

2. **Notify Listeners on State Change**
    - It automatically rebuilds dependent widgets when the state changes, thanks to Flutter's `InheritedWidget` mechanism.

3. **Efficient State Propagation**
    - Only widgets that depend on the state are notified and rebuilt, ensuring performance and scalability.

---

## **How It Works**

### **Define a State**
Create a class to represent your application's state:

```dart
class CounterState {
  int counter;

  CounterState(this.counter);
}
```

---

### **Wrap Your Widget Tree**
Use `CoreFlow` to manage your state:

```dart
class CoreFlow<T> extends InheritedWidget {
  final T state;
  final void Function(T newState) update;

  CoreFlow({
    required this.state,
    required this.update,
    required Widget child,
  }) : super(child: child);

  static CoreFlow<T> of<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CoreFlow<T>>()!;
  }

  @override
  bool updateShouldNotify(CoreFlow<T> oldWidget) {
    return oldWidget.state != state;
  }
}
```

---

### **Update and Access State**
#### Update the State:
```dart
CoreFlow.of<CounterState>(context).update(
  CounterState(newCounterValue),
);
```

#### Access the State:
```dart
final counterState = CoreFlow.of<CounterState>(context).state;
final counterValue = counterState.counter;
```

---

## **Assignment Questions Answered**

### 1. **A Way to Define and Manage a Single State Object**
In CoreFlow, the state is defined as a generic object (`T`), allowing developers to use any type—simple variables, objects, or complex classes. The state is passed as an argument to the `CoreFlow` widget, making it flexible and reusable.

---

### 2. **A Mechanism to Notify Listeners When the State Changes**
CoreFlow leverages Flutter's `InheritedWidget`. When the state is updated using the `update` method, the `CoreFlow` widget rebuilds, and widgets dependent on the state are notified through the `updateShouldNotify` method. This mechanism ensures a reactive UI without manual listener management.

---

### 3. **Efficiently Propagate Changes in the Widget Tree**
The `updateShouldNotify` method in `InheritedWidget` ensures that only widgets that depend on the state are rebuilt. This minimizes unnecessary rebuilds, making state propagation efficient and keeping the app performant.

---

## **Scope for Improvement**

While the current implementation of CoreFlow is effective, there are areas for enhancement:

1. **Scoped Listeners**:  
   Currently, all widgets that depend on `CoreFlow` are notified of changes. Introducing **selectors** can help notify only specific parts of the state, reducing unnecessary widget rebuilds.

2. **Multiple States**:  
   Managing multiple states requires nesting multiple `CoreFlow` widgets. A better approach could involve a state registry or multi-state manager for cleaner architecture.
---

## **Usage Example**

Here's how you can use CoreFlow to create a simple Counter App:

```dart
void main() {
  runApp(
    CoreFlow<CounterState>(
      state: CounterState(0),
      update: (newState) => setState(() => state = newState),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('CoreFlow Counter')),
        body: CounterScreen(),
      ),
    );
  }
}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterState = CoreFlow.of<CounterState>(context).state;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Counter: ${counterState.counter}'),
          ElevatedButton(
            onPressed: () {
              CoreFlow.of<CounterState>(context).update(
                CounterState(counterState.counter + 1),
              );
            },
            child: Text('Increment'),
          ),
        ],
      ),
    );
  }
}
```

---