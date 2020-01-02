.DEFAULT_GOAL := lint
RUN := .run_timestamp

molecule_distros := ubuntu\:18.04 \
	ubuntu\:19.04

test-targets = $(addprefix test-,$(molecule_distros))
run-targets = $(addprefix run-,$(molecule_distros))

.PHONY: init
init:
	pip3 install --user molecule
	pip3 install --user molecule[docker]
	molecule init scenario -r ansible-role-sysinfo 

.PHONY: lint
lint:
	yamllint .
	ansible-lint .

.PHONY: test-all
test-all: $(test-targets)

$(test-targets): export MOLECULE_DISTRO = $(subst test-,,$@)
test $(test-targets):
	molecule test

.PHONY: run-all
run-all: $(run-targets)

$(run-targets): export MOLECULE_DISTRO = $(subst run-,,$@)
$(run-targets):
	molecule converge
	molecule destroy

.PHONY: run
run: $(RUN)

$(RUN):
	molecule converge
	@touch $@

.PHONY: login
login: run
	molecule login

.PHONY: clean
clean:
	@molecule destroy
	@rm -f $(RUN)
