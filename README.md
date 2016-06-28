# Description
This is an implementation of the Robot Simulator. This project is written in Ruby to serve as a programming exercise. 

Checkout [robots.md](doc/robots.md) for a detailed description of the project.
---
## Environments

This application was developed on Ubuntu 14.04 x86_64 LTS, ruby 2.2.4p230.

## System Dependencies and Configuration

Ruby interpreter (2.2.4p230)

+ [How to install ruby](https://www.ruby-lang.org/en/documentation/installation/)

+ Once installed, you should be able to display the version.
    $ ruby --version
    $ ruby 2.2.4p230 (2015-12-16 revision 53155) [x86_64-linux]

## Application Installation Instructions

Change into the application directory.
Run bundle install.

    $ cd RoboMat
    $ bundle install

### Usage

Change into the bin directory.

    $ cd bin

Add execute permissions to the script.

    $ chmod a+x robomat

### Run in Interactive mode

Run the robomat with an external file containing commands for the robot.

    $ ./robomat    

#### Command format

Type in valid commands: 

    PLACE 0 , 0 , NORTH
    MOVE
    REPORT

#### Output format

    Robot is at (0, 0) facing N
    Robot is at (0, 1) facing N

Just press <ENTER> to exit the program.

### Run in Commandline mode

    $ ./robomat -f input.dat

## Testing

These will run the whole test suite for the robomat application.

    $ rake test

## License

The MIT License (MIT). More details @ LICENSE file.