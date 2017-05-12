#!/usr/bin/perl
use strict;
use Getopt::Long;
#use JSON qw( decode_json );
#use LWP;
#use HTTP;

#!/usr/bin/perl
#
#  GitHub Documentation this wrapper is based off of:
#
#  https://developer.github.com/v3/orgs/teams/#list-teams
#
#  The intent of this script is to provide a simple example that
#  spells out the variables needed to create a team via the API,
#  allows a user to plug in the variables needed to run a curl command,
#  and optionally see the results of the command, the JSON output,
#  or just turn and burn
#
# Assumptions
#
#  The user of this script is an application admin or has read the API 
#  link above and verified that he or she has the proper application permissions
#  The user of this script has created a properly scoped API token within GitHub
#  and has access to that token 
#  https://help.github.com/articles/creating-an-access-token-for-command-line-use/
# 
# Dependents:
#
# Perl
#   install Getopt::Long : cpan install Getopt
#   install File::Which :  cpan install File::Which
# System
#  curl command within $PATH
#

my ($host,$http,$token,$server,$verbose,$help,$ssl,$org);

GetOptions('help'  => \$help,
    'id=s'      => \$token,
    'ssl'       => \$ssl,
    'org=s'     => \$org,
    'verbose'   => \$verbose,
    'github=s'  => \$host)
    or warn "Failed to parse options\n" and usage(1);

if ($help) {usage(0);}

if (not $host or not $token) {usage(1);}

if (not $ssl) {$http = "http";}
else {$http = "https";}

my $url = "https://$host/api/v3/orgs/$org/teams?access_token=$token";
my $cmd = 'curl -i \'' . $url . '\''; 

if (not $verbose) 
{ 
    system($cmd); 

}
else 
{
    system($cmd);
    print "\n Executed Command:\n $cmd \n";
}

sub usage
{
    my $exit = shift;
    my $fh   = $exit ? \*STDOUT : \*STDERR;

    print "\n";
    print <<"END_OF_USAGE";
Usage: $0 [-help] -server -org -id

    -(h)elp        This help message

    -(g)ithub      FQDN of the GHE server

    -(i)d          Token used to access the server 
                   (applicaiton admin access required)

    -(o)rg         Organization to be queried
       
    -(s)sl         Specify whether or not to use https
END_OF_USAGE
    exit $exit;
}

