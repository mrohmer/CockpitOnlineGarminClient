import Toybox.Lang;
import Toybox.WatchUi;

class CarreraLiveDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new CarreraLiveMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}