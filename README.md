# knife-dot

Knife plugin for [Chef](http://www.opscode.com/chef/) to draw a pretty
graph of environments, nodes, roles, and recipes.

## Requirements

This plugin requires [Graphviz](http://www.graphviz.org/). It can
generate input files without Graphviz installed, but they are not very
useful on their own.

## Installation

Add this line to your application's Gemfile:

    gem 'knife-dot'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install knife-dot

## Usage

Without any arguments, generate an input `dot` file on standard
output:

    $ knife dot

When arguments are provided, plugin will execute `dot` command,
feeding it the graph on standard input, allowing you to render the
graph directly, e.g.:

    $ knife dot -Tpng -oservers.png

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
