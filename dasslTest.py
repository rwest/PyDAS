#!/usr/bin/env python
# -*- coding: utf-8 -*-

import dassl
import numpy as np

class MyModel(dassl.DASSL):
	
	def residual(self, t, y, dydt):
		delta = np.zeros(y.shape[0], np.float64)
		delta[0] = -y[0] - dydt[0]
		return delta, 0
	
	#def jacobian(self, t, y, dydt, cj):
	#	pd = np.zeros((y.shape[0],y.shape[0]), np.float64)
	#	pd[0,0] = -1 - cj
	#	return pd
	
d = MyModel()
d.initialize(0, [1.0])
d.advance(1.0)
print d.t, d.y
