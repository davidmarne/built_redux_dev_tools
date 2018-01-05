import 'package:built_redux/built_redux.dart';
import 'state.dart';

typedef DevToolMwHandler<P>(MiddlewareApi<App, AppBuilder, AppActions> api,
    ActionHandler next, Action<P> action);

Middleware<App, AppBuilder, AppActions> stateReplacerMiddleware(Store store) =>
    (new MiddlewareBuilder<App, AppBuilder, AppActions>()
          ..add(AppActionsNames.reset, _reset(store))
          ..add(AppActionsNames.revert, _revert(store))
          ..add(AppActionsNames.undo, _undo(store))
          ..add(AppActionsNames.redo, _redo(store)))
        .build();

DevToolMwHandler<Null> _reset(Store store) =>
    (MiddlewareApi<App, AppBuilder, AppActions> api, ActionHandler next,
        Action<Null> action) {
      store.replaceState(api.state.commitedState);
      next(action);
    };

DevToolMwHandler<Null> _revert(Store store) =>
    (MiddlewareApi<App, AppBuilder, AppActions> api, ActionHandler next,
        Action<Null> action) {
      store.replaceState(api.state.initialState);
      next(action);
    };

DevToolMwHandler<Null> _undo(Store store) =>
    (MiddlewareApi<App, AppBuilder, AppActions> api, ActionHandler next,
        Action<Null> action) {
      final changes = api.state.uncommitedChanges;
      if (changes.length == 1) {
        store.replaceState(api.state.initialState);
        next(action);
      } else if (changes.length > 1) {
        store.replaceState(changes.elementAt(changes.length - 2).state);
        next(action);
      }
    };

DevToolMwHandler<Null> _redo(Store store) =>
    (MiddlewareApi<App, AppBuilder, AppActions> api, ActionHandler next,
        Action<Null> action) {
      if (api.state.redoStack.length > 0) {
        store.replaceState(api.state.redoStack
            .elementAt(api.state.redoStack.length - 1)
            .state);
        next(action);
      }
    };
