#!/usr/bin/perl

use strict;

my $tmpstr ="
               <item>
                    <name>ITEM_SAMPLE.::MYNMB::</name>
                    <type>0</type>
                    <snmp_community/>
                    <snmp_oid/>
                    <key>kernel.maxfiles.::MYNMB::</key>
                    <delay>30s</delay>
                    <history>90d</history>
                    <trends>365d</trends>
                    <status>::MYSTAT::</status>
                    <value_type>3</value_type>
                    <allowed_hosts/>
                    <units/>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <params/>
                    <ipmi_sensor/>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port/>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications/>
                    <valuemap/>
                    <logtimefmt/>
                    <preprocessing/>
                    <jmx_endpoint/>
                    <timeout>3s</timeout>
                    <url/>
                    <query_fields/>
                    <posts/>
                    <status_codes>200</status_codes>
                    <follow_redirects>1</follow_redirects>
                    <post_type>0</post_type>
                    <http_proxy/>
                    <headers/>
                    <retrieve_mode>0</retrieve_mode>
                    <request_method>0</request_method>
                    <output_format>0</output_format>
                    <allow_traps>0</allow_traps>
                    <ssl_cert_file/>
                    <ssl_key_file/>
                    <ssl_key_password/>
                    <verify_peer>0</verify_peer>
                    <verify_host>0</verify_host>
                    <master_item/>
                </item>
";

print "hello,\n";
my $inp = '/Users/manabu/develop/perl/zbx_export_templates.xml';
open(FILE,$inp) or die "$!";
while(<FILE>){
  if ($_ =~ "</items>"){
     my $lmt=30;
     my $i;
     for ($i=3;$i<10;$i++){
        my $tmpstr2 = $tmpstr;
        $tmpstr2 =~ s/::MYNMB::/$i/g;
        $tmpstr2 =~ s/::MYSTAT::/1/g;
        print $tmpstr2,"\n";
     }
     print "\n $_";
     
  }else{
     print $_;
  }
}
close FILE;


print ",end\n";
