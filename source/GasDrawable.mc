import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Math;

class GasDrawable extends WatchUi.Drawable {
    private var percentage = 0;

    function initialize(settings as { :identifier as Lang.Object, :locX as Lang.Numeric, :locY as Lang.Numeric, :width as Lang.Numeric, :height as Lang.Numeric, :visible as Lang.Boolean }) {
        Drawable.initialize(settings);
    }

    function draw(dc as Dc) as Void {
        if (!isVisible) {
            return;
        }
        drawBorder(dc);
        drawPercentageOverlay(dc);
    }

    function setPercentage(_percentage as Lang.Number) {
        percentage = _percentage;
    }

    private function getRadius(dc as Dc) as Lang.Float {
        if (dc.getWidth() < dc.getHeight()) {
            return dc.getWidth().toFloat() / 2.0;
        }
        return dc.getHeight().toFloat() / 2.0;
    }
    private function getColor() as Lang.Number {
        if (percentage <= 20) {
            return Graphics.COLOR_RED;
        }
        if (percentage <= 50) {
            return Graphics.COLOR_YELLOW;
        }
        return Graphics.COLOR_GREEN;
    }

    private function drawBorder(dc as Dc) {
        dc.setColor(getColor(), Graphics.COLOR_BLACK);
        dc.setPenWidth(20);
        dc.drawCircle(dc.getWidth() / 2, dc.getHeight() / 2, getRadius(dc));
    }
    private function drawPercentageOverlay(dc as Dc) {
        if (percentage == 100) {
            return;
        }
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);

        dc.setPenWidth(20);
        dc.drawArc(dc.getWidth() / 2, dc.getHeight() / 2, getRadius(dc), Graphics.ARC_COUNTER_CLOCKWISE, 90, 90 + 360 - percentage.toFloat() * 3.60);       
    }
}