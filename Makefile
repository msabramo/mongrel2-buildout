run-buildout: bin/buildout
	bin/buildout

bin/buildout: bootstrap.py
	python bootstrap.py

clean:
	$(RM) -r bin develop-eggs parts var .installed.cfg
