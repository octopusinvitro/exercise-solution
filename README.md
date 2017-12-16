[![Build Status](https://travis-ci.org/octopusinvitro/exercise-solution.svg?branch=master)](https://travis-ci.org/octopusinvitro/exercise-solution)
[![build status](https://gitlab.com/octopusinvitro/exercise-solution/badges/master/build.svg)](https://gitlab.com/me-stevens/exercise-solution/commits/master)
[![Coverage Status](https://coveralls.io/repos/github/octopusinvitro/exercise-solution/badge.svg?branch=master)](https://coveralls.io/github/octopusinvitro/exercise-solution?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/7e36a9b166c281d0fc40/maintainability)](https://codeclimate.com/github/octopusinvitro/exercise-solution/maintainability)

# Programming Exercise

In the resources directory, you'll find three data files:

* `journals.csv`: a list of journal titles and ISSNs;
* `articles.csv`: a list of article DOIs <sup>[0]</sup>, titles and ISSNs;
* `authors.json`: a list of author names and their article DOIs.

We want to combine these data and output a single text file in one of two
different formats:

* CSV with columns of DOI, Article title, Author name, Journal title and
  Journal ISSN, e.g.

      10.1234/altmetric0,Small Wooden Chair,Amari Lubowitz,"Shanahan, Green and Ziemann",1337-8688

* JSON as an array of objects with fields for DOI, title, author, journal and
  ISSN, e.g.

```json
{
  "doi": "10.1234/altmetric0",
  "title": "Small Wooden Chair",
  "author": "Amari Lubowitz",
  "journal": "Shanahan, Green and Ziemann",
  "issn": "1337-8688"
}
```

Note that ISSNs should always be formatted as two groups of four digits
separated by a hyphen, e.g. 1234-5678, but might be missing the hyphen in the
source data.

We'd like you to create a Ruby program that can take these three files and
produce the new formats by running it like so (assuming the program is called
combine.rb):

    $ ruby combine.rb --format json journals.csv articles.csv authors.json > full_articles.json
    $ ruby combine.rb --format csv journals.csv articles.csv authors.json > full_articles.csv

[0]: http://en.wikipedia.org/wiki/Digital_object_identifier



## Development


### To initialise the project

```bash
bundle install
```


### To run all tests and rubocop

```bash
bundle exec rake
```


### To run one file


```bash
bundle exec rspec path/to/test/file.rb
```


### To run one test

```bash
bundle exec rspec path/to/test/file.rb:TESTLINENUMBER
```


## License

[![License](https://img.shields.io/badge/mit-license-green.svg?style=flat)](https://opensource.org/licenses/mit)
MIT License
