package SimplestUtf8AndWin1251Converter;

###########################################################
# This little Perl module lets you work with Cyrillic Windows-1251 alphabets and UTF-8 multi-byte character set, converting Perl strings between these formats. These two encodings are the most popular ones in Russia and Ukraine
# Supports:
#	Source: Windows-1251 (for Cyrillic alphabets)
#		(English, Russian, Ukrainian languages)
#	Target: Utf-8
#		(English, Russian, Ukrainian languages)
# Usage: examine test1() and test2()
# Author: eugeneua aka mueugene aka rezonal aka mreugene
############################################################
#
# To test the module, execute from the command line:
#   perl -I. -e "require './SimplestUtf8AndWin1251Converter.pm'; SimplestUtf8AndWin1251Converter::test2();"
# Please notice. This script will produce UTF-8 output with specific Russian and Ukrainian symbols
#
############################################################
#
# Git repository name: eugeneua/SimplestUtf8AndWin1251Converter__perl_module
#
############################################################

my @utfChars32__255=(
	' ','!','"','#','$','%','&',"'",'(',')','*','+',',','-','.','/','0','1','2','3','4','5','6','7','8','9',':',';','<','=','>','?','@','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','[','\x5C',']','^','_','`','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','{','|','}','~','','\xd0\x82','\xd0\x83','\xe2\x80\x9a','\xd1\x93','\xe2\x80\x9e','\xe2\x80\xa6','\xe2\x80\xa0','\xe2\x80\xa1','\xe2\x82\xac','\xe2\x80\xb0','\xd0\x89','\xe2\x80\xb9','\xd0\x8a','\xd0\x8c','\xd0\x8b','\xd0\x8f','\xd1\x92','\xe2\x80\x98','\xe2\x80\x99','\xe2\x80\x9c','\xe2\x80\x9d','\xe2\x80\xa2','\xe2\x80\x93','\xe2\x80\x94','\xc2\x98','\xe2\x84\xa2','\xd1\x99','\xe2\x80\xba','\xd1\x9a','\xd1\x9c','\xd1\x9b','\xd1\x9f','\x20','\xd0\x8e','\xd1\x9e','\xd0\x88','\xc2\xa4','\xd2\x90','\xc2\xa6','\xc2\xa7','\xd0\x81','\xc2\xa9','\xd0\x84','\xc2\xab','\xc2\xac','\xad\x00','\xc2\xae','\xd0\x87','\xc2\xb0','\xc2\xb1','\xd0\x86','\xd1\x96','\xd2\x91','\xc2\xb5','\xc2\xb6','\xc2\xb7','\xd1\x91','\xe2\x84\x96','\xd1\x94','\xc2\xbb','\xd1\x98','\xd0\x85','\xd1\x95','\xd1\x97','\xd0\x90','\xd0\x91','\xd0\x92','\xd0\x93','\xd0\x94','\xd0\x95','\xd0\x96','\xd0\x97','\xd0\x98','\xd0\x99','\xd0\x9a','\xd0\x9b','\xd0\x9c','\xd0\x9d','\xd0\x9e','\xd0\x9f','\xd0\xa0','\xd0\xa1','\xd0\xa2','\xd0\xa3','\xd0\xa4','\xd0\xa5','\xd0\xa6','\xd0\xa7','\xd0\xa8','\xd0\xa9','\xd0\xaa','\xd0\xab','\xd0\xac','\xd0\xad','\xd0\xae','\xd0\xaf','\xd0\xb0','\xd0\xb1','\xd0\xb2','\xd0\xb3','\xd0\xb4','\xd0\xb5','\xd0\xb6','\xd0\xb7','\xd0\xb8','\xd0\xb9','\xd0\xba','\xd0\xbb','\xd0\xbc','\xd0\xbd','\xd0\xbe','\xd0\xbf','\xd1\x80','\xd1\x81','\xd1\x82','\xd1\x83','\xd1\x84','\xd1\x85','\xd1\x86','\xd1\x87','\xd1\x88','\xd1\x89','\xd1\x8a','\xd1\x8b','\xd1\x8c','\xd1\x8d','\xd1\x8e','\xd1\x8f'
	);

my $incorrectSymbolAlias='?'; #used if char code lower than \x20 (' ')

sub getUtf8Binary{
	my$char=shift;
	if($char eq "\x0d" || $char eq "\x0a" || $char eq "\x09") {return $char};
	my$k=ord$char;
	$k<32 and $k=$incorrectSymbolAlias;
	if($k<128){return "".chr($k)}
	$k-=32;
	my$str=$utfChars32__255[$k];
	$str=~s/\x5Cx(\w+)/
		
		(''.(pack'H2',$1).'')
		
		/sgiex;
	return$str;
}

sub win1251ToUtf8{
	my$a=shift;
	return join'',map{
		getUtf8Binary($_)
		}split//,$a;
}

sub getUtf8FileHeader{
	return "\xEF\xBB\xBF";
}




sub test1{
	my$bPrint=shift;
	my$testString=
		"English encoding. Source: windows-1251\n".
		"English encoding. Target: utf-8\n".
		"English: Jack\n".
		"Russian: Äæåê\n".
		"Russian sample: ¨æ-¸æ\n".
		"Ukrainian sample: ¯æ-¿æ\n".
		"Ukrainian sample: ²êðà-³êðà\n".
		"Ukrainian sample: ¥í³ò-´í³ò\n".
		"Ukrainian sample: ªíîò-ºíîò\n";
	my$fileHead=SimplestUtf8AndWin1251Converter::getUtf8FileHeader();
	my$sUtf8=$fileHead.
		SimplestUtf8AndWin1251Converter::win1251ToUtf8($testString);

	$bPrint and print $sUtf8;
	return $sUtf8;
}

sub test2{
	# shows test1() result via STDOUT
	test1(1);
}

1;

