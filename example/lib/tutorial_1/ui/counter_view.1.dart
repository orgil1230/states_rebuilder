import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:states_rebuilder_demo/tutorial_1/logic/counter_model.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

final model = CounterModel();

class CounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StateBuilder(
      viewModels: [model],
      builder: (context, _) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("${model.counter}"),
                  RaisedButton(
                    child: Text("Increment"),
                    onPressed: model.increment,
                  ),
                  Divider(),
                  Expanded(
                    child: Markdown(data: _firstExample),
                  )
                ],
              ),
            ),
          ),
    );
  }
}

//
final String _firstExample = """
## counter_model.dart file:

class CounterModel extends __StatesRebuilder__ { // (1)
  int _counter = 0;
  int get counter => _counter;

  increment() {
    _counter++;
    __rebuildStates()__;  // (2)
  }
}

## counter_view.dart file:

__final model = CounterModel();__ // (3)

class CounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return __StateBuilder__(// (4)
      __viewModels: [model],__ // (5)
      __builder: (context, -)__ => Scaffold( // (6)
            appBar: AppBar(),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  __Text("\${model.counter}"),__
                  MaterialButton(
                    child: Text("Increment"),
                    __onPressed: model.increment,__
                  ),
                ],
              ),
            ),
          ),
    );
  }
}

- (1) : Any class that extends `StatesRebuilder` is called viewModel in the context of Model–view–viewModel (MVVM) pattern.
- (2) : _rebuild widgets subscribed to this viewModel object_
- (3) : _globally instantiate `CounterModel`. Very bad. Do not use it!_
- (4) : _StateBuilder is used to subscribe widgets. Subscription means adding to listeners list. The same widget can subscribe to many viewMode_
- (5) : _This widget will be subscribed to the `model` object._
- (6) : _This `Scaffold` widget is subscribed. When `rebuildState()` is called from the `model` object this `Scaffold` and its children will rebuild._ 

""";

// class CounterView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Injector(
//       models: [() => CounterModel()],
//       builder: (context, _) {
//         final model = Injector.get<CounterModel>();
//         return StateBuilder(
//           viewModels: [model],
//           builder: (context, _) => Scaffold(
//                 appBar: AppBar(),
//                 body: Center(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Text("${model.counter}"),
//                       MaterialButton(
//                         child: Text("Increment"),
//                         onPressed: model.increment,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//         );
//       },
//     );
//   }
// }

// class CounterView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Injector<CounterModel>(
//       models: [() => CounterModel()],
//       builder: (context, model) => Scaffold(
//             appBar: AppBar(),
//             body: Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Text("${model.counter}"),
//                   MaterialButton(
//                     child: Text("Increment"),
//                     onPressed: model.increment,
//                   )
//                 ],
//               ),
//             ),
//           ),
//     );
//   }
// }