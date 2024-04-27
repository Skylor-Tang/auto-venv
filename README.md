# auto-venv

`auto-venv` is a Zsh plugin that automatically activates the Python virtual environment in the current directory or its parent directories.

## Installation

Use [zplug](https://github.com/zplug/zplug) to install the plugin:

```bash
zplug "Skylor-Tang/auto-venv", use:auto-venv.zsh
```

## Usage

The plugin automatically detects if there is a `venv` or `.venv` directory in the current directory or its parent directories, and activates the corresponding Python virtual environment.

When you change directories, the plugin will automatically detect and activate the virtual environment. If the current directory does not have a virtual environment, but you are currently in an active virtual environment, the plugin will automatically deactivate the current virtual environment.

## How it Works

The plugin uses the Zsh `chpwd` hook function to automatically call the `auto_venv` function when you change directories. This function recursively searches the parent directories until it finds a virtual environment directory or reaches the root directory or the user's home directory.

## Considerations

- This plugin assumes that your Python virtual environments are located in the `venv` or `.venv` subdirectories of your project directories.
- If you use other virtual environment management tools, such as `pipenv` or `poetry`, this plugin may not work as expected. In such cases, you may need to write custom activation logic.

## License

This plugin is released under the MIT license.
