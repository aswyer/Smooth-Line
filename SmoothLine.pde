import java.util.ArrayList;

ArrayList<PVector> allPoints = new ArrayList<PVector>();
ArrayList<PVector> sigPoints = new ArrayList<PVector>();

int SMOOTHNESS = 50;
PVector lastSigPoint;
int lastSigPointIndex = 1;
int customStrokeWeigth = 5;

boolean spacePressed = false;
boolean shouldShowSigPoints = false;
boolean hasEndedDrawing = false;

color lineColor = color(255);
color backgroundColor = color(0);

void setup() {
    size(800, 800);
   //  fullScreen();
}

void draw() {
    background(backgroundColor);

    if (mousePressed ==  true) {

        if (hasEndedDrawing) {
            reset();
            hasEndedDrawing = false;
        }
        
        PVector newPoint = new PVector(mouseX, mouseY);
        
        if (lastSigPoint == null) {
            lastSigPoint = newPoint;
        }
        float distanceFromLastSigPoint = newPoint.dist(lastSigPoint);
        
        if (distanceFromLastSigPoint >= SMOOTHNESS || spacePressed) {
            createSigPoint(newPoint);
            
            spacePressed = false;
        }
        
        allPoints.add(newPoint);
        
    } else if (allPoints.size() > 0) {

        hasEndedDrawing = true;
        //PVector originalPoint = allPoints.get(0);
        //createSigPoint(originalPoint);
        //allPoints.add(originalPoint);

    }
    
    
    
    //draw curve
    noFill();
    strokeWeight(customStrokeWeigth);
    stroke(lineColor);
    
    beginShape();
    for (int p = 0; p < allPoints.size(); p++) {
        PVector point = allPoints.get(p);
        curveVertex(point.x, point.y);
    }
    endShape();  
    
    
    //draw sig poins
    if (shouldShowSigPoints) {
        fill(255, 0, 100);
        noStroke();
        
        for (int p = 0; p < sigPoints.size(); p++) {
            PVector point = sigPoints.get(p);
            circle(point.x, point.y, 10);
        }
    }
}

void createSigPoint(PVector newPoint) {
    for (int p = allPoints.size() - 1; p > lastSigPointIndex; p--) {
        allPoints.remove(p);
    }
    
    lastSigPoint = newPoint;
    lastSigPointIndex = allPoints.size();
    sigPoints.add(newPoint);
}

void keyPressed() {
    switch(key) {
        //show points
        case 'p':
           shouldShowSigPoints = !shouldShowSigPoints;
           break;
        
        //clear
        case 'c':
           reset();
           break;


        //smoothness
         case '9': //click and draw while pressing space bar to add own points
           SMOOTHNESS = (int) sqrt( pow(width, 2) + pow(height,2) );
           println(SMOOTHNESS);
           break;

        case '0':
           SMOOTHNESS = 50;
           println(SMOOTHNESS);
           break;

        case '=':
           SMOOTHNESS += 5;
           println(SMOOTHNESS);
           break;

        case '-':
           SMOOTHNESS -= 5;
           if (SMOOTHNESS <= 0) {
               SMOOTHNESS = 5;
           }
           println(SMOOTHNESS);
           break;


         //stroke weight
         case ']':
           customStrokeWeigth += 5;
           
           break;

         case '[':
           customStrokeWeigth -= 5;
           if (customStrokeWeigth <= 0) {
               customStrokeWeigth = 1;
           }
           break;


        //stroke colors
        case '1':
           lineColor = color(255, 255, 255);    
           break;
        case '2':
           lineColor = color(255, 255, 0);    
           break;
        case '3':
           lineColor = color(255, 0, 0);    
           break;
        case '4':
           lineColor = color(0, 255, 0);    
           break;
        case '5':
           lineColor = color(0, 0, 255);    
           break;
        case '6':
           lineColor = color(255, 0, 255);    
           break;

        //background colors
        case 'q':
           backgroundColor = color(0, 0, 0);    
           break;
        case 'w':
           backgroundColor = color(255, 255, 0);    
           break;
        case 'e':
           backgroundColor = color(255, 0, 0);    
           break;
        case 'r':
           backgroundColor = color(0, 255, 0);    
           break;
        case 't':
           backgroundColor = color(0, 0, 255);    
           break;
        case 'y':
           backgroundColor = color(255, 0, 255);    
           break;
        
        default:
           break;	
    }
}

void keyReleased() {
    switch(key) {
        case ' ':
           spacePressed = true;
           break;
        
        default:
           break;
    }
}

void reset() {
    lastSigPoint = null;
    lastSigPointIndex = 1;
    spacePressed = false;
    
    allPoints.clear();
    sigPoints.clear();
}
