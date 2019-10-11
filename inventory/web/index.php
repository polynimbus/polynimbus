<?php

$file = "/var/cache/polynimbus/inventory/projects-aws.list";
$date = date("Y-m-d H:i:s", filemtime($file));

require "include/page.php";
page_header("Polynimbus: the future of the cloud");

?>
<div style="font-size:13px;">
<img src="assets/logo.png" alt="Polynimbus" style="max-width:20%;"></a>
<br />
<br />
Available resources:
<br />
<ul>
	<li><a href="instances.php">list of cloud instances (on all providers and configured accounts)</a></li>
	<li><a href="databases.php">list of RDS databases</a></li>
	<li><a href="zones.php">list of Route53 hosted zones (domains)</a></li>
	<li><a href="google-users.php">list of Google Cloud users and permissions (in all linked projects)</a></li>
</ul>
<br />
<?php

echo "Configured AWS accounts as of $date:<br /><ul>\n";
$data = file_get_contents($file);
$lines = explode("\n", $data);

foreach ($lines as $line) {
	$account = trim($line);
	if (empty($account))
		continue;

	$link = get_account_link("aws", $account);
	echo "<li>$link</li>\n";
}

echo "</ul></div>";
page_end();
