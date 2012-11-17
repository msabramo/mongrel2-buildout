MKDIR = mkdir

MONGREL2_ROOT = mongrel2-root
MONGREL2_CONFIG_FILE = $(MONGREL2_ROOT)/mysite.conf
MONGREL2_CONFIG_SQLITE = $(MONGREL2_ROOT)/config.sqlite
M2SH := $(shell pwd)/parts/mongrel2/bin/m2sh
SUPERVISORCTL = bin/supervisorctl

run-mongrel: $(MONGREL2_CONFIG_SQLITE)
	$(MKDIR) -p $(MONGREL2_ROOT)/run
	$(MKDIR) -p $(MONGREL2_ROOT)/logs
	$(MKDIR) -p $(MONGREL2_ROOT)/tmp
	$(SUPERVISORCTL) start mongrel2

mongrel2-config-sqlite: $(MONGREL2_CONFIG_SQLITE)

$(MONGREL2_CONFIG_SQLITE): $(MONGREL2_CONFIG_FILE) $(M2SH)
	( cd $(MONGREL2_ROOT) && $(M2SH) load -config mysite.conf )

$(M2SH): bin/buildout

run-buildout: bin/buildout
	bin/buildout

test: run-mongrel test_mongrel2.py
	python test_mongrel2.py -v

bin/buildout: bootstrap.py
	python bootstrap.py

clean:
	$(RM) -r bin develop-eggs parts var .installed.cfg $(MONGREL2_CONFIG_SQLITE) $(MONGREL2_ROOT)/run $(MONGREL2_ROOT)/logs $(MONGREL2_ROOT)/tmp
