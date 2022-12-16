import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Communications;
import Toybox.Lang;
import Toybox.Application.Properties;
import Toybox.Timer;

class CarreraLiveRaceNotifier {
    private var notified = false;

    function notify(skipVibration as Lang.Boolean) {
        if (notified) {
            return;
        }

        notified = true;
        System.println("[vibration] notify");

        if (!skipVibration && Attention has :vibrate) {
            Attention.vibrate([
                new Attention.VibeProfile(50, 2000), // On for two seconds
                new Attention.VibeProfile(0, 2000),  // Off for two seconds
                new Attention.VibeProfile(50, 2000), // On for two seconds
                new Attention.VibeProfile(0, 2000),  // Off for two seconds
                new Attention.VibeProfile(50, 2000)  // on for two seconds
            ]);
        }
    }
    function reset() {
        if (!notified) {
            return;
        }
        notified = false;
        System.println("[vibration] reset");
    }
}
