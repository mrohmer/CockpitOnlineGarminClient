import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Communications;
import Toybox.Lang;

class CarreraLiveRaceView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        self.makeRequest();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // set up the response callback function
    function onReceive(responseCode as Number, data as Null or Lang.Dictionary or Lang.String) as Void {
        if (responseCode == 200) {
            System.println("Request Successful");                   // print success
        } else {
            System.println("Response: " + responseCode);            // print response code
        }
    }

    function makeRequest() as Void {
        var url = "https://carrera-live.rohmer.rocks/api/sessions/cma22";

        var options = {                                             // set the options
            :method => Communications.HTTP_REQUEST_METHOD_GET,      // set HTTP method
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
        };

        // onReceive() method
        // Make the Communications.makeWebRequest() call
        Communications.makeWebRequest(url, null, options, method(:onReceive));
    }
}
