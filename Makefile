.PHONY: test
test: bundle
	bundle exec guard

.PHONY: bundle
bundle:
	bundle install

.PHONY: tcr
tcr:
	./tcr.sh

.PHONY: pull
pull:
	git pull --rebase
