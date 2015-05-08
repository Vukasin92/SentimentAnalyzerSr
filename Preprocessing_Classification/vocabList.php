<?php
//Author: Vukasin Stefanovic, vukasin.stefanovic92@gmail.com
// This work is done as part of bachelor thesis of Vukasin Stefanovic on University
// of Belgrade, School of Electrical Engineering
//This program is free software: you can redistribute it and/or modify it under
//the terms of the GNU General Public License as published by the Free Software
//Foundation, either version 3 of the License, or (at your option) any later
//version.
//This program is distributed in the hope that it will be useful, but WITHOUT
//ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
//details.
//You should have received a copy of the GNU General Public License along with
//this program. If not, see http://www.gnu.org/licenses/.

	$input = file_get_contents('reviewsStemmed.json');
	$json_input = json_decode($input, true);
	$counts = array();
	foreach ($json_input as $i => $value) {
		$revBody = $value["reviewBody"];
		$revBody = trim($revBody);
		$tokens = explode(" ",$revBody );
		for($j=0;$j<count($tokens);$j++) {
			if (array_key_exists($tokens[$j], $counts)) {
				$counts["$tokens[$j]"] = $counts["$tokens[$j]"]+1;
			}
			else {
				$counts["$tokens[$j]"] = 1;
			}
		}
	}
	$myFile = "vocab.txt";
	$fh = fopen($myFile, 'a') or die("can't open file");
	$k = 1;
	foreach($counts as $word => $count) {
		if ($count>3) {
			fwrite($fh, $k);
			fwrite($fh, "\t");
			fwrite($fh, $word);
			fwrite($fh, "\t");
			fwrite($fh, $count);
			fwrite($fh, "\n");
			$k++;
		}
	}
	fclose($fh);
?>