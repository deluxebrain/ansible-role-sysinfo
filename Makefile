.DEFAULT_GOAL := lint
.PHONY: venv install lint test-all run-all run connect clean
VENV_NAME := .venv
VENV := $(VENV_NAME)/.timestamp
VENV_ACTIVATE :=. $(VENV_NAME)/bin/activate
SITE_PACKAGES := $(shell test -d $(VENV_NAME) && $(VENV_ACTIVATE); \
	pip3 show pip | grep ^Location | cut -d':' -f2)
RUN := .run_timestamp
DISTROS := centos_7 \
	ubuntu_18.04 \
	ubuntu_19.04
TEST_TARGETS := $(addprefix test-,$(DISTROS))
RUN_TARGETS := $(addprefix run-,$(DISTROS))

venv: $(VENV)
$(VENV):
	python3 -m venv $(VENV_NAME)/	
	touch $@

install: venv $(SITE_PACKAGES) 
$(SITE_PACKAGES): requirements.txt
	$(VENV_ACTIVATE); \
	pip3 install -r requirements.txt		

lint:
	yamllint .
	ansible-lint .

test: install
	$(VENV_ACTIVATE); \
	molecule test

test-all: install clean $(TEST_TARGETS)
$(TEST_TARGETS): export MOLECULE_DISTRO = $(subst _,:,$(subst test-,,$@))
$(TEST_TARGETS):
	$(VENV_ACTIVATE); \
	molecule test

run: install $(RUN)
$(RUN):
	$(VENV_ACTIVATE); \
	molecule converge; \
	touch $@	

run-all: install clean $(RUN_TARGETS)
$(RUN_TARGETS): export MOLECULE_DISTRO = $(subst _,:,$(subst run-,,$@))
$(RUN_TARGETS):
	$(VENV_ACTIVATE); \
	molecule converge; \
	molecule destroy

connect: run
	$(VENV_ACTIVATE); \
	molecule login

clean: install
	$(VENV_ACTIVATE); \
	molecule destroy; \
	rm -f $(RUN)
