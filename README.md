# Source files for the official SWEET documentation website 

URL : https://sweet.gitlabpages.inria.fr/sweet-www/

Web content is written in .md files. After committing the changes on the master branch, Jekyll is executed on them to generate .html files, and the website is automatically updated. 

## Local developments

The website is in current development : more examples, tutorials, ... are continuously added and improved.
Any contribution through a pull request from any fork is welcomed.

In order to generate the website locally (for tests), you need the ruby packages `jekyll` and `bundle` installed on your computer. See https://jekyllrb.com/docs/ for more details.

Then installed all the website dependencies using

```bash
bundle install
```

and generate the website using

```bash
bundle exec jekyll serve --livereload
```

Then you can browse the website at this address : http://127.0.0.1:4000/sweetsite/.
The `--livereload` option allows to update the website rendering every time you modify a local source file.

## Old script for local developments :ghost:

This can be tested locally by executing

	./install_var_www.sh

to generate real website content.
	
