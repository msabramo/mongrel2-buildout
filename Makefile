run-buildout: bin/buildout
	bin/buildout

test: test_mongrel2.py
	python test_mongrel2.py -v

bin/buildout: bootstrap.py
	python bootstrap.py

clean:
	$(RM) -r bin develop-eggs parts var .installed.cfg
