rails-templates
===============

Application and engine (hopefully)

Motivation
==========

I want to share the tools that I use to create applications with the world, and
with my students, in the name of improvement.  Starting an application is
another perfect example of something where you do not need to understand
everything before you run it for the first time.  As students and newcomers
become more familiar with the landscape, they can assess the choices here and
decide whether or not they are right for them.

It also might serve as a helpful referendum and statement about software
erosion.

Usage
=====

The basic application can be created with this command:

```
rails new YOUR_APP_NAME_HERE -m https://raw.github.com/bigfleet/rails-templates/master/rails_app.rb

```

An application that includes a reasonable devise install can be installed this
way:

```
rails new YOUR_APP_NAME_HERE -m https://raw.github.com/bigfleet/rails-templates/master/authed_app.rb

```

If you have used the template more than once, you may want to put the
application on a different port.  You can do so in the command with one that
prepends ```PORT=5001``` like this:

```
PORT=5001 rails new YOUR_APP_NAME_HERE
 -m https://raw.github.com/bigfleet/rails-templates/master/rails_app.rb
```

You will need to hit 'y' once, as I've specified some additions to a file that
Rails has opinions on.


Libraries
=========

Unicorn, foreman, and postgres are used to get you started on the web server
side.

Rspec and factory girl are used for testing.
