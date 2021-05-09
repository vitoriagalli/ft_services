<?php
    define( 'DB_NAME', 'wordpress' );
    define( 'DB_USER', 'admin' );
    define( 'DB_PASSWORD', 'admin' );
    define( 'DB_HOST', 'mysql' );
    define( 'DB_CHARSET', 'utf8mb4' );
    define( 'DB_COLLATE', '' );
    
    define('AUTH_KEY',         '6yTp#`?Z5[gd`sYV>S+O-mbZ#IW-:p;bWY95 3nTu|d=Y3/db>n=r}2I59s|*-[l');
    define('SECURE_AUTH_KEY',  'l]Et Sz|L7yPzBHq2T%Uq3IcWPp08;GN:l2>lsOCUXd~tJKIB$~?6/^$*M-U~7_<');
    define('LOGGED_IN_KEY',    'fT2[ATB0b/$}2Mnts73-V=iN-e-*FpFB%P-||a/9|=CF>UhZ(kdtJzKaQCPfW|sw');
    define('NONCE_KEY',        'cbj+^)Yq&_ 8vP`Bhf7pgYDB7}l*L(}^*$RdwTFiRK4^[@Yh@|a|uu0LGUu)>ne2');
    define('AUTH_SALT',        '6~f~6++*XDe|`elvncg3,{vYN*9Dd%k+b:8HGOe+rv6ul/3y<c/0+,{tiRX!5su^');
    define('SECURE_AUTH_SALT', 'J>n{Et {z^XVJr8(ti[fii9*</#<_ 0ZS|+W{No)kE/f|+s=M0y8f]0aFe~R+:hf');
    define('LOGGED_IN_SALT',   'H}@D!y2%Tfz(Ytd$:pUp]iz`&SQmI!Y}U3ORLjijdHd=ox,j3$Vh9]/vS-](0MF=');
    define('NONCE_SALT',       ':0Wu%>cjPJ|b4{TSuGwCk%K~nQ@qNbo3y-f|cp$ay~2M+qrJN-_n#-!7( +IW!j<');

    $table_prefix = 'wp_';
    
    define( 'WP_DEBUG', false );
    if ( ! defined( 'ABSPATH' ) ) {
    	define( 'ABSPATH', __DIR__ . '/' );
    }
    require_once ABSPATH . 'wp-settings.php';