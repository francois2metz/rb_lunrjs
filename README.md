# RbLunrjs

A tool for writing a [http://lunrjs.com/](lunr.js) index with Ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'rb_lunrjs'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rb_lunrjs

## Usage

```ruby
lunr_options = {
  options: [
    {
      name: 'id',
      options: {
        boost: 10
      }
    },
    {
      name: 'name'
    }
  ],
  documents: [
    { id: 1, name: 'Helsinki' },
    { id: 2, name: 'Stockholm' }
  ]
}
options = {
  gzip: false,
  debug: true,
  lunr: lunr_options,
  out_file: 'index.json'
}
# Dump index
RbLunrjs.dump(options)
```

## Contributing

1. Fork it ( https://github.com/christianhellsten/rb_lunrjs/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Saved a tree'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
