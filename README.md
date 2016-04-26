[![Build Status](https://travis-ci.org/producthunt/producthunt-osx.svg?branch=master)](https://travis-ci.org/producthunt/producthunt-osx)

# Product Hunt for Mac

> This is the official [Product Hunt](http://www.producthunt.com) for Mac.
 
![producthunt-osx-app](https://cloud.githubusercontent.com/assets/2778007/14168594/d522c7fe-f72b-11e5-80f6-b21d9a3f3ecd.jpg)
 
Product Hunt is the place to discover your next favorite thing, surfacing the latest in tech, books, games, and podcasts.

Also check out our iOS app and Chrome extension at [http://producthunt.com/apps](http://producthunt.com/apps).

## Download

You can also download Product Hunt for Mac [here](https://s3.amazonaws.com/producthunt/mac/ProductHunt.dmg)

## Development

* Clone the repository:

```
$ git clone git@github.com:producthunt/producthunt-osx.git
$ cd producthunt-osx
```

* Copy configuration templates:

```
cp Source/Config/Keys-Example.xcconfig Source/Config/Keys.xcconfig
```

API Keys generated from https://www.producthunt.com/v1/oauth/applications

* Install CocoaPods Dependencies

```
$ pod install
```

* Open `Product\ Hunt.xcworkspace`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Run the tests
6. Create new Pull Request

## License

[![Product Hunt](http://i.imgur.com/dtAr7wC.png)](https://www.producthunt.com)

```
 _________________
< The MIT License >
 -----------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```

**[MIT License](https://github.com/producthunt/PHImageKit/blob/master/LICENSE)**
