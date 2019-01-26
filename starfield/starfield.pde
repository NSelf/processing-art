/*--------------------*/
/*--------------------*/

//TODO: Proper commenting, spacebar to pause.

Star[] stars = new Star[100];
float cameraSpeed = 5;
float depth = 1000;
boolean showFrameRate = true;
boolean paused = false;

void setup() {
    size(800, 600);
    colorMode(HSB, 360, 100, 100);
    background(color(340, 60, 20));
    frameRate(60);
    textAlign(LEFT, TOP);

    for (int i = 0; i < stars.length; i++) {
        stars[i] = new Star(random(-width / 2, width / 2),
                            random(-height / 2, height / 2),
                            random(0, depth));
    }
}

void draw() {
    background(color(340, 60, 20));
    translate(width / 2, height / 2);

    //Stars are sorted by z (depth) for occlusion by render order.
    java.util.Arrays.sort(stars);

    for (int i = 0; i < stars.length; i++) {
        stars[i].update();
        stars[i].show();
    }

    if (showFrameRate) {
        fill(0, 0, 0);
        text(frameRate, -width / 2, -height / 2);
    }
}

/*--------------------*/

public class Star implements Comparable<Star>{
    protected PVector p;
    protected float r;

    public Star(float x, float y, float z) {
        p =  new PVector(x, y, z);
        r = 10;
    }

    public void update() {
        p.z -= cameraSpeed;

        if (p.z < 1 || p.x < -width / 2 || p.y < -height / 2 || p.x > width / 2 || p.y > height / 2) {
            p.x = random(-width / 2, width / 2);
            p.y = random(-height / 2, height / 2);
            p.z = random(0, depth);
        }
    }

    public void show() {
        /*
            When an object is furthest away, z is closest to max depth, it
            will appear closer to it's vanishing point, (0,0) on the plane
            of the camera. So our input to map should be closer to 0 if an
            object is further away. However, an object close to or beside 
            the camera may have a value outside the range of +/- w/h, or 
            the boundary. This is because an object could appear to come 
            into view somewhere between (0,0) and the boundary, yet travel
            far beyond the boundary as it nears the camera. Thus, input 
            values to map that are beyond the range are intentional.
        */
        float sx = map(p.x * ((depth / p.z) - 1), -width, width, -width / 2, width / 2);
        float sy = map(p.y * ((depth / p.z) - 1), -height, height, -height / 2, height / 2);
        float sr = map(p.z / depth, 0, 1, r, 0);
        float brightness = map(p.z / depth, 0, 1, 100, 20);

        fill(color(340, 60, brightness));
        noStroke();
        ellipse(sx, sy, sr * 2, sr * 2);
    }

    public int compareTo(Star s) {
        return round(s.p.z - this.p.z);
    }
}

/*--------------------*/
/*--------------------*/