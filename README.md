# Gourmet_Swift
Application to check your Gourmet-card balance (in Spain -> https://www.tarjetachequegourmet.es)

# Future features
* Today extension
* Offline support
* Move http -> https (when these service be available)

## Changelog
See [CHANGELOG.md](CHANGELOG.md)

## Developed By
* daviwiki (https://github.com/daviwiki)

## About AppGroups
Remember that AppGroups must be previously configured into
developer.apple.com portal before you use their features in an app.
Actually, this app use app groups to communicate the Gourmet app and
Today Extension passing data through UserDefaults. In your case you
must do the following to work with app groups:
    * Create your own group into developer portal (mine is: "group.atenea.gourmet")
    * Enable AppGroup capability into:
        - Gourmet app target
        - Gourmet Today-Extension target
    * Replace all occurrences "group.atenea.gourmet" with "group.your.own.groupname"

For More information:
    * https://developer.apple.com/library/content/documentation/Miscellaneous/Reference/EntitlementKeyReference/Chapters/EnablingAppSandbox.html#//apple_ref/doc/uid/TP40011195-CH4-SW19
    * http://www.atomicbird.com/blog/sharing-with-app-extensions
