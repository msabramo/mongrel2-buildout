SHELL = /bin/bash
MKDIR = mkdir
WGET = wget

PYTHON_VERSION := $(shell python -V 2>&1)
MONGREL2_ROOT := $(shell pwd)/mongrel2-root
MONGREL2_CONFIG_FILE = $(MONGREL2_ROOT)/mysite.conf
MONGREL2_CONFIG_SQLITE = $(MONGREL2_ROOT)/config.sqlite
M2SH := $(shell pwd)/parts/mongrel2/bin/m2sh
PROCER := $(shell pwd)/parts/mongrel2/bin/procer
BOOTSTRAP_PY_URL = http://svn.zope.org/*checkout*/zc.buildout/branches/2/bootstrap/bootstrap.py

run-mongrel: $(MONGREL2_CONFIG_SQLITE)
	$(MKDIR) -p $(MONGREL2_ROOT)/run
	$(MKDIR) -p $(MONGREL2_ROOT)/logs
	$(MKDIR) -p $(MONGREL2_ROOT)/tmp
	$(PROCER) $(MONGREL2_ROOT)/profiles $(MONGREL2_ROOT)/run/procer.pid

mongrel2-config-sqlite: $(MONGREL2_CONFIG_SQLITE)

$(MONGREL2_CONFIG_SQLITE): $(MONGREL2_CONFIG_FILE) $(M2SH)
	( cd $(MONGREL2_ROOT) && $(M2SH) load -config mysite.conf )

$(M2SH): bin/buildout buildout.cfg
	if [[ "$(PYTHON_VERSION)" == Python\ 3* ]]; then echo "*** Python 3 ***"; bin/buildout -c buildout-py3.cfg; else echo "*** Python 2 ***"; bin/buildout; fi

run-buildout: bin/buildout buildout.cfg
	bin/buildout

test: test_mongrel2.py
	python test_mongrel2.py -v

bin/buildout: bootstrap.py
	python bootstrap.py

bootstrap.py:
	$(WGET) -O bootstrap.py $(BOOTSTRAP_PY_URL)

clean:
	$(RM) -r bin develop-eggs parts var .installed.cfg $(MONGREL2_CONFIG_SQLITE) $(MONGREL2_ROOT)/run $(MONGREL2_ROOT)/logs $(MONGREL2_ROOT)/tmp
