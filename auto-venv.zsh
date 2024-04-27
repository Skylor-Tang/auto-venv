# Check for the existence of a venv directory and activate the Python virtual environment
# If a venv or .venv directory is found, activate the corresponding virtual environment
auto_venv() {
    local current_dir="${1-${PWD}}"
    local venv_dirs=("venv" ".venv")

    for dir in "${venv_dirs[@]}"; do
        local local_venv_dir="${current_dir}/${dir}"

        if [ -d "${local_venv_dir}" ]; then
            source "${local_venv_dir}/bin/activate"
            echo -e "\e[32mActivated Python virtual environment: ${local_venv_dir}\e[0m"
            return
        fi
    done

    if [[ -n "$VIRTUAL_ENV" && "${current_dir}" == "${VIRTUAL_ENV%/*}"* ]]; then
        return
    else
        if [[ "${current_dir}" == "/" || "${current_dir}" == "$HOME"  ]] ; then
            if [[ -n "$VIRTUAL_ENV" ]]; then
                echo -e "\e[31mDeactivated Python virtual environment: $VIRTUAL_ENV\e[0m"
                deactivate
            fi
            return
        else
            auto_venv "${current_dir%/*}"
        fi
    fi
}

cd() {
    if [ "$#" -eq 0 ]; then
        builtin cd
    else
        builtin cd "$@"
    fi
    auto_venv
}