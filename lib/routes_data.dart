final Map<String, List<Map<String, String>>> routesData = {
  'Jeepney': [
    {'from': 'San Juan', 'to': 'Watsons', 'status': 'Running'},
    {'from': 'San Fernando Plaza', 'to': 'Bauang', 'status': 'Idle'},
    {'from': 'Bacnotan', 'to': 'Tanqui', 'status': 'Running'},
    {'from': 'Tanqui', 'to': 'Bacnotan', 'status': 'Idle'},
    {'from': 'Naguilian', 'to': 'Tanqui', 'status': 'Running'},
    {'from': 'Bauang', 'to': 'San Fernando Plaza', 'status': 'Idle'},
    {'from': 'Tanqui', 'to': 'San Gabriel', 'status': 'Running'},
  ],
  'E-Jeepney': [
    {'from': 'Tanqui', 'to': 'Naguilian', 'status': 'Running'},
    {'from': 'Naguilian', 'to': 'Tanqui', 'status': 'Idle'},
    {'from': 'Tanqui', 'to': 'Naguilian', 'status': 'Running'},
    {'from': 'Tanqui', 'to': 'Naguilian', 'status': 'Running'},
    {'from': 'Naguilian', 'to': 'Tanqui', 'status': 'Idle'},
    {'from': 'Tanqui', 'to': 'Naguilian', 'status': 'Running'},
    {'from': 'Naguilian', 'to': 'Tanqui', 'status': 'Idle'},
  ],
  'Bus': [
    {'from': 'San Fernando', 'to': 'Bauang', 'status': 'Running'},
    {'from': 'Lingsat', 'to': 'Rosario', 'status': 'Full'},
    {'from': 'Bauang', 'to': 'Agoo', 'status': 'Running'},
    {'from': 'San Fernando', 'to': 'Laoaog', 'status': 'Idle'},
    {'from': 'Partas Carlatan', 'to': 'Baguio', 'status': 'Running'},
    {'from': 'Bacnotan', 'to': 'San Fernando', 'status': 'Full'},
    {'from': 'Agoo', 'to': 'Bauang', 'status': 'Running'},
  ],
};

final List<String> vehicleTypes = ['Jeepney', 'E-Jeepney', 'Bus'];
