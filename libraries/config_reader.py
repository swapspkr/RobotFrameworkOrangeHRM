"""
config_reader.py — YAML configuration reader for Robot Framework.

How it works:
1. Robot Framework calls Read Config('config/dev.yaml')
2. Python reads the YAML file
3. Replaces ${VAR} placeholders with OS environment variables
4. Returns a nested dictionary
5. Robot Framework keyword sets suite variables from the dict

Usage in .robot files:
    Library    ../../libraries/config_reader.py
    ${config}=    Read Config    config/dev.yaml
    Log    ${config}[application][base_url]
"""

import os
import re
import yaml


def read_config(config_file: str) -> dict:
    """
    Reads a YAML config file and returns its contents as a dictionary.
    Substitutes ${VAR_NAME} placeholders with OS environment variables.

    Args:
        config_file: Relative or absolute path to the YAML file.

    Returns:
        Parsed YAML as a nested dictionary.
    """
    # Resolve relative path from the project root
    if not os.path.isabs(config_file):
        project_root = os.path.abspath(
            os.path.join(os.path.dirname(__file__), "..")
        )
        config_file = os.path.join(project_root, config_file)

    if not os.path.exists(config_file):
        raise FileNotFoundError(f"Config file not found: {config_file}")

    with open(config_file, "r", encoding="utf-8") as f:
        raw_content = f.read()

    # Replace ${VAR_NAME} with OS environment variable values
    resolved_content = _substitute_env_vars(raw_content)

    config = yaml.safe_load(resolved_content)
    return config


def _substitute_env_vars(text: str) -> str:
    """
    Replaces ${VAR_NAME} tokens with their OS environment variable values.
    Unknown variables are replaced with an empty string.
    """
    def replacer(match):
        var_name = match.group(1)
        value = os.environ.get(var_name, "")
        if not value:
            print(f"[WARN] Environment variable '{var_name}' not set — using empty string")
        return value

    return re.sub(r"\$\{([^}]+)\}", replacer, text)