# Role Name: SYSINFO

[![Build Status](https://travis-ci.org/deluxebrain/ansible-role-sysinfo.svg?branch=master)](https://travis-ci.org/deluxebrain/ansible-role-sysinfo)

Prints out Ansible facts related to the system information of the hosting platform.

Main usage is as a basic and quick running Ansible role to kick the tyres of the Molecule Ansible role development pipeline.

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

Packages are split into development and production dependencies, which are managed through the included files `requirements-dev.txt` and `requirements.txt` respectively.

Production packages are managed through the `pip-tools` suite, which installs and synchronizes the project dependencies through the included `requirements.in` file.

```sh
# Create project virtual environment
# Install development dependencies into virtual environment
make install
```

`pip-tools` is responsible for the generation of the `requirements.txt` which is a fully pinned requirements file used for both synchronizing the Python virtual environment and for the installation of packages within a production environment.

Note that this means that the `requirements.txt` file *should not be manually edited* and must be regenerated every time the `requirements.in` file is changed. This is done as follows, which also synchronizes any package changes into the virtual environment:

```sh
# Compile the requirements.in file to requirements.txt
# Install the requirements.txt pacakges into the virtual environment
make sync
```

`pip-tools` and other development requirements are installed through the `requirements-dev.txt` file, as follows:

## License

MIT / BSD

## Author Information

This role was created in 2020 by [deluxebrain](https://www.deluxebrain.com/).
