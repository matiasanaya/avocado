avocado
=======

A contact info on-demand pulling mechanism


TODO
====

Better email (as seen on gmail) views

Support for more properties

Links to show up on email views

A proper URL

Nicer shares visualization with proper data
  Who has my data.
  Is it up-to date?
  What data they have.
  Update them the data if not up to date.
  Cancel a Subscription.

CallBacks
=========

There is a Mail interceptor setup in environment.rb

Env Vars
========
APP_DOMAIN = ?
SMTP_CONFIG_usr = user for the smtp server (gmail)
SMTP_CONFIG_pass = pass for the smtp server (gmail)
APP_HOST = host for ActionMailer
MAIL_INTERCEPTOR = 'on' or 'off'
