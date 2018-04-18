# Contents

* [Introduction](#introduction)
* [Prerequisites](#prerequisites)
* [Getting Started](#getting-started)
* [The Test](#the-test)
* [Submitting the Test](#submitting)

<a name="introduction"></a>
# Introduction

This project consists of a basic Drupal website and database. The website forms part of the recruitment process for web developers at Proctor + Stevenson.

This project includes a docker-compose configuration file to help get it up and running quickly. You can of course use your local WAMP or MAMP installation instead if you wish.

<a name="prerequisites"></a>
# Prerequisites

If you want to use docker, you will need Docker installed on your machine:

[https://www.docker.com/community-edition](https://www.docker.com/community-edition)

You will also need docker-compose. Which should be available using the community edition of Docker (above). 

<a name="getting-started"></a>
# Getting Started

Once you've installed the necessary prerequisites, you should be able to navigate to the root directory and run

```
docker-compose up
```

This will download the necessary docker images and build the containers and then start outputting log files. In a new window, at the root of the project, run:

```
docker/bin/mysqlimport
```

This will import the base database into the mysql container, proctorsdevtest_db. If you are using native apache and mysql, you can import the database yourself:

```
/database.sql
```

You'll need to configure your hosts file to point the URL to the docker image (or your local IP if you are not using docker).

```
127.0.0.1 proctorsdevtest.local
```

In order not to clash with any local version of apache or mysql you may have running on ports 80 or 3306, the docker container exposes alternative ports for you to connect to:

```
http: 5000:80
mysql: 3307:3306
```

This means you can access the site at

[http://proctorsdevtest.local:5000](http://proctorsdevtest.local:5000)

The project files are mounted directly into the docker container, proctorsdevtest_web, so any changes will be immediately reflected.

You can connect directly to proctorsdevtest_db at:

``` 
mysql -u root -p -h 127.0.0.1 -P 3307
```

The database user is "root" and the password is "root".

<a name="the-test"></a>
# The Test

The instructions for the test are located in the project directory at

```
/instructions
```

There are instructions depending on whether you want to do the Drupal or Non-Drupal test. Which test you do is entirely up to you. **You don't have to do both.**

**Also, if you are applying for the senior developer role, there are additional instructions.** 

# Drush

You can run drush in the docker container if you wish:

```
docker/bin/drush status
```

## If you are not familiar with Drupal

There are debugging functions, dpm() and dvm(). You will not see the output of these unless you are logged in. 

Access details to log in are in the instructions.

<a name="submitting"></a>
# Submitting the Test

We will need all the source code back to review your application. You can submit the via email attached as a zip file or download link and send to [recruitment@proctors.co.uk](mailto:recruitment@proctors.co.uk).

Ideally we should be able to download and unpack your files and then run `docker-compose up` and `docker/bin/mysqlimport` to see your code working. 

**Please also submit your CV, ensuring you list your name and the role you are applying for in the subject line.**
