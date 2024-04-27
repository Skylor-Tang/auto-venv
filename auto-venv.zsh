# Check for the existence of a venv directory and activate the Python virtual environment
# If a venv or .venv directory is found, activate the corresponding virtual environment
_check_venv() {
    # Check for the existence of a venv or .venv directory
    if [ -d "venv" ]; then
        # Activate the venv virtual environment
        source venv/bin/activate
        echo "Activated Python virtual environment: venv"
    elif [ -d ".venv" ]; then
        # Activate the .venv virtual environment
        source .venv/bin/activate
        echo "Activated Python virtual environment: .venv"
    fi

    current_dir="$PWD"
}

_deactivate_venv() {
    if [ -n "$VIRTUAL_ENV" ]; then
        deactivate
        echo "Deactivated Python virtual environment: $current_dir"
    fi
}
# Change directory and automatically check and activate the Python virtual environment
# This function will call the check_venv() function after changing the directory
cd() {
    # Init
    # Get the target directory path
    if [ "$#" -eq 0 ]; then
        # No arguments, go to the user's home directory
        target_dir="$HOME"
    else
        target_dir=$(realpath "$1" 2>/dev/null)
        if [ "$?" -ne 0 ]; then
            # Target directory does not exist
            echo "cd: no such file or directory: $1"
            return 1
        fi
    fi
    # echo "target_dir: $target_dir"

    if [ -z "$current_dir" ]; then
        current_dir="$PWD"
    fi

    if [ "$target_dir" != "$current_dir" ]; then
        _deactivate_venv
    fi

    # Call the native cd command to change the directory
    builtin cd "$@"

    # Check and activate the Python virtual environment
    _check_venv
}