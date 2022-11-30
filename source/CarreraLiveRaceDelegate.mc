import Toybox.Lang;
import Toybox.WatchUi;

class CarreraLiveRaceDelegate extends WatchUi.BehaviorDelegate {
    private var view as CarreraLiveRaceView;

    function initialize(_view as CarreraLiveRaceView) {
        BehaviorDelegate.initialize();
        view = _view;
    }

    function onNextPage() as Boolean {
        System.println("next page");
        view.handlePageChange(1);
        return true;
    }
    function onPreviousPage() as Boolean {
        System.println("previous page");
        view.handlePageChange(-1);
        return true;
    }
}