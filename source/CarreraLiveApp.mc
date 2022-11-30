import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class CarreraLiveApp extends Application.AppBase {
    private var _mainView;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        _mainView = new CarreraLiveRaceView();

        return [ self._mainView, new CarreraLiveRaceDelegate(_mainView) ] as Array<Views or InputDelegates>;
    }

    function onSettingsChanged() {
        _mainView.handleSettingsUpdate();
        WatchUi.requestUpdate();
    }

}

function getApp() as CarreraLiveApp {
    return Application.getApp() as CarreraLiveApp;
}