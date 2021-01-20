server {
    server_name gud.digiteqautomotive.com;
    access_log /var/log/nginx/gud.access.log;
    
    location / {
		
	proxy_set_header	Host $host;
	proxy_set_header	X-Real-IP $remote_addr;
	proxy_set_header	X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header	X-Forwarded-Proto $scheme;
	
	proxy_pass	http://192.168.9.50/;
	proxy_read_timeout	90;
	proxy_redirect	http://192.168.9.50/ http://gud.digiteqautomotive.com;
	}

    listen 443 ssl;
    ssl_certificate /etc/nginx/ssl/gud.pem;
    ssl_password_file /etc/nginx/ssl/passwd;
    ssl_certificate_key /etc/nginx/ssl/gud.key;
    
}

server {
    if ($host = gud.digiteqautomotive.com) {
        return 301 https://$host$request_uri;
    }

    server_name gud.digiteqautomotive.com;
    listen 80;
    return 404;

}
