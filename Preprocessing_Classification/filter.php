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

	$englishWordsStr = file_get_contents("EnglishWords.txt");
	$englishWords = explode(" ",$englishWordsStr);

	$input = file_get_contents('reviewsAll.json');
	$json_input = json_decode($input, true);
	$myFile = "reviews.json";
	$fh = fopen($myFile, 'w') or die("can't open file");
	fwrite($fh, "[");
	foreach ($json_input as $i => $value) {
		if ($i % 100 == 0) echo $i . " ";
		$rating = $value["reviewRating"][0];
		if ($rating == "0.0")
			continue;
		
		$full_body = "";
		foreach($value["reviewBody"] as $j => $revBody) {
			$full_body = $full_body . " " . $revBody;
		}
		$skip = false;
		foreach($englishWords as $englishWord) {
			if (strpos($full_body, $englishWord) !== false) {
				$skip = true;
				break;
			}
		}
		if ($skip)
			continue;
		
		$review = array("reviewBody" => $full_body, "reviewRating" => $rating);
		$json_output = json_encode($review);
		fwrite($fh, $json_output);
		if ($i == sizeof($json_input)-1) {
			fwrite($fh, "]");
		}
		else {
			fwrite($fh, ", ");
		}
	}
	fclose($fh);
?>