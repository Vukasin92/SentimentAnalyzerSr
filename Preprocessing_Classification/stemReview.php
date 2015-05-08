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

	include 'StemmerSr.php';
	
	$input = file_get_contents('reviewSample1.txt');
	$myFile = "reviewSample2.txt";
	$fh = fopen($myFile, 'w') or die("can't open file");
	$full_body = preg_replace("/[^0-9a-zA-Z ]/", "", $input);
	$stemmed_body = stem($full_body);
	fwrite($fh, $stemmed_body);
	fclose($fh);
?>