Instructions
============

Include `dist/js/client.js` in your webpage; the file includes
angular.js (1.2.17) and the calendar directive, minified.

An example of how to use the directive is in `dist/index.html` (to run
the demo you have to serve 'dist' through a server, e.g. `serve dist`):

``` html
<body ng-app="application">
    <div id="my-calendar" calendar="calendar" start-month="May 2015" number-of-months="3" url="/data/index.json" class="lecture-material__calendar"></div>
</body>
```

Basically, you need to specify the start-month (format "MMM YYYY") and
the number of months you want to be displayed.

Besides, you need to specify the url of an `index.json` where links to
the various lectures are stored. This will highlight the days in which
material for a lecture is present and, by clicking on it, you could be
redirected to the specific url.

You can find an example `index.json` in the `dist/data` directory.
