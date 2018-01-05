library state;

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'state.g.dart';

enum Controls {
  commit,
  reset,
  rever,
  undo,
  redo,
}

abstract class AppActions extends ReduxActions {
  ActionDispatcher<Change> onChange;

  ActionDispatcher<Null> commit;
  ActionDispatcher<Null> reset;
  ActionDispatcher<Null> revert;
  ActionDispatcher<Null> undo;
  ActionDispatcher<Null> redo;

  ActionDispatcher<Change> selectChange;

  AppActions._();
  factory AppActions() => new _$AppActions();
}

abstract class App implements Built<App, AppBuilder> {
  App._();
  factory App(Built initialState) => new _$App((b) => b
    ..initialState = initialState
    ..commitedState = initialState);

  Built get initialState;

  Built get commitedState;

  BuiltSet<Change> get uncommitedChanges;

  BuiltSet<Change> get redoStack;

  @nullable
  Change get selectedChange;

  @memoized
  Map<Object, Object> get currentStateMap => selectedChange == null
      ? _builtToMap(uncommitedChanges.length == 0
          ? initialState
          : uncommitedChanges.last.state)
      : _builtToMap(selectedChange.state);
}

class Change {
  final Action action;
  final Built state;
  Change(this.action, this.state);
}

final appReducer = (new ReducerBuilder<App, AppBuilder>()
      ..add(AppActionsNames.onChange, _onChange)
      ..add(AppActionsNames.commit, _commit)
      ..add(AppActionsNames.reset, _reset)
      ..add(AppActionsNames.revert, _revert)
      ..add(AppActionsNames.selectChange, _selectChange)
      ..add(AppActionsNames.undo, _undo)
      ..add(AppActionsNames.redo, _redo))
    .build();

void _onChange(App state, Action<Change> action, AppBuilder builder) {
  if (action.payload.action.name == 'replaceState') return;

  if (state.uncommitedChanges.isEmpty ||
      state.selectedChange == state.uncommitedChanges.last)
    builder.selectedChange = action.payload;

  builder
    ..uncommitedChanges.add(action.payload)
    ..redoStack = new SetBuilder<Change>();
}

void _commit(App state, Action<Null> action, AppBuilder builder) {
  builder
    ..commitedState = state.uncommitedChanges.last.state
    ..uncommitedChanges.clear()
    ..redoStack = new SetBuilder<Change>();
}

void _reset(App state, Action<Null> action, AppBuilder builder) {
  builder
    ..uncommitedChanges.clear()
    ..redoStack = new SetBuilder<Change>();
}

void _revert(App state, Action<Null> action, AppBuilder builder) {
  builder
    ..uncommitedChanges.clear()
    ..commitedState = state.initialState
    ..redoStack = new SetBuilder<Change>();
}

void _selectChange(App state, Action<Change> action, AppBuilder builder) {
  builder.selectedChange = action.payload;
}

void _undo(App state, Action<Null> action, AppBuilder builder) {
  final undoneChange = state.uncommitedChanges.last;

  // if the undone change was selected make the new 'last change' selected
  if (state.selectedChange == undoneChange &&
      state.uncommitedChanges.length > 1)
    builder.selectedChange =
        state.uncommitedChanges.elementAt(state.uncommitedChanges.length - 2);

  builder
    ..uncommitedChanges.remove(undoneChange)
    ..redoStack.add(undoneChange);
}

void _redo(App state, Action<Null> action, AppBuilder builder) {
  final undoneChange = state.redoStack.last;

  // if the most recent change was selected make the undone change selected
  if (state.uncommitedChanges.isEmpty ||
      state.selectedChange == state.uncommitedChanges.last)
    builder.selectedChange = undoneChange;

  builder
    ..redoStack.remove(undoneChange)
    ..uncommitedChanges.add(undoneChange);
}

Map<Object, Object> _builtToMap(Object built) {
  // Save the current newBuiltValueToStringHelper so we can restore it on
  // return.
  final previousNewBuiltValueToStringHelper = newBuiltValueToStringHelper;

  // Create a ToStringHelper that will capture values instead of converting
  // them to String.
  final capturingToStringHelper = new _CapturingToStringHelper();
  newBuiltValueToStringHelper = (String className) {
    // Store the class name in the map, so we check types as well as fields
    // and values.
    capturingToStringHelper.map[r'$class'] = className;
    return capturingToStringHelper;
  };

  // Call toString() on the value to do capture.
  built.toString();

  // Reset to what it was on method entry.
  newBuiltValueToStringHelper = previousNewBuiltValueToStringHelper;
  return capturingToStringHelper.map;
}

/// Captures values in a Map instead of converting to a String.
class _CapturingToStringHelper implements BuiltValueToStringHelper {
  final Map<Object, Object> map = <Object, Object>{};

  @override
  void add(Object field, Object value) {
    if (value is Built) {
      map[field] = _builtToMap(value);
    } else if (value is BuiltMap) {
      map[field] = new Map<Object, Object>.fromIterables(
        value.keys,
        value.values
            .map((dynamic v) => _isBuilt(value) ? _builtToMap(value) : value),
      );
    } else if (value is Iterable) {
      map[field] = value.length > 0 && _isBuilt(value.first)
          ? value.map(_builtToMap)
          : value;
    } else {
      map[field] = value;
    }
  }
}

bool _isBuilt(Object v) => v is Built || v is Iterable || v is BuiltMap;
