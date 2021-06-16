rails-templates
===============

The @bigfleet way to start a Rails app

Prerequisites
=============


Motivation
==========

I first created this for some students for Rails classes I taught several years ago.

In the time since, I have created many Rails apps, and have returned to this template to help.

When beginning a project,  you do not need to understand everything first.  As students 
and newcomers become more familiar with the landscape, they can assess the choices here and
decide whether or not they are right for them.  

The git history will speak here about [software erosion](https://en.wikipedia.org/wiki/Software_rot).

Usage
=====

The basic application can be created with this command:

```
rails new YOUR_APP_NAME_HERE \
  -m https://raw.github.com/bigfleet/rails-templates/master/new_app.rb

```


Start it up!
============

When VS Code asks you if you'd like to open in a dev container, say 'yes'.

This will get you to a terminal.

```
rails s -b 0.0.0.0
```

Gems
====

* [RSpec](https://rspec.info)
* [factory_bot](https://github.com/thoughtbot/factory_bot)
* [climate_control](https://github.com/thoughtbot/climate_control)
* [recipient_interceptor](https://github.com/croaky/recipient_interceptor)


References
==========

* [Suspenders](https://github.com/thoughtbot/suspenders) -- the king of Rails templates.  (Maybe I should just replace my preferences with Thoughtbots...)
* [Thor API docs](https://www.rubydoc.info/gems/thor/Thor) -- for finding what you can do in these sorts of .rb files, since the guides aren't comprehensive.
