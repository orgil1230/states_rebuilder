## 1.11.2 (2020-01-10)
* Add the static method `StatesRebuilderDebug.printInjectedModel()` to debugPrint all registered model in the service locator.
* Add the static method `StatesRebuilderDebug.printObservers(observable)` to )debugPrint all subscribed observers to the provided observable.
* Refactor watch logic to work with asynchronous tasks as well as with List, Map, Set types.

## 1.11.1 (2020-01-05)
* Add `onData(BuildContext, T)` parameter to `setState` method.
  It is a shortcut to:
  ```dart
  onSetState(context){
    if(reactiveModel.hasData){
      .....
    }
  }
  ```

## 1.11.0 (2020-01-05)
* `Inject.get` for injected streams and future will no longer throw, it will return the the current value.
* If `whenConnectionState` is defined, `catchError` is set true automatically.
* Add `watch` parameter to `StateBuilder` widget and. `watch` allows to link the rebuild process to the variation of a set of variables.(Experimental feature).
* Remove deprecated `getAsModel` and `hasState`.
* Update docs and add Dependency Injection section in the readme file.

## 1.10.0 (2019-12-30)
* Add `whenConnectionState` method to the `ReactiveModel`. IT exhaustively switch over all the possible statuses of `connectionState`. Used mostly to return a Widget. (Pul request of [ResoCoder](https://resocoder.com/2019/12/30/states-rebuilder-zero-boilerplate-flutter-state-management/)).

## 1.9.0 (2019-12-28)
* Add assertion error helpful messages.
* Add `isIdle` getter to the `ReactiveModel` as a shortcut to :
 `connectionState == ConnectionState.none`
* Add `isWaiting` getter to the `ReactiveModel` as a shortcut to :
 `connectionState == ConnectionState.waiting`
* Add `onError(BuildContext, dynamic)` parameter to `setState` method.
* Add `joinSingletonToNewData` parameter to `setState` method.
* Refactor codes to remove bugs and to use Flutter 1.12 version.

## 1.8.0 (2019-12-06)
1- Add the following features: (See readme fille).
*  `onSetState` and  `onRebuildState` parameters to the `StateBuilder`.
* The BuildContext is the default tag of `StateBuilder`.
* `JoinSingleton`, `inheritedInject`, `initialCustomStateStatus` parameters to `Inject`
* `reinject` and `getAsReactive` to `Injector`.
2- Remove the following parameters:(Breaking changes)
*  `tagID` parameter from `StateBuilder`.
before
```dart
StateBuilder(
  builder: (BuildContext context, String tagID){
    // code
  }
)
```
after
```dart
StateBuilder<T>(
  models: [firstModel, secondModel],
  builder: (BuildContext context, ReactiveModel<T> model){
    /// No more need for the `tagID` because the `context` is used as `tagID`.
    /// the model is the first instance (firstModel) in the list of the [models] parameter.
    /// If the parameter [models] is not provided then the model will be a new reactive instance
    /// See readme file for more information
  }
)
```
* The model parameter of the `Injector.builder` method.
before
```dart
Injector(
  builder: (BuildContext context, T model){
    // code
  }
)
```

after
```dart
Injector(
  builder: (BuildContext context){
    // no need for model parameter. It has less boilerplate.
  }
)
```
* `Injector.getAsModel`, `StateBuilder.viewModel` and `StatesRebuilder.hasState` are deprecated, and replaced by `Injector.getAsReactive`, `StateBuilder.models` and `StatesRebuilder.hasObservers` respectively.

## 1.7.0 (2019-11-14)
1- Add `onSetState` parameter to the `setState` method to define a callback to be executed after state mutation.
  The callBack takes the context so you can push/pop routes, show dialogs or snackBar. (see example folder).  

2- Add `catchError` parameter to the `setState` method to define whether to catch error while mutining the state or not.(see example folder). If an error is thrown, `hasError` getter is true and the error can be obtained via the `error` getter (see point 5 below).   

3- Add the getter `connectionState` to the `ModelStatesRebuilder<T>`to get the asynchronous status of the state. it can be `ConnectionState.none` before executing the Future, `ConnectionState.waiting` while waiting for the Future and `ConnectionState.done` after resolving the Future.    

4- Add the field `stateStatus` to the `ModelStatesRebuilder<T>` class. It allows defining a custom status of the state other than those defined by the `connectionState`  getter.    

5- add the getter `hasError`, `hasData` and `error` to the `ModelStatesRebuilder<T>` class.     

6- Change the name `blocs` to `models`.   

7- Refactor the code and fix bugs.

8- Update docs and examples.


## 1.6.1 (2019-10-22)
* Add `watch` parameter to `setState` method and `Inject.stream` constructor. `watch` allows to link the rebuild process to the variation of a set of variables.
* Update docs

## 1.6.0+1 (2019-10-18)
* Add `Injector.getAsModel` method. When called with the context parameter, the calling widget is automatically registered as a listener.
* Add `setState(Function(state))` to mutate the state and update the dependent the views from the UI.
* Model class have not to extend `StatesRebuilder` to get reactivity.
* Add the named constructor`Inject.future` which take a future and update dependents when future completes.
* Add the named constructor`Inject.stream` which take a steam and update dependents when stream emits a value.
* `Injector.get` or `Injector.getAsModel` now throws if no registered model is found. This can be silent by setting the parameter `silent` to true
* Injected model ara lazily instantiated. To do otherwise set the parameter `isLazy` of the `Inject` widget to false.


## 1.5.1 (2019-09-14)
* add `afterInitialBuild` and `afterRebuild` parameters to the `StateBuilder`, `StateWithMixinBuilder` and `Injector` widgets.`
  `afterInitialBuild` and `afterRebuild` are callBack to be executed after the widget is mounted and after each rebuild. 

## 1.5.0+1 (2019-09-12)
* Use `ObservableService` and `hasState` instead of `Observable` and `hasObserver`, because the latters are widely used and can lead to conflict


## 1.5.0 (2019-09-06)
* Add `hasStates` getter to check if the StatesRebuilder object has listener.
* Add `inject` parameter to the `Injector` widget as an alternative to the `models` parameter. With `inject` you can register models using interface Type. 
* Add `observable` interface. Any service class can implement it to notify any ViewModel to rebuild its corresponding view.
* Refactor the library to make it design patterns wise and hence make it testable.
* Test the library

## 1.3.2 (2019-06-24)
* Add `appLifeCycle` argument to Injector to track the life cycle of the app.
* Refactor the code.


## 1.3.1 (2019-06-13)
* remove `rebuildFromStreams`.
* Initial release of `Streaming` class
* The builder closure of the `Injector` takes (BuildContext context, T model) where T is the generic type.
* Fix typos

## 1.3.0 (2019-06-04)
* Initial release of `rebuildFromStreams` method.
* Initial release of `Injector` for Dependency Injection.
* deprecate blocs parameter and use viewModels instead
* StateBuilder can have many tags.

## 1.2.0 (2019-05-23)
 *  Remove `stateID` and replace it by `tag` parameter. `tag` is optional and many widgets can have the same tag.
 *  `rebuildStates()` when called without parameters, it rebuilds all widgets that are wrapped with `StateBuilder` and `StateWithMixinBuilder`.
 *  Each `StateBuilder` has an automatically generated cached address. It is stored in the second parameter of the `builder`, `initState`, `dispose`,  and other closures. You can call it inside the closures to rebuild that particular widget.
 *  add `StateWithMixinBuilder` widget to account for some of the most used mixins.
 *  Optimize the code and improve performance

## 1.1.0 (2019-05-13)
 * Add `withTickerProvider` parameter to `StateBuilder` widget.


## 1.0.0 (2019-05-12)
 * Add `BlocProvider`to provide your BloCs.
 * You can use enums to name your `StateBuilder` widgets.
 * `rebuildStates` now has only one positioned parameter of List<dynamic>.
 * If `rebuildStates` is given without parameter, it will rebuild all widgets that have `stateID`.
 * improve performance.


## 0.1.4

  * improve performance


## 0.1.3

  * Add getter and setter for the stateMap.

## 0.1.2

  * Remove print statements

## 0.1.1

  * Change readme.md of the example

## 0.1.0

  * Initial version
