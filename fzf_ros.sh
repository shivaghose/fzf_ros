#==============================================================================
# General ros tools

## roscd
rcd() {
    local package
    package=$(rospack list-names | fzf-tmux --query="$1" --select-1 --exit-0) &&
        roscd "$package"
}

## roslaunch
rlaunch() {
   find $ROS_DIR_PATH -type f -name "*.launch" | fzf-tmux --query="$1" --select-1 --exit-0 |\
        sed "s/^/roslaunch  /" | writecmd
}

#==============================================================================
# Topic related tools
## Echo a topic
rte() {
    rostopic list > /dev/null &&
        rostopic list | fzf-tmux --query="$1" --select-1 --exit-0 |\
        sed "s/^/rostopic echo /" | writecmd
}

## Topic info
rtinfo() {
    local topic
    rostopic list > /dev/null &&
        topic=$(rostopic list | fzf-tmux --query="$1" --select-1 --exit-0) &&
        rosnode info "$topic"
}

#==============================================================================
# Node related tools
## Node info
rninfo() {
    local node
    rostopic list > /dev/null
        node=$(rosnode list | fzf-tmux --query="$1" --select-1 --exit-0) &&
        rosnode info "$node"
}

## Ping nodes
rnping() {
    local node
    rostopic list > /dev/null &&
        node=$(rosnode list | fzf-tmux --query="$1" --select-1 --exit-0) &&
        rosnode ping "$node"
}

## Kill nodes
rnkill() {
    local node
    rostopic list > /dev/null &&
        node=$(rosnode list | fzf-tmux --query="$1" --select-1 --exit-0) &&
        rosnode kill "$node"
}

#==============================================================================
# Build tools
## Build a package - start immediately on match
rb() {
    local package
    package=$(rospack list-names | fzf-tmux --query="$1" --select-1 --exit-0) &&
        catkin build -w $ROS_DIR_PATH -DCMAKE_EXPORT_COMPILE_COMMANDS=ON "$package" 
}

## Build a package - prepare build command on command line for the user to
#  edit before starting a build
rbld() {
    rospack list-names  | fzf-tmux --query="$1" --select-1 --exit-0 |\
        sed "s/^/catkin build -w \$ROS_DIR_PATH -DCMAKE_EXPORT_COMPILE_COMMANDS=ON  /" | writecmd
}

## Clean packages
rclean() {
    local package
    package=$(rospack list-names | fzf-tmux --query="$1" --select-1 --exit-0)
    local rclean_build_path=$ROS_DIR_PATH/build/$package
    local rclean_devel_path=$ROS_DIR_PATH/devel/lib/$package
    if [ -d $rclean_build_path ]; then
        echo "Removing $rclean_build_path" &&
        rm -rf $rclean_build_path > /dev/null
    else
        echo "$rclean_build_path does not exist"
    fi
    if [ -d $rclean_devel_path ]; then
        echo "Removing $rclean_devel_path" &&
        rm -rf $rclean_devel_path > /dev/null
    else
        echo "$rclean_devel_path does not exist"
    fi
}

