VagrantConfig = {
  box: {
    box_name: "proctorsdevtest.local",
    box_number: 89,
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
    server_name: "proctorsdevtest.local",
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
    database_dump: "/var/www/database.sql"
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
