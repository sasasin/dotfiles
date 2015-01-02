homebrew-packages
=================

Ansible role for installing homebrew packages

Requirements
------------

Install Ansible and homebrew.

Role Variables
--------------

- homebrew_packages_taps
    - an array of homebrew taps
- homebrew_packages_pacakges
    - an array of hashes for homebrew pacakges.
    - each hash has key name (mandatory), state (optional, default is latest), and install_options

Dependencies
------------

None.

Example Playbook
-------------------------

    - hosts: localhost
      connection: local
      gather_facts: no           
      sudo: no
      vars:
        homebrew_packages_taps:
          - homebrew/binary
          - homebrew/dupes
        homebrew_packages_packages:
          - { name: readline }
          - { name: openssl, state: linked }
          - { name: ansible }
          - { name: cmake }
          - { name: ctags }
          - { name: direnv }
          - { name: docker }
          - { name: git }
          - { name: jq }
          - { name: hub }
          - { name: imagemagick }
          - { name: mercurial }
          - { name: mysql }
          - { name: packer }
          - { name: pkg-config }
          - { name: pwgen }
          - { name: python }
          - { name: reattach-to-user-namespace }
          - { name: redis }
          - { name: subversion }
          - { name: the_silver_searcher }
          - { name: tig }
          - { name: tmux }
          - { name: whois }
          - { name: xz }
          - { name: vim }
          - { name: wget }
          - { name: zsh, install_options: disable-etcdir }
      roles:
        - hnakamur.homebrew-packages

License
-------

MIT

Author Information
------------------

Hiroaki Nakamura's contact information is at https://hnakamur.github.io/
