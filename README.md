# README
This is an implementation of the Robot Simulator. This project is written in Ruby to serve as a programming exercise. 

Checkout robots.md for a detailed description of the project.
---
## Quick start

### Commandline mode
+ Run the robomat with an external file containing commands for the robot.
    $ ruby robomat.rb -f <commands.txt>

### Interactive mode

+ Run robomat in interactive mode
    $ ruby robomat.rb
    

#### Command format

    PLACE X,Y,F
    MOVE
    LEFT
    RIGHT
    REPORT

