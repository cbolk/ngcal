.DEFAULT_GOAL := all

.build/0-biblio.json: assets/data/biblio.json
	cp assets/data/biblio.json .build/0-biblio.json

.build/1-index.json: assets/data/index.json
	cp assets/data/index.json .build/1-index.json

.build/2-projects.json: assets/data/projects.json
	cp assets/data/projects.json .build/2-projects.json

dist/data/biblio.json: .build/0-biblio.json
	@mkdir -p dist/data/
	cp .build/0-biblio.json $@

dist/data/index.json: .build/1-index.json
	@mkdir -p dist/data/
	cp .build/1-index.json $@

dist/data/projects.json: .build/2-projects.json
	@mkdir -p dist/data/
	cp .build/2-projects.json $@

.build/3-index.html: assets/index.html
	cp assets/index.html .build/3-index.html

dist/index.html: .build/3-index.html
	@mkdir -p dist/
	cp .build/3-index.html $@

.build/5-angular.min.js: ./bower_components/angular/angular.min.js
	cp bower_components/angular/angular.min.js .build/5-angular.min.js

.build/6-calendar.js: assets/css/fonts.css assets/css/obsidian.css assets/js/bundle.js assets/js/calendar.ls assets/js/client.ls assets/js/easyDirective.ls assets/js/entry.ls assets/less/bio.less assets/less/calendar.less assets/less/main.less assets/less/mixin.less assets/less/post.less assets/less/posts.less assets/less/projects.less assets/less/publications.less assets/less/research.less assets/less/reset.less assets/less/segment.less assets/less/sidebar.less assets/less/table.less assets/less/teaching.less assets/less/videos.less
	./node_modules/.bin/browserify -t node-lessify -t liveify assets/js/calendar.ls -o .build/6-calendar.js

.build/concat-tmp4.js: .build/5-angular.min.js .build/6-calendar.js
	cat $^ > $@

.build/7-concat-tmp4.min.js: .build/concat-tmp4.js
	uglifyjs .build/concat-tmp4.js -c -m  > $@

dist/js: 
	mkdir -p dist/js

dist/js/client.js: .build/7-concat-tmp4.min.js dist/js
	cp .build/7-concat-tmp4.min.js $@

.PHONY : build-assets
build-assets: dist/data/biblio.json dist/data/index.json dist/data/projects.json dist/index.html dist/js/client.js

.PHONY : build
build: build-assets

.PHONY : cmd-8
cmd-8: 
	make build

.PHONY : cmd-seq-9
cmd-seq-9: 
	make cmd-8

.PHONY : all
all: cmd-seq-9

.PHONY : clean-10
clean-10: 
	rm -rf .build/0-biblio.json .build/1-index.json .build/2-projects.json dist/data/biblio.json dist/data/index.json dist/data/projects.json .build/3-index.html dist/index.html .build/5-angular.min.js .build/6-calendar.js .build/concat-tmp4.js .build/7-concat-tmp4.min.js dist/js dist/js/client.js

.PHONY : clean-11
clean-11: 
	rm -rf .build

.PHONY : clean-12
clean-12: 
	mkdir -p .build

.PHONY : cmd-13
cmd-13: 
	rm -rf dist/*

.PHONY : clean
clean: clean-10 clean-11 clean-12 cmd-13
