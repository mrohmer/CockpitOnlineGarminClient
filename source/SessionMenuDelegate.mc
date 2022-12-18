import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SessionMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as WatchUi.MenuItem) {
        System.println(item.getId());
    }
}