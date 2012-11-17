MKDIR = mkdir

MONGREL2_ROOT = mongrel2-root
MONGREL2_CONFIG_FILE = $(MONGREL2_ROOT)/mysite.conf
MONGREL2_CONFIG_SQLITE = $(MONGREL2_ROOT)/config.sqlite
M2SH := $(shell pwd)/parts/mongrel2/bin/m2sh
SUPERVISORD = bin/supervisord
SUPERVISORCTL = bin/supervisorctl
BOOTSTRAP_PY_URL = http://svn.zope.org/*checkout*/zc.buildout/trunk/bootstrap/bootstrap.py
WGET = wget

run-mongrel: $(MONGREL2_CONFIG_SQLITE)
	$(MKDIR) -p $(MONGREL2_ROOT)/run
	$(MKDIR) -p $(MONGREL2_ROOT)/logs
	$(MKDIR) -p $(MONGREL2_ROOT)/tmp
	$(SUPERVISORD)
	# $(SUPERVISORCTL) start mongrel2

mongrel2-config-sqlite: $(MONGREL2_CONFIG_SQLITE)

$(MONGREL2_CONFIG_SQLITE): $(MONGREL2_CONFIG_FILE) $(M2SH)
	( cd $(MONGREL2_ROOT) && $(M2SH) load -config mysite.conf )

$(M2SH): bin/buildout buildout.cfg
	bin/buildout

run-buildout: bin/buildout buildout.cfg
	bin/buildout

test: run-mongrel test_mongrel2.py
	python test_mongrel2.py -v

bin/buildout: bootstrap.py
	python bootstrap.py

bootstrap.py:
	$(WGET) -O bootstrap.py $(BOOTSTRAP_PY_URL)

clean:
	$(RM) -r bin develop-eggs parts var .installed.cfg $(MONGREL2_CONFIG_SQLITE) $(MONGREL2_ROOT)/run $(MONGREL2_ROOT)/logs $(MONGREL2_ROOT)/tmp
