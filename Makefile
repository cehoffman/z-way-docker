rm:
	docker ps -a | grep -E 'Exited \(-?[0-9]+\)' | awk '{ print $$1 }' | xargs -n 1 docker rm

rmi:
	docker images | grep '^<none>' | awk '{print $$3}' | xargs -n 1 docker rmi

clean: rm rmi

.PHONY: rm rmi clean

# Files that are not excluded by the main .gitignore but by a .gitignore in
# a subdirectory are considered private files
DIRS_WITH_PRIVATE_FILES=$(patsubst %/.gitignore,%,$(wildcard */.gitignore))
PRIVATE_FILES=$(foreach d,$(DIRS_WITH_PRIVATE_FILES),$(addprefix $(d),$(shell cat $(d)/.gitignore)))

pack:
	tar -c $(PRIVATE_FILES) | gzip -c9 | gpg2 -e - > private.dat
	# tar -c $(PRIVATE_FILES) | gzip -c9 | openssl aes-256-cbc -a -e -salt > private.dat

unpack:
	cat private.dat | gpg2 -d - | tar -zx
	find $(PRIVATE_FILES) -type f -exec chmod 600 '{}' \;
	# cat private.dat | openssl aes-256-cbc -a -d | tar -zx
	# chmod 600 $(PRIVATE_FILES)

.PHONY: pack unpack
