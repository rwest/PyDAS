#!/usr/bin/env python
# -*- coding: utf-8 -*-

import dassl
import numpy as np

class MyModel(dassl.DASSL):
	
	def residual(self, t, y, dydt):
		delta = np.zeros(y.shape[0], np.float64)
		delta = -y - dydt
		return delta, 0
	
	def jacobian(self, t, y, dydt, cj):
		pd = np.ones(y.shape[0], np.float64)
		pd = pd * (-1 - cj)
		return np.diag(pd)
	
d = MyModel()
d.initialize(0, [1.0, 2.0, 10.0])
d.advance(1.0)
print d.t, d.y
