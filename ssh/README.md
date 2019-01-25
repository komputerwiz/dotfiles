# Setup for SSH

    └── .ssh
        ├── authorized_keys.example
        ├── config
        └── config.sec.example

## install notes

* Copy (or symlink) `authorized_keys` to enable remote login from known keys
* Use `config.sec` to add instance-specific configuration (e.g. for hostnames on local network)

