#!/usr/bin/python
# -*- coding: utf-8 -*-

if __name__ == '__main__':
	
	from distutils.core import setup
	from distutils.extension import Extension
	from Cython.Distutils import build_ext
	
	import Cython.Compiler.Options
	Cython.Compiler.Options.annotate = True
	
	import numpy
	
	
	# Stop wasting my time compiling PowerPC-compatible C extensions on my intel Mac
	# especially important as we didn't build a PPC version of dassl.o
	import distutils.sysconfig
	config = distutils.sysconfig.get_config_vars()
	for key,value in config.iteritems():
		location = str(value).find('-arch ppc')
		if location>=0:
			print "removing '-arch ppc' from %s"%(key)
			config[key] = value.replace('-arch ppc ','')
	# Tip from Lisandro Dalcin:
	# FYI, in Py>=2.6 the ARCHFLAGS environ var is honored by distutils, so
	# you should be able to
	#  export ARCHFLAGS='-arch i386' # or '-arch x86_64'
	# and get your job done.
	
	
	# The Cython modules to setup
	ext_modules = [
		Extension('dassl', ['dassl.pyx'], 
			library_dirs=['dassl'], 
			libraries=['gfortran', 'ddassl'],
			include_dirs = [ numpy.get_include() ] # location of numpy headers
			),
	]

	setup(cmdclass = {'build_ext': build_ext},
		ext_modules = ext_modules
	)
