################################################################################
#
#   PyDAS - A Python wrapper to the DASSL, DASPK, and DASKR solvers
#
#	Copyright (c) 2010 Joshua W. Allen (jwallen@mit.edu)
#
#	Permission is hereby granted, free of charge, to any person obtaining a
#	copy of this software and associated documentation files (the 'Software'),
#	to deal in the Software without restriction, including without limitation
#	the rights to use, copy, modify, merge, publish, distribute, sublicense,
#	and/or sell copies of the Software, and to permit persons to whom the
#	Software is furnished to do so, subject to the following conditions:
#
#	The above copyright notice and this permission notice shall be included in
#	all copies or substantial portions of the Software.
#
#	THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
#	DEALINGS IN THE SOFTWARE.
#
################################################################################

"""
This Cython module exposes the DASSL differential algebraic system solver to
Python and provides a Python extension type, the :class:`DASSL` base class,
for working with DASSL.

To use DASSL, write a Python class or Cython extension type that derives from
the :class:`DASSL` class and implement the :meth:`residual`
method, which accepts :math:`t`, :math:`\\mathbf{y}`, and 
:math:`\\mathbf{\\frac{d \\mathbf{y}}{dt}}` as arguments and returns the
corresponding value of :math:`\\mathbf{g} \\left(t, \\mathbf{y}, \\frac{d \\mathbf{y}}{dt} \\right)`.
Run by calling the :meth:`initialize` method to set the initial conditions
and solver tolerances, then by using the :meth:`advance` or :meth:`step`
methods to move forward or backward in the independent variable. If you 
know the form of the Jacobian, you can implement the :meth:`jacobian`
method to provide it to the solver.

You can implement your derived class in pure Python, but for a significant
speed boost consider using Cython to compile the module. You can see the
proper Cython syntax for the residual and jacobian methods by looking at the
corresponding methods in the :class:`DASSL` base class.
"""

import numpy
cimport numpy
cdef class DASSL:
	"""
	A base class for using the DASSL differential algebraic system solver.
	"""
	
	cdef public int maxOrder
	cdef public object tstop
	cdef public double initialStep
	cdef public double maximumStep
	cdef public object bandwidths
	cdef public bint nonnegative
	
	cdef public double t
	cdef public numpy.ndarray y
	cdef public numpy.ndarray dydt
	
	cdef numpy.ndarray info
	cdef numpy.ndarray atol
	cdef numpy.ndarray rtol
	cdef numpy.ndarray rwork
	cdef numpy.ndarray iwork
	cdef numpy.ndarray rpar
	cdef numpy.ndarray ipar
	cdef int idid
	
	cpdef initialize(self, double t0, y0, dydt0=?, atol=?, rtol=?)
	cpdef advance(self, double tout)
	cpdef step(self, double tout)
	cdef solve(self, double tout)

