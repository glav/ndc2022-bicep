
param environment string

var someObject = {
  prop1: null
  prop2: 'all-good'
}

var capacityInGb = 200
var sqlCapacityActualValue = capacityInGb * 1024 * 1024 * 1024

var coalesceOp = someObject.prop1 ?? '123'

var isProd = environment == 'prd'

var vmSeries = isProd ? 'Standard_D4_v3' : 'Standard_B2ms'  // Use burstable VM's for non prod

output sqlCapacityFigure int = sqlCapacityActualValue  // 214748364800
output isProduction bool = isProd   // if 'dev' or 'uat', then false, else true
output isItNull string = coalesceOp // '123'
output vmSeries string = vmSeries
