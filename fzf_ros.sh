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

rb() {
    local package
    package=$(rospack list-names | fzf-tmux --query="$1" --select-1 --exit-0) &&
        catkin build -w $ROS_DIR_PATH -DCMAKE_EXPORT_COMPILE_COMMANDS=ON "$package" 
}


