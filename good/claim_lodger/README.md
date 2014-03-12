# Exampe of good code that does not abuse ActiveRecord

Usecase is a simplified claim lodgement.

Client file claims to the insurance company.
Based on the eligibility, the insurance company will grant / reject claimable cash.

# What's been done right?

* Service Object pattern
* Split the eligibility rules logic into seprate class
* Split the attributes template into separate class
* Encourage testing without going through rails stack
* Only use ActiveRecord for data persistence
* Simplicity over Convention

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

