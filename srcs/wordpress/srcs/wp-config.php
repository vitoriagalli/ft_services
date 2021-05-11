<?php
    define( 'DB_NAME', 'wordpress' );
    define( 'DB_USER', 'admin' );
    define( 'DB_PASSWORD', 'admin' );
    define( 'DB_HOST', 'mysql' );
    define( 'DB_CHARSET', 'utf8mb4' );
    define( 'DB_COLLATE', '' );
    
    define('AUTH_KEY',         'T>bUlOc1|yJrbp${0sgoUI%!5TgF}4=-GJe+@4U8cMnGmH+*uP$%|i-.RH@Dz0g4');
    define('SECURE_AUTH_KEY',  'oYAy2)8>8^B$$}yO<{|K@1U3Py_#faWd(|i)32wvAhw^fL+)7SEyNIJ=LFqo%=9+');
    define('LOGGED_IN_KEY',    'nvl;-9~BAJBXi4~/*2_i{Edg 2%iO;lwu,r(fIBD//+v,:lRiI5v|vf_;DidUo]F');
    define('NONCE_KEY',        'X|;CG|zE0>-8MsfjcG b:#N7e50casBS`Lwzt$.3k*]ZT)H~#e<]M[9k+joH`Y.a');
    define('AUTH_SALT',        'v?uSp`q!?{1gkK[ aQAq+9l5;.{S}C:uRt<Q9Ai/zSw+enL:tPJ_TSz%jp)-AWTc');
    define('SECURE_AUTH_SALT', '=BcXA`_&`43az^M&VDK*f`|]&L6W^-g_(h=Ca:4p[NUxF;X@/ZEqVK+hvh?s}?%+');
    define('LOGGED_IN_SALT',   '~y7< PeKm,M#(d5L^TYf4zb}RB4&bj&Y^==mC+&!UOM&J6*&-e=D=egUPoA^,wiG');
    define('NONCE_SALT',       'Zla8-Fpw+`$h-z360L-W&q)n(%$TM3jut1lMJJ%( 4=9P*DBR&#e>rN>g-ClT5B1');
    $table_prefix = 'wp_';
    
    define( 'WP_DEBUG', false );
    if ( ! defined( 'ABSPATH' ) ) {
    	define( 'ABSPATH', __DIR__ . '/' );
    }
    require_once ABSPATH . 'wp-settings.php';