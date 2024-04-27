# Check for the existence of a venv directory and activate the Python virtual environment
# If a venv or .venv directory is found, activate the corresponding virtual environment
_check_venv() {
    local venv_dirs=("venv" ".venv")
    for dir in "${venv_dirs[@]}"; do
        if [ -d "$dir" ]; then
            source "{$dir}/bin/activate"
            echo "Activated Python virtual environment: $dir"
            return
        fi
    done
}

_deactivate_venv() {
    local current_dir="${1-${PWD}}"
    if [[ -n "$VIRTUAL_ENV" ]] && [[ "${current_dir}" != "${VIRTUAL_ENV%/*}"* ]]; then
        deactivate
        echo "Deactivated Python virtual environment: " # TODO
    fi
}

_auto_venv() {
    _deactivate_venv
    check_venv
}
# Change directory and automatically check and activate the Python virtual environment
# This function will call the check_venv() function after changing the directory
cd() {
    # Call the native cd command to change the directory
    builtin cd "$@"

    # Check and activate the Python virtual environment
    _auto_venv
}