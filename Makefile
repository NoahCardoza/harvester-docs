.PHONY: build upload test

dev-build:
	nodemon -e "md yml" -w pydoc-markdown.yml -w pages --exec pydoc-markdown --build --site-dir build

dev-server:
	hugo server --source build --watch --baseURL http://localhost:1313/harvester-docs --port 1313 --bind 127.0.0.1

build:
	pydoc-markdown --build --site-dir build
	hugo --source build --baseURL https://noahcardoza.github.io/harvester-docs/
	
publish: build
	git add build
	git commit -m "rebuilt docs"
	git push origin `git subtree split --prefix build/public master`:gh-pages --force