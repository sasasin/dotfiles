homebrew-cask-packages
======================

Ansible role for installing homebrew cask packages

Requirements
------------

Install Ansible and homebrew.

Role Variables
--------------

- homebrew_cask_packages_taps
    - an array of homebrew cask packages

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
        homebrew_cask_packages_packages:
          - atom
          - calibre
          - firefox
          - google-chrome
          - google-japanese-ime
          - grandperspective
          - hipchat
          - iterm2
          - java
          - keepassx
          - kindle
          - mysqlworkbench
          - skype
          - spark
          - vagrant
          - virtualbox
          - zeroxed
      roles:
        - hnakamur.homebrew-cask-packages

License
-------

MIT

Author Information
------------------

Hiroaki Nakamura's contact information is at https://hnakamur.github.io/
