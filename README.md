# fzf_ros
FZF tools for ROS!

## FZF
[FZF](https://github.com/junegunn/fzf) is an awesome commandline fuzzy finder. These functions use FZF to help make working with ROS much easier.

## Requirements
You need the following to use all the functions:

* [ROS](http://www.ros.org/)
* [catkin tools](https://catkin-tools.readthedocs.org/en/latest/) 

## Usage
After installing FZF, add the following line to your `~/.bashrc` to source the file:
```
source /path/to/fzf_base.sh
source /path/to/fzf_ros.sh
```
**Remember to source your `.bashrc`**

Also, it's super useful to have already built your project at least once.

### Commands
 Command | Shortcut |
----|----|
`rostopic echo <topic>` | `rte` |
`roscd <package>` | `rcd` |
`rosnode kill <node>` | `rkill`|
`catkin build -w $ROS_DIR_PATH -DCMAKE_EXPORT_COMPILE_COMMANDS=ON <package>` | `rb`
Clean out particular packages | `rclean`|


## Credits
This file was originally made by the very talented [Matthias Wisniowski](https://github.com/mwisniowski), I'm putting it on github to keep track of it.

