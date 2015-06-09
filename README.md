# ThoughtPad
Canvas view for hand-drawing and rendering vector paths and shapes.

## Warning
This project is a WIP.  Its current stength is the _PathSegment_ model.  Its other models will change to improve structure and performance.


### Known Issues
+ Rendering performance degrades as segments increase.  This will be solved by rendering via PathView (instead of drawRect method of CanvasView).
+ Dots and small paths (with less than 5 points) do not render.  This will be solved by rendering linear bezier paths for segments with < 5 points.

