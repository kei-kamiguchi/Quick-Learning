# server '13.115.47.180', user: 'app', roles: %w{app db web}
server '54.168.106.1', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/kei/.ssh/id_rsa'
