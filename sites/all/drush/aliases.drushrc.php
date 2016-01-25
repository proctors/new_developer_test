<?php

// Get the full path to the user's home directory
// This is required for the SSH options - rsync requires that the SSH key be passed
// with an absolute path. We cannot use the tilde for this as it works using shell
// substitution, and Drush doesn't invoke the shell. 
$HOME = getenv("HOME"); 
$rootPath = str_replace("/sites/all/drush", "", __DIR__);

$aliases["vagrant"] = array(
    "os" => "linux",
    "remote-host" => "10.10.10.33",
    "remote-user" => "vagrant",
    "ssh-options" => "-i $rootPath/.vagrant/machines/drupalinterview.local/virtualbox/private_key",
    "root" => "/var/www",
    "uri" => "drupalinterview.local",
);