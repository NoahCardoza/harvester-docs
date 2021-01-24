.PHONY: build upload test

test:
	mkdir -p build/content
	cp pages/index.md build/content/_index.md
	pydoc-markdown --build --site-dir build
	cd build; hugo

build:
	mkdir -p build/content
	cp pages/index.md build/content/_index.md
	pydoc-markdown --build --site-dir build
	cd build; hugo --baseURL https://noahcardoza.github.io/harvester-docs/
	
publish:
	git subtree push --prefix build/public origin gh-pages