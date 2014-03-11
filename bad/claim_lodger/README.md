# Exampe of abusing ActiveRecord

Usecase is a simplified claim lodgement.

Client file claims to the insurance company.
Based on the eligibility, the insurance company will grant / reject claimable cash.

# What's been abused?

* STI is abused to grouping claim logic
* Validation is abused to check eligibility
* Callback is abused to set code and amount

# Bootstrap

```ruby
bundle exec rake db:create db:migrate
```
# Testing

```ruby
bundle exec rake spec
```

# Author

trung dot le at ruby dash journal dot com

# Credits

Thanks to Nikolai Nemshilov and Brad Bollenbach for feedbacks

