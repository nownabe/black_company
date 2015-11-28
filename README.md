# BlackCompany

[![Gem Version](https://badge.fury.io/rb/black_company.svg)](https://badge.fury.io/rb/black_company)

BlackCompany provides workhorses. But there is a limit to the number of them. So it's a thread pool :yum:

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'black_company'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install black_company

## Usage

`require "black_company"`

Simple usage:

```ruby
black_company = BlackCompany.start
100.times do |i|
  black_company.receive(i) do |i|
    puts "This is the #{i}th task..."
  end
end
```

You can use your original workhorse:

```ruby
class MyWorkhorse < BlackCompany::Workhorse
  def serve(task_content)
    puts "This is the #{task_content}th task..."
  end
end

black_company = BlackCompany.start(workhorse_class: MyWorkhorse)
100.times do |task_content|
  black_company.receive(task_content)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nownabe/black_company.

