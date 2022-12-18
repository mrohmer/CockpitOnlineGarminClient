import Toybox.Lang;
import Toybox.WatchUi;

class SessionDelegate extends WatchUi.BehaviorDelegate {
    private var view as SessionView;

    function initialize(_view as SessionView) {
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