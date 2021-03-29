# debian-nginx-php

Container with apache and php-fpm in debian 10.

## Options

Options works with enviornment variables with jinja templates and docker entrypoint.

### Explained options

#### NGINX

- __NGINX_WORKER_PROCESSES__: by default is `auto`.

- __NGINX_ENABLE_HTST__: HTTP Strict Transport Security (HSTS) is a web security policy mechanism that helps to protect websites against man-in-the-middle attacks such as protocol downgrade attacks and cookie hijacking.Read more on [`HSTS`](https://es.wikipedia.org/wiki/HTTP_Strict_Transport_Security)

  - NGINX_HSTS_MAXAGE: MAXAGE is `3600` by default, and may be set to `31536000` on production.

- __NGINX_STATUS_PATH__: basic page showing the server status. default: `/nginx-status`

- __CLIENT_MAX_BODY_SIZE__: Sets the maximum size of the buffer body. If the size in a request exceeds the value configured in this parameter, the following error will be returned to the client: 413 (Request Entity Too Large — requested entity is too large). `ie: 32M`

- __CLIENT_HEADER_BUFFER_SIZE__: Handles the size of the header assigned to the client.`ie: 1k`

- __CLIENT_HEADER_TIMEOUT__: Shows the maximum number and size of buffers for larger client headers. `ie: 4 4k`

- __CLIENT_BODY_TIMEOUT__: send directives for the time a server will wait for a body to be sent. `ie: 3m`

- __SEND_TIMEOUT__: specifies the time to wait for the response to the client. `ie: 3m`

- __TYPES_HASH_MAX_SIZE__: Defines the maximum size of an entry in the MIME types hash tables. `default: 2048`

- __NGINX_SSL_PROTOCOLOS__: Defines the SSL protocols allowed. Default: `TLSv1 TLSv1.1 TLSv1.2`

- __NGINX_ACCESS_LOG__: Define Access Log Path. Default: `/dev/stdout`

- __NGINX_ERROR_LOGS__: Degine Error Log Path. Default: `/dev/stderr`

- __NGINX_ENABLE_CORS__: Add `Access-Control-Allow-Origin Header`. Read more on [`CORS`](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing). By default `false`.
  - __APACHE_CORS_ORIGIN__:  By default `'*'`.
  - __APACHE_CORS_METHODS__: By default `'GET, POST, OPTIONS'`

#### PHP & PHP-FPM

- __PHP_VESION__: Define PHP version.

- __PHPFPM_REQUEST_SLOW_TIMEOUT__: Time that defines when a request is marked as slow. Default: `5s`.

- __PHPFPM_REQUEST_SLOW_PATH__: Location of the path where it saves the slow requests Default `/var/log/php-fpm/slowlog.log`

- __PHPFPM_PROC_MANAGER__: The process manager will control the number of child processes.

- __PHPFPM_MAX_CHILDREN__: The process manager will control the number of child processes.

- __PHPFPM_START_SERVERS__: The number of children created on startup.

- __PHPFPM_MIN_SPARE_SERVERS__: The minimum number of children in 'idle'
state (waiting to process). If the number of 'idle' processes is less than this

- __PHPFPM_MAX_SPARE_SERVER__:The maximum number of children in 'idle' state (waiting to process). If the number of 'idle' processes is greater than this

- __PHPFPM_PROC_IDLE_TIMEOUT__: The number of seconds after which an idle process will be killed.

- __PHPFPM_MAX_REQUESTS__: The number of requests each child process should execute before respawning.

- __PHPFPM_STATUS_PATH__: Basic page showing the server status. default: `/fpm-status`

- __PHP_DISPLAY_ERRORS__: Allows us to display all errors, including parsing or syntax errors.

- __PHPFPM_LOG_ERRORS__: Allows us to display all errors, including parsing or syntax errors.

- __PHPFPM_ERROR_LOG_PATH__: Define the path where the detected errors will be saved.

- __PHP_MEM_LIMIT__: The configured PHP memory limit is applied to each child process running the application, which can consume memory up to that limit before it exits.

- __PHPFPM_MEM_LIMIT__: The configured PHP-FPM memory limit is applied to each child process running the application, which can consume memory up to that limit before it exits.

- __PHP_MAX_INPUT_VARS__: Is the maximum number of variables your server can use for a single function.

- __PHP_MAX_FILE_UPLOADS__: The maximum number of files allowed to be uploaded simultaneously.

- __PHP_MAX_EXECUTION_TIME__: Define maximum execution time of php scripts.

- __PHP_UPLOAD_MAX_FILESIZE__: Maximum size a file can have for upload.

- __PHP_POST_MAX_SIZE__: Determines the maximum amount of data that can be transferred using the POST method. If you want to upload large files using a form, the value must be greater than upload_max_filesize.

- __PHPFPM_ENABLE_OPCACHE__: Determine whether to enable or disable the opcache module.

- __PHPFPM_CLEAR_ENV__: Prevents arbitrary environment variables from reaching FPM worker processes by clearing the environment in workers before env vars specified in this pool configuration are added.

- __PHP_ENABLE_SHORT_OPEN_TAG__: Allows the interpreter to accept any line of code between the `<? and ?>`