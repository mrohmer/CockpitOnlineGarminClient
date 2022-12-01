import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Communications;
import Toybox.Lang;
import Toybox.Application.Properties;
import Toybox.Timer;

class CarreraLiveRaceView extends WatchUi.View {

    private var page = 0;
    private var data as Lang.Dictionary or Null;
    private var timer as Timer.Timer or Null;
    private var loading = true;
    private var progressbar as WatchUi.ProgressBar or Null;
    private var error as Lang.Number or Null;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.RaceLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        paint();
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
        if (timer != null) {
            timer.stop();
        }
    }

    function handleSettingsUpdate() {
        loading = true;
        self.makeRequest();
    }
    function handlePageChange(diff as Number) {
        page = calcPage(diff, getSlots().size());
        paint();
    }
    private function getSlots() as Lang.Array {
        if (data != null and data.hasKey("slots") and data.get("slots") != null) {
            return data.get("slots") as Lang.Array;
        }
        return [];
    }
    private function calcPage(diff as Number, maxPages as Number) as Number {
        var p = page + diff;
        if (p < 0) {
            p = maxPages - 1;
        } else if (p >= maxPages) {
            p = 0;
        }

        return p;
    }

    private function paint() {
        if (loading) {
            if (progressbar == null) {
                progressbar = new WatchUi.ProgressBar(
                    "lädt...",
                    null
                );
                WatchUi.pushView(progressbar, null, WatchUi.SLIDE_DOWN);
            }
            return;
        }

        setVisible("error", error != null);
        setVisible("position", error == null);
        setVisible("name", error == null);
        setVisible("car", error == null);
        setVisible("gas", error == null);

        var errorEl = View.findDrawableById("error") as WatchUi.Text;
        errorEl.setVisible(error != null);
        
        if (progressbar != null) {
            WatchUi.popView(WatchUi.SLIDE_UP);
            progressbar = null;
            // todo remove progressbar
        }

        if (getSlots().size() > 0) {
            paintSlot();
        }

        WatchUi.requestUpdate();
    }
    private function paintSlot() {
        var slot = getSlots()[page] as Lang.Dictionary;

        var car = slot.get("car") as Lang.Dictionary;

        setText("position", slot.get("position") + ".");
        setText("name", slot.get("name"));
        setText("car", car.get("name"));

        var gas = ((slot.get("remainingGas") as Lang.Float) * 100) as Lang.Number;
        var gasEl = View.findDrawableById("gas") as GasDrawable;
        gasEl.setPercentage(gas);
    }

    private function setText(id as String, text as String or Null) {
        if (text == null) {
            text = "";
        }

        var el = View.findDrawableById(id) as WatchUi.Text;
        el.setText(text);
    }
    private function setVisible(id as String, visible as Boolean) {
        var el = View.findDrawableById(id) as WatchUi.Drawable;
        el.setVisible(visible);
    }

    function timerCallback() as Void {
        timer = null;
        makeRequest();
    }

    // set up the response callback function
    function onResponseReceive(responseCode as Number, _data as Null or Lang.Dictionary or Lang.String) as Void {
        if (responseCode == 200) {
            System.println("Request Successful");                   // print success
            System.println(_data);
            loading = false;
            error = null;
            data = _data.get("data");
            handlePageChange(0);
            paint();

            scheduleFetch(1);
        } else {
            System.println("Response Code: " + responseCode);            // print response code
            data = null;
            error = responseCode;
            page = 0;

            paint();

            scheduleFetch(5);
        }
    }

    function makeRequest() as Void {

        var sessionName = Properties.getValue("sessionName");
        var url = "https://carrera-live.rohmer.rocks/api/sessions/";

        var options = {                                             // set the options
            :method => Communications.HTTP_REQUEST_METHOD_GET,      // set HTTP method
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
        };

        Communications.makeWebRequest(url + sessionName, null, options, method(:onResponseReceive));
    }

    function scheduleFetch(sec as Lang.Number) {
        if (timer != null) {
            timer.stop();
        }
        timer = new Timer.Timer();
        timer.start(method(:timerCallback), sec * 1000, false);
    }
}
