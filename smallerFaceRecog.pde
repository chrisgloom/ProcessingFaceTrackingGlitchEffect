import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
final int SCALING_FACTOR = 3;
final int AMOUNT_TO_MOVE_DOWN = 80;

int indexTranslation(int x, int y){
return x+(y*(width)); 
}
void weirdEffect(int rectx, int recty, int rectWidth, int rectHeight){
 
      for (int x = rectx; x < rectx+rectWidth; x++) {
        
      // Loop through every pixel row
      for (int y = recty; y < recty+rectHeight; y++) {
        
        
        // Use the formula to find the 1D location
        //int loc = x + y * width;
        if (x % 2 == 0 && indexTranslation(x, y+AMOUNT_TO_MOVE_DOWN)<(width) * (height)) { 
          
          // If we are an even column
          pixels[indexTranslation(x, y)] = color(pixels[indexTranslation(x, y+AMOUNT_TO_MOVE_DOWN)]);
        }
      
      }
      
    }
  
}

void setup() {
  size(960, 720);

  video = new Capture(this, 320, 240);
  opencv = new OpenCV(this, 320, 240);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();
}

void draw() {
 scale(SCALING_FACTOR);
  opencv.loadImage(video);

  image(video, 0, 0 );

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  
  loadPixels();
  for (int i = 0; i < faces.length; i++) {
    
    // Try to apply the effect to just the area inside of these rects
    // times two for the scale
    weirdEffect(faces[i].x*SCALING_FACTOR, faces[i].y*SCALING_FACTOR, faces[i].width*SCALING_FACTOR, faces[i].height*SCALING_FACTOR);
    
  
  }
  updatePixels();
}


void captureEvent(Capture c) {
  c.read();
}