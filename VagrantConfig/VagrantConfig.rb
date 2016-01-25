VagrantConfig = {
  box: {
    box_name: "drupalinterview.local",
    box_number: 33,
  },
  system: {
    extra_packages: [
      "htop",
      "vim",
    ],
    timezone: "Europe/London",
  },
  sync: {
    from: ".",
    to: "/var/www",
    method: :rsync,
  },
  apache: {
    server_name: "drupalinterview.local",
    document_root: "/var/www",
    modules: [
      "expires",
      "headers",
      "rewrite",
    ],
  },
  mysql: {
    root_password: "root",
    database_name: "drupal",
  },
  php: {
    extra_packages: [
      "php-pear",
      "php5-cli",
      "php5-curl",
      "php5-dev",
      "php5-gd",
      "php5-mysql",
      "php5-xdebug",
      "php5-memcached",
      "memcached"
    ],
  }
}