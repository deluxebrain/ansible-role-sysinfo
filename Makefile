.DEFAULT_GOAL := lint

molecule_distros := centos\:7 \
	ubuntu\:18.04 \
	ubuntu\:19.04

test-targets = $(addprefix test-,$(molecule_distros))
run-targets = $(addprefix run-,$(molecule_distros))

.PHONY: lint
lint:
	yamllint .
	ansible-lint .

.PHONY: test-all
test-all: $(test-targets)

$(test-targets): export MOLECULE_DISTRO = $(subst test-,,$@)
$(test-targets) test: 
	molecule test

.PHONY: run-all
run-all: $(run-targets)

$(run-targets): export MOLECULE_DISTRO = $(subst run-,,$@)
$(run-targets) run:
	molecule create; \
	molecule destroy

.PHONY: clean
clean:
	@molecule destroy
