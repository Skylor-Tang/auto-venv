# auto-venv

`auto-venv` is a Zsh plugin that automatically activates the Python virtual environment in the current directory or its parent directories.

## Installation

With [zplug](https://github.com/zplug/zplug):

```bash
zplug "Skylor-Tang/auto-venv", use:auto-venv.zsh, from:github, at:main
```

With [zpm](https://github.com/zpm-zsh/zpm):

```bash
zpm load Skylor-Tang/auto-venv
```

## Usage

The plugin automatically detects if there is a `venv` or `.venv` directory in the current directory or its parent directories, and activates the corresponding Python virtual environment.

When you change directories, the plugin will automatically detect and activate the virtual environment. If the current directory does not have a virtual environment, but you are currently in an active virtual environment, the plugin will automatically deactivate the current virtual environment.

## Silent Mode

By default, the plugin will print a message when it activates or deactivates a virtual environment. If you want to suppress these messages, you can set the `AUTO_VENV_SILENT` environment variable to `true`:

```bash
export AUTO_VENV_SILENT=true
```

## How it Works

The plugin uses the Zsh `chpwd` hook function to automatically call the `auto_venv` function when you change directories. This function recursively searches the parent directories until it finds a virtual environment directory or reaches the root directory or the user's home directory.

## Considerations

- This plugin assumes that your Python virtual environments are located in the `venv` or `.venv` subdirectories of your project directories.
- If you use other virtual environment management tools, such as `pipenv` or `poetry`, this plugin may not work as expected. In such cases, you may need to write custom activation logic.

## License

This plugin is released under the MIT license.
