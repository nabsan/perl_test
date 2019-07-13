#!/usr/local/bin/perl
use strict;
use Test::XML::XPath tests => 3;

# install -> cpan install Test::XML::XPath  <- first..
like_xpath( '<foo />', '/foo' );   # PASS
like_xpath( '<foo />', '/bar' );   # FAIL
unlike_xpath( '<foo />', '/bar' ); # PASS
 
is_xpath( '<foo>bar</foo>', '/foo', 'bar' ); # PASS
is_xpath( '<foo>bar</foo>', '/bar', 'foo' ); # FAIL
 
# More interesting examples of xpath assertions.
my $xml = '<foo attrib="1"><bish><bosh args="42">pub</bosh></bish></foo>';
 
# Do testing for attributes.
like_xpath( $xml, '/foo[@attrib="1"]' ); # PASS
# Find an element anywhere in the document.
like_xpath( $xml, '//bosh' ); # PASS
# Both.
like_xpath( $xml, '//bosh[@args="42"]' ); # PASS
