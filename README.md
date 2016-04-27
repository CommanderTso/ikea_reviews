README
==

![Build Status](https://codeship.com/projects/1bf10340-dcbb-0133-b80a-760a1f8f56cd/status?branch=master)
![Code Climate](https://codeclimate.com/github/CommanderTso/ikea_reviews.png)
![Coverage Status](https://coveralls.io/repos/CommanderTso/ikea_reviews/badge.png)

Eyekea
=

This was a team project for Launch Academy's Sprint 2016 cohort.

Eyekea is a site we created in two weeks to hold reviews of Ikea items  Via web scraping, we pulled in links to most of Ikea's inventory - users can then create reviews on the items, as well as up and downvote the reviews they like.  

Deploying Eyekea
=
In order to get Eyekea running:
* Clone the repository
* `bundle install`
* `rake db:setup`
* `rails s`

The seeds file has around 2500 product entries; be aware that this will crash out if run at full speed on a free Heroku server.  The seeds file has a `sleep 1` that will keep it from overheating.

Key Features
=
* Users can add products to the site by inputting an Ikea URL.  The product is scraped from the Ikea site and added automatically.
* The Devise gem was implemented to handle user and admin privileges
* Upvoting and downvoting uses AJAX to refresh without a page reload
* Profile pictures via the CarrierWave gem and an S3 bucket

Feature Wishlist
=
Here are some of the things we would have loved to put in, if we'd had the time:
* Better unit and feature test coverage
* Integrate sending emails automatically based on user behavior
* Further linkage to the Ikea site - more product info, link back to them to purchase items, etc.
* Integration of an API like Twitter
* Make the site mobile friendly & put more time in on the styling
* More robust search functionality


Team Members
=
* [Jeff Zhen](https://github.com/ek0ms)
* [Katie Vien](https://github.com/nvien)
* [Scott Macmillan](https://github.com/commandertso)
* [Patricia Chun](https://github.com/pahchun)
