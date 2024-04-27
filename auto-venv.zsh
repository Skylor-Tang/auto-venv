# Automatically activate Python virtual environment based on the current directory
auto_venv() {
    local current_dir="${1-${PWD}}"
    local venv_dirs=("venv" ".venv")

    # Search for virtual environment directories in the current directory and its parent directories
    for dir in "${venv_dirs[@]}"; do
        local local_venv_dir="${current_dir}/${dir}"

        # If a virtual environment directory is found, activate it
        if [ -d "${local_venv_dir}" ]; then
            source "${local_venv_dir}/bin/activate"
            echo -e "\e[32mActivated Python virtual environment: ${local_venv_dir}\e[0m"
            return
        fi
    done

    # If the current directory is within the active virtual environment, do nothing
    if [[ -n "$VIRTUAL_ENV" && "${current_dir}" =~ ^${VIRTUAL_ENV%/*} ]]; then
        return
    else
        # If the current directory is the root directory or the user's home directory,
        # deactivate the current virtual environment if it exists
        if [[ "${current_dir}" == "/" || "${current_dir}" == "$HOME" ]]; then
            if [[ -n "$VIRTUAL_ENV" ]]; then
                echo -e "\e[31mDeactivated Python virtual environment: $VIRTUAL_ENV\e[0m"
                deactivate
            fi
            return
        else
            # Recursively search the parent directory for a virtual environment
            auto_venv $(dirname "${current_dir}")
        fi
    fi
}

# Add the auto_venv function as a hook for the 'chpwd' event
autoload -Uz add-zsh-hook
add-zsh-hook chpwd auto_venv