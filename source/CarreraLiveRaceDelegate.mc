import Toybox.Lang;
import Toybox.WatchUi;

class CarreraLiveRaceDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() {
        return self.onMenu();
    }
    function onMenu() as Boolean {
        try {
            var menu = new WatchUi.Menu2({:title => "Slots"});

            for (var i = 0; i < 6; i++) {
                menu.addItem(new MenuItem(
                    "Fahrer " + (i + 1),
                    "Slot" + (i + 1),
                    "slot_" + (i + 1),
                    {}
                ));
            }


            WatchUi.pushView(menu, new CarreraLiveRaceMenuDelegate(), WatchUi.SLIDE_UP);
            return true;
        } catch (ex) {
            System.println(ex);
            return true;
        }
    }
}