rcd() {
    local package
    package=$(rospack list-names | fzf-tmux --query="$1" --select-1 --exit-0) &&
        roscd "$package"
}

rte() {
    rostopic list > /dev/null &&
        rostopic list | fzf-tmux --query="$1" --select-1 --exit-0 |\
        sed "s/^/rostopic echo /" | writecmd
}

rkill() {
    local node
    rostopic list > /dev/null &&
        node=$(rosnode list | fzf-tmux --query="$1" --select-1 --exit-0) &&
        rosnode kill "$node"
}

# Build packages
rb() {
    local package
    package=$(rospack list-names | fzf-tmux --query="$1" --select-1 --exit-0) &&
        catkin build -w $ROS_DIR_PATH -DCMAKE_EXPORT_COMPILE_COMMANDS=ON "$package" 
}

# Clean packages
rclean() {
    local package
    package=$(rospack list-names | fzf-tmux --query="$1" --select-1 --exit-0)
    rclean_build_path=$ROS_DIR_PATH/build/$package
    rclean_devel_path=$ROS_DIR_PATH/devel/lib/$package
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

