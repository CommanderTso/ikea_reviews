== README

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


Team Members
=
* [Jeff Zhen](https://github.com/ek0ms)
* [Katie Vien](https://github.com/nvien)
* [Scott Macmillan](https://github.com/commandertso)
* [Patricia Chun](https://github.com/pahchun)
