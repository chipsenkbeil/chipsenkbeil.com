.PHONY: all clean build push

# Editor-related fields
EDITOR:=nvim
EXT:=org

# Hugo-related fields
HUGO=$(shell which hugo)
THEME="hugo-coder"
OUTPUT_DIR:=public

# Push-related fields
USER_EMAIL:="chip.senkbeil@gmail.com"
USER_NAME:="Chip Senkbeil"
REPO:=git@github.com:chipsenkbeil/chipsenkbeil.com.git
BRANCH:=gh-pages
DOMAIN:=chipsenkbeil.com
REV=$(shell git rev-parse --short HEAD)

define CNAME
$(DOMAIN)
www.$(DOMAIN)
endef

# Slugify a string
define SLUGIFY
$(strip \
  $(shell echo $(1) | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$$//'))
endef

all: clean build ## (Default) Cleans and builds website

help: ## Display help information
	@printf 'usage: make [target] ...\n\ntargets:\n'
	@egrep '^(.+)\:\ .*##\ (.+)' ${MAKEFILE_LIST} | sed 's/:.*##/#/' | column -t -c 2 -s '#'

clean: ## Removes contents inside output directory
	@rm -rf $(OUTPUT_DIR)/*

update: ## Updates theme and pulls latest changes from master repo
	@git pull origin master
	@git submodule update --remote --merge

update-theme: ## Updates theme from upstream, rather than origin
	@(cd themes/$(THEME) && git pull upstream master && git push origin HEAD:master)
	@git add themes/$(THEME)
	@git commit -m "Updated themes/$(THEME)"
	@git push origin master

build: ## Builds website
	@$(HUGO) --theme="$(THEME)"

serve: ## Runs server to test out website
	@$(HUGO) serve --theme="$(THEME)"

new-%: ## Creates new post/note/{item}
ifeq ($(strip $(TITLE)),)
	$(error You must provide TITLE like: make $@ TITLE="...")
endif

	$(eval TYPE := $*)
	$(eval DIR := content/$(TYPE)s)
	$(eval FILES := $(wildcard $(DIR)/*.$(EXT)))
	$(eval NUMBERS := $(sort $(foreach f,$(FILES),$(firstword $(subst -, ,$(notdir $(f)))))))
	$(eval LAST := $(if $(NUMBERS),$(lastword $(NUMBERS)),000))
	$(eval NEXT := $(shell printf "%03d" $$((10#$(LAST) + 1))))
	$(eval SLUG := $(call SLUGIFY,$(TITLE)))
	$(eval FILENAME := $(DIR)/$(NEXT)-$(SLUG).$(EXT))
	$(eval DATE := $(shell date +%Y-%m-%d))
	$(eval DESCRIPTION := $(strip $(DESCRIPTION)))
	$(eval CATEGORIES := $(strip $(CATEGORIES)))
	$(eval TAGS := $(strip $(TAGS)))

	@echo "#+TITLE: $(TITLE)" > $(FILENAME)
	@echo "#+SLUG: $(SLUG)" >> $(FILENAME)
	@echo "#+DESCRIPTION: $(DESCRIPTION)" >> $(FILENAME)
	@echo "#+DATE: $(DATE)" >> $(FILENAME)
	@echo "#+CATEGORIES[]: $(CATEGORIES)" >> $(FILENAME)
	@echo "#+TAGS[]: $(TAGS)" >> $(FILENAME)
	@echo "" >> $(FILENAME)

	@$(EDITOR) + "$(FILENAME)"

$(OUTPUT_DIR)/.git:
	mkdir -p $(OUTPUT_DIR) && \
	cd $(OUTPUT_DIR) && \
	git init && \
	git config user.email $(USER_EMAIL) && \
	git config user.name $(USER_NAME) && \
	git remote add upstream "$(REPO)" && \
	git fetch upstream && \
	git reset upstream/$(BRANCH)

export CNAME
push: clean $(OUTPUT_DIR)/.git build ## Cleans, builds, and publishes website
	cd $(OUTPUT_DIR) && \
	echo "$$CNAME" > CNAME && \
	touch . && \
	git add -A && \
	git commit -m "Rebuilt pages at $(REV)" && \
	git push --force upstream HEAD:$(BRANCH)
