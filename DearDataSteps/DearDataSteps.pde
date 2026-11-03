// I logged each count against its date.
String[] dates = {
  "2026-11-02",
  "2026-11-01",
  "2026-10-31",
  "2026-10-30",
  "2026-10-29"
};
int[] stepCounts = { 13755, 5686, 3085, 4099, 12642 };

final int CHART_TOP = 190;
final int CHART_BOTTOM = 465;
final int CHART_LEFT = 115;
final int CHART_RIGHT = 805;

void setup() {
  size(920, 620);
  smooth(4);
  textFont(createFont("SansSerif", 16));
}

void draw() {
  background(247, 242, 231);

  fill(36, 51, 57);
  textAlign(LEFT, BASELINE);
  textSize(14);
  text("DEAR DATA", 72, 62);
  textSize(34);
  text("Daily steps", 72, 108);

  int scaleMaximum = 20000;
  for (int i = 0; i < stepCounts.length; i++) {
    if (stepCounts[i] > scaleMaximum) {
      scaleMaximum = ((stepCounts[i] + 4999) / 5000) * 5000;
    }
  }

  textSize(12);
  stroke(213, 207, 191);
  strokeWeight(1);
  for (int tick = 0; tick <= 4; tick++) {
    float fraction = tick / 4.0;
    float y = CHART_BOTTOM - fraction * (CHART_BOTTOM - CHART_TOP);
    int label = round(scaleMaximum * fraction);
    line(CHART_LEFT, y, CHART_RIGHT, y);
    noStroke();
    fill(91, 103, 101);
    textAlign(RIGHT, CENTER);
    text(label, CHART_LEFT - 14, y);
    stroke(213, 207, 191);
  }

  float slotWidth = (CHART_RIGHT - CHART_LEFT) / (float) dates.length;
  float barWidth = min(100, slotWidth * 0.55);
  for (int i = 0; i < stepCounts.length; i++) {
    float x = CHART_LEFT + slotWidth * (i + 0.5);
    float barHeight = barHeightFor(stepCounts[i], scaleMaximum);

    noStroke();
    fill(207, 91, 59);
    rect(x - barWidth / 2, CHART_BOTTOM - barHeight,
         barWidth, barHeight, 12);

    fill(36, 51, 57);
    textAlign(CENTER, BOTTOM);
    textSize(15);
    text(nf(stepCounts[i]), x, CHART_BOTTOM - barHeight - 10);

    fill(91, 103, 101);
    textSize(12);
    textAlign(CENTER, TOP);
    text(dates[i], x, CHART_BOTTOM + 12);
  }

  fill(91, 103, 101);
  textAlign(LEFT, BASELINE);
  textSize(13);
  text(dates.length + " days recorded", 72, 555);
}

// I turn a step count into a bar height.
float barHeightFor(int steps, int scaleMaximum) {
  return map(steps, 0, scaleMaximum, 0, CHART_BOTTOM - CHART_TOP);
}
