#!/usr/bin/env lsc

{ parse, add-plugin } = require('newmake')

name = "dist"
ast-dst = "#name"
ast-src = "assets"

s = -> "#ast-src#it"
d = -> "#ast-dst#it"

baseUrl = ""


parse ->

    @add-plugin 'brfy', (g, deps) ->
        @compile-files( (-> "./node_modules/.bin/browserify -t node-lessify -t liveify #{it.orig-complete} -o #{it.build-target}"), ".js", g, deps)

    @collect "build", -> [

        @collect "build-assets", -> [

                @toDir d("/data"), { strip: s("/data") }, -> [
                    @glob s("/data/*.json")
                    ]

                @toDir d(""), { strip: s("") }, -> [
                       @glob s("/*.html")
                       ]

                @dest d("/js/client.js"), ->
                   @minifyjs ->
                       @concatjs -> [
                                @copy ("./bower_components/angular/angular.min.js")
                                @brfy s("/js/calendar.ls"), s("/**/*.{ls,js,css,less}")
                                ]
                ]
        ]

    @collect "all", ->
        @command-seq -> [
            @make "build"
            ]

    @collect "clean", -> [
        @remove-all-targets()
        @cmd "rm -rf #name/*"
    ]
