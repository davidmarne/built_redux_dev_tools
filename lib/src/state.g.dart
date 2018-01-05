// GENERATED CODE - DO NOT MODIFY BY HAND

part of state;

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

class _$App extends App {
  @override
  final Built initialState;
  @override
  final Built commitedState;
  @override
  final BuiltSet<Change> uncommitedChanges;
  @override
  final BuiltSet<Change> redoStack;
  @override
  final Change selectedChange;
  Map<Object, Object> __currentStateMap;

  factory _$App([void updates(AppBuilder b)]) =>
      (new AppBuilder()..update(updates)).build();

  _$App._(
      {this.initialState,
      this.commitedState,
      this.uncommitedChanges,
      this.redoStack,
      this.selectedChange})
      : super._() {
    if (initialState == null) throw new ArgumentError.notNull('initialState');
    if (commitedState == null) throw new ArgumentError.notNull('commitedState');
    if (uncommitedChanges == null)
      throw new ArgumentError.notNull('uncommitedChanges');
    if (redoStack == null) throw new ArgumentError.notNull('redoStack');
  }

  @override
  Map<Object, Object> get currentStateMap =>
      __currentStateMap ??= super.currentStateMap;

  @override
  App rebuild(void updates(AppBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AppBuilder toBuilder() => new AppBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! App) return false;
    return initialState == other.initialState &&
        commitedState == other.commitedState &&
        uncommitedChanges == other.uncommitedChanges &&
        redoStack == other.redoStack &&
        selectedChange == other.selectedChange;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, initialState.hashCode), commitedState.hashCode),
                uncommitedChanges.hashCode),
            redoStack.hashCode),
        selectedChange.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('App')
          ..add('initialState', initialState)
          ..add('commitedState', commitedState)
          ..add('uncommitedChanges', uncommitedChanges)
          ..add('redoStack', redoStack)
          ..add('selectedChange', selectedChange))
        .toString();
  }
}

class AppBuilder implements Builder<App, AppBuilder> {
  _$App _$v;

  Built _initialState;
  Built get initialState => _$this._initialState;
  set initialState(Built initialState) => _$this._initialState = initialState;

  Built _commitedState;
  Built get commitedState => _$this._commitedState;
  set commitedState(Built commitedState) =>
      _$this._commitedState = commitedState;

  SetBuilder<Change> _uncommitedChanges;
  SetBuilder<Change> get uncommitedChanges =>
      _$this._uncommitedChanges ??= new SetBuilder<Change>();
  set uncommitedChanges(SetBuilder<Change> uncommitedChanges) =>
      _$this._uncommitedChanges = uncommitedChanges;

  SetBuilder<Change> _redoStack;
  SetBuilder<Change> get redoStack =>
      _$this._redoStack ??= new SetBuilder<Change>();
  set redoStack(SetBuilder<Change> redoStack) => _$this._redoStack = redoStack;

  Change _selectedChange;
  Change get selectedChange => _$this._selectedChange;
  set selectedChange(Change selectedChange) =>
      _$this._selectedChange = selectedChange;

  AppBuilder();

  AppBuilder get _$this {
    if (_$v != null) {
      _initialState = _$v.initialState;
      _commitedState = _$v.commitedState;
      _uncommitedChanges = _$v.uncommitedChanges?.toBuilder();
      _redoStack = _$v.redoStack?.toBuilder();
      _selectedChange = _$v.selectedChange;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(App other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$App;
  }

  @override
  void update(void updates(AppBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$App build() {
    final _$result = _$v ??
        new _$App._(
            initialState: initialState,
            commitedState: commitedState,
            uncommitedChanges: uncommitedChanges?.build(),
            redoStack: redoStack?.build(),
            selectedChange: selectedChange);
    replace(_$result);
    return _$result;
  }
}

// **************************************************************************
// Generator: BuiltReduxGenerator
// **************************************************************************

class _$AppActions extends AppActions {
  factory _$AppActions() => new _$AppActions._();
  _$AppActions._() : super._();

  final ActionDispatcher<Change> onChange =
      new ActionDispatcher<Change>('AppActions-onChange');
  final ActionDispatcher<Null> commit =
      new ActionDispatcher<Null>('AppActions-commit');
  final ActionDispatcher<Null> reset =
      new ActionDispatcher<Null>('AppActions-reset');
  final ActionDispatcher<Null> revert =
      new ActionDispatcher<Null>('AppActions-revert');
  final ActionDispatcher<Null> undo =
      new ActionDispatcher<Null>('AppActions-undo');
  final ActionDispatcher<Null> redo =
      new ActionDispatcher<Null>('AppActions-redo');
  final ActionDispatcher<Change> selectChange =
      new ActionDispatcher<Change>('AppActions-selectChange');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    onChange.setDispatcher(dispatcher);
    commit.setDispatcher(dispatcher);
    reset.setDispatcher(dispatcher);
    revert.setDispatcher(dispatcher);
    undo.setDispatcher(dispatcher);
    redo.setDispatcher(dispatcher);
    selectChange.setDispatcher(dispatcher);
  }
}

class AppActionsNames {
  static final ActionName<Change> onChange =
      new ActionName<Change>('AppActions-onChange');
  static final ActionName<Null> commit =
      new ActionName<Null>('AppActions-commit');
  static final ActionName<Null> reset =
      new ActionName<Null>('AppActions-reset');
  static final ActionName<Null> revert =
      new ActionName<Null>('AppActions-revert');
  static final ActionName<Null> undo = new ActionName<Null>('AppActions-undo');
  static final ActionName<Null> redo = new ActionName<Null>('AppActions-redo');
  static final ActionName<Change> selectChange =
      new ActionName<Change>('AppActions-selectChange');
}
