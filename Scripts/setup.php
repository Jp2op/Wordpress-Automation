<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $domain = 'local.' . $_POST['domain'] . '.com';
    $output = shell_exec("sudo /usr/local/bin/wp-automate.sh $domain 2>&1");
    echo "<pre>$output</pre>";
}
?>
