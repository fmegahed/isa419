
source('class_code/apikey.R') # will put my key in an object called
# api_key_ipstack

# * IP Addresses Manual Computation ---------------------------------------

q1 = 1*(2^8)^0 # 0.0.0.1
q2 = 3*(2^8)^0 # 0.0.0.3
q3 = (1*(2^8)^1) + 0 # 0.0.1.0
q4 =  (1*(2^8)^1) + 240 # 0.0.1.240
q5 = (100*(2^8)^1) + 240 # "0.0.100.240"



# * The R Pkg Approach ----------------------------------------------------
pacman::p_load(iptools)


q5_auto = ip_to_numeric("0.0.100.240")

ips = c('0.0.0.1', '0.0.0.3', '0.0.1.0', '0.0.1.240', '0.0.100.240')
q1_q5 = ip_to_numeric(ips)

q1_q5_string = numeric_to_ip(q1_q5)



# * Picking a Couple of IP Addresses Based on TracemyIP -------------------

pacman::p_load(jsonlite) # to read JSON responses

visitor_ips = c('134.53.120.251', '185.33.134.168',
                '129.171.249.67')


# * * Reading it for one ip address ---------------------------------------

url_initial = 'http://api.ipstack.com/'
middle_part = '134.201.250.155' # will change each time
end_part = '?access_key='

api_tbl = data.frame() # initializing the output from the for loop

complete_url = paste0(url_initial, middle_part, end_part,
                      api_key_ipstack)

api_resp = fromJSON(complete_url)

ip = api_resp$ip
type = api_resp$type
country = api_resp$country_name
lat = api_resp$latitude
long = api_resp$longitude

temp_df = data.frame(ip, type, country, lat, long)
api_tbl = rbind(api_tbl, temp_df)


# * * Reading multiple ip addresses ---------------------------------------

visitor_ips = c('134.53.120.251', '185.33.134.168',
                '129.171.249.67')

url_initial = 'http://api.ipstack.com/'
end_part = '?access_key='

api_tbl = data.frame() # initializing the output from the for loop

for (counter in 1:length(visitor_ips)) {
  current_ip = paste0(
    url_initial, visitor_ips[counter], end_part,
    api_key_ipstack
  )
  
  api_resp = fromJSON(current_ip)
  
  ip = api_resp$ip
  type = api_resp$type
  country = api_resp$country_name
  lat = api_resp$latitude
  long = api_resp$longitude
  
  temp_df = data.frame(ip, type, country, lat, long)
  api_tbl = rbind(api_tbl, temp_df)
}




