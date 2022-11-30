import Toybox.Lang;
import Toybox.WatchUi;

class CarreraLiveRaceDelegate extends WatchUi.BehaviorDelegate {
    private var view as CarreraLiveRaceView;

    function initialize(_view as CarreraLiveRaceView) {
        BehaviorDelegate.initialize();
        view = _view;
    }

    function onNextPage() as Boolean {
        view.handlePageChange(1);
        return true;
    }
    function onPreviousPage() as Boolean {
        view.handlePageChange(-1);
        return true;
    }
}