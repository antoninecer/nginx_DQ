server {
    server_name cansim.digiteqautomotive.com;
    access_log /var/log/nginx/cansim.access.log;

    
    location / {
    
	proxy_set_header	Host $host;
	proxy_set_header	X-Real-IP $remote_addr;
	proxy_set_header	X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header	X-Forwarded-Proto $scheme;
	
	proxy_pass	http://192.168.9.2;
	proxy_read_timeout	90;
	proxy_redirect	https://192.168.9.2 https://cansim.digiteqautomotive.com;
	}


}