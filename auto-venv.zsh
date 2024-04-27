# Check for the existence of a venv directory and activate the Python virtual environment
# If a venv or .venv directory is found, activate the corresponding virtual environment
_check_venv() {
    _deactivate_venv
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
}

_deactivate_venv() {
    local current_dir="${1-${PWD}}"
    if [[ -v VIRTUAL_ENV ]] && [[ "${current_dir}" != "$(dirname ${VIRTUAL_ENV})"* ]]; then
        deactivate
        echo "Deactivated Python virtual environment: $current_dir"
    fi
}
# Change directory and automatically check and activate the Python virtual environment
# This function will call the check_venv() function after changing the directory
cd() {
    # Call the native cd command to change the directory
    builtin cd "$@"

    # Check and activate the Python virtual environment
    _check_venv
}