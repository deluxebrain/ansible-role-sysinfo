# Role Name: SYSINFO

[![Build Status](https://travis-ci.org/deluxebrain/ansible-role-sysinfo.svg?branch=master)](https://travis-ci.org/deluxebrain/ansible-role-sysinfo)

Prints out Ansible facts related to the system information of the hosting platform.

## Requirements

None.

## Role Variables

None.

## Dependencies

None.

## Example Playbook

```yaml
    - hosts: all
      roles:
         - deluxebrain.sysinfo
```

## Development Installation

The included files, `requirements-dev.txt` and `requirements.txt` install development and production dependencies accordingly.

The included Makefile includes several targets related to the installation of the development environment and the management of the development process.

Packages are managed through the `pip-tools` suite. This, and other development requirements, are installed through the `requirements-dev.txt` file.

```sh
# Create project virtual environment
# Install development dependencies into virtual environment
make install
```

`pip-tools` manages the project dependencies through the included `requirements.in` file, and is responsible both for the generation of the `requirements.txt` file and package installion into the virtual environment.

Note that this means that the `requirements.txt` file *should not be manually edited* and must be regenerated every time the `requirements.in` file is changed.

```sh
# Compile the requirements.in file to requirements.txt
# Install the requirements.txt pacakges into the virtual environment
make sync
```

## License

MIT / BSD

## Author Information

This role was created in 2020 by [deluxebrain](https://www.deluxebrain.com/).
