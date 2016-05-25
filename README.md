# README
This is an implementation of the Robot Simulator. This project is written in Ruby to serve as a programming exercise. 

Checkout robots.md for a detailed description of the project.
---
## Quick start

### Commandline mode
+ Run the robomat with an external file containing commands for the robot.
    $ ruby main.rb
+ By default main.rb reads in commands from `input.dat` file. 

#### Command format

    PLACE X,Y,F
    MOVE
    LEFT
    RIGHT
    REPORT

