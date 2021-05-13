#!/bin/sh

# cat << EOF > wp-config.php
# <?php
#     define( 'DB_NAME', '$DB_NAME' );
#     define( 'DB_USER', '$DB_USER' );
#     define( 'DB_PASSWORD', '$DB_PASSWORD' );
#     define( 'DB_HOST', '$DB_HOST' );
#     define( 'DB_CHARSET', 'utf8mb4' );
#     define( 'DB_COLLATE', '' );
    
#     define('AUTH_KEY',         'T>bUlOc1|yJrbp|{0sgoUI%!5TgF}4=-GJe+@4U8cMnGmH+*uP$%|i-.RH@Dz0g4');
#     define('SECURE_AUTH_KEY',  'oYAy2)8>8^B||}yO<{|K@1U3Py_#faWd(|i)32wvAhw^fL+)7SEyNIJ=LFqo%=9+');
#     define('LOGGED_IN_KEY',    'nvl;-9~BAJBXi4~/*2_i{Edg 2%iO;lwu,r(fIBD//+v,:lRiI5v|vf_;DidUo]F');
#     define('NONCE_KEY',        '$^pK_s<E=yaJX;Z/czIA-s9x4a^elzO+|K8mr>DM},6.wALjhd_yOB9ldR-l:SE9');
#     define('AUTH_SALT',        'VMBW@!.Z+,o7|8S{+>d=mR+nSKkwa+<jicY%?|3nt~o:6bLQe~q)<8U~sItCl_7a');
#     define('SECURE_AUTH_SALT', '>Z/%+[?jtP@R)|k~r=?l_Pe~H@TXR8+x5:>U0eG!+Iy#pTNk@ogQZH0_d!QKY|_d');
#     define('LOGGED_IN_SALT',   '~y7< PeKm,M#(d5L^TYf4zb}RB4&bj&Y^==mC+&!UOM&J6*&-e=D=egUPoA^,wiG');
#     define('NONCE_SALT',       'I,50o^vFO%}F8]{L|n+KwY->p(|x%-kdo1|siv0f+]yJ@W>-Cl66?h8<(rW}[Oh~');
#     $table_prefix = 'wp_';
    
#     define( 'WP_DEBUG', false );
#     if ( ! defined( 'ABSPATH' ) ) {
#     	define( 'ABSPATH', __DIR__ . '/' );
#     }
#     require_once ABSPATH . 'wp-settings.php';
# EOF

# mv wp-config.php /var/www/wordpress/

/usr/sbin/php-fpm7 --nodaemonize &

/usr/sbin/nginx -g 'daemon off;'