<?php

$file = "/var/cache/polynimbus/web/instances.list";
$date = date("Y-m-d H:i:s", filemtime($file));

?>
<!DOCTYPE html>
<html>
<head>
	<title>Polynimbus - cloud instances inventory</title>
	<meta http-equiv="X-UA-Compatible" content="chrome=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="shortcut icon" href="assets/favicon.png">
	<link rel="stylesheet" href="assets/style.css" type="text/css" media="screen, all" />
	<script type="text/javascript" src="assets/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="assets/jquery.tablesorter.min.js"></script>
</head>
<body style="font-size:11px;font-family:verdana,helvetica,arial,sans-serif;">
<strong>List of all cloud instances as of <?php echo $date; ?></strong><br />
<table id="instances" class="tablesorter">
	<thead>
	<tr>
		<th>vendor</th>
		<th>account</th>
		<th>hostname</th>
		<th>state</th>
		<th>ssh-key</th>
		<th>location</th>
		<th>instance-type</th>
		<th>instance-id</th>
		<th>image-name</th>
		<th>optional</th>
	</tr>
	</thead>
	<tbody>
<?php

$data = file_get_contents($file);
$lines = explode("\n", $data);

foreach ($lines as $line) {
	$line = trim($line);
	if (empty($line))
		continue;

	$tmp = explode(" ", $line, 10);

	echo "\t<tr>\n";
	echo "\t\t<td>$tmp[0]</td>\n";
	echo "\t\t<td>$tmp[1]</td>\n";
	echo "\t\t<td>$tmp[2]</td>\n";
	echo "\t\t<td>$tmp[3]</td>\n";
	echo "\t\t<td>$tmp[4]</td>\n";
	echo "\t\t<td>$tmp[5]</td>\n";
	echo "\t\t<td>$tmp[6]</td>\n";
	echo "\t\t<td>$tmp[7]</td>\n";
	echo "\t\t<td>$tmp[8]</td>\n";
	echo "\t\t<td>$tmp[9]</td>\n";
	echo "\t</tr>\n";
}

?>
	</tbody>
</table>

<script>
jQuery(document).ready(function() {
	jQuery("#instances").tablesorter();
});
</script>

</body>
</html>
