# Sinatatra Mongoid App  

nbp-exchange.heroku.com

info: This app is mainly for polish devs.

This app uses `nbp_exchange` gem to fetch and cache daily exchange rates.

It also provides API to fetch rates and currencies information.

## USAGE

```sh
rake seed # adds 2 default currencies
rake cron # downloads the most recent currencies exchange rates

bundle exec puma -C config/puma.rb
```

TODOs:

* Add specs
* Add more currencies
