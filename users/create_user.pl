#!/usr/bin/perl
use strict;
use Getopt::Long;

#
#  GitHub Documentation this wrapper is based off of:
#
#  https://developer.github.com/v3/orgs/teams/#create-team
#
#  The intent of this script is to provide a simple example that
#  spells out the variables needed to add a user to a team via the API,
#  allows a user to plug in the variables needed to run a curl command,
#  and optionally see the results of the command, and JSON output,
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

my ($http,$ssl,$user,$email,$host,$repo,$help,$token,$verbose);

GetOptions('help'   => \$help,
    'user=s'    => \$user,
    'email=s'   => \$email,
    'id=s'      => \$token,
    'ssl'       => \$ssl,
    'verbose'   => \$verbose,
    'github=s'  => \$host)
    or warn "Failed to parse options\n" and usage(1);

if ($help) {
    usage(0);
}

if (not $host or not $token or not $user or not $email)
{
    usage(0);
}

if (not $ssl) {$http = "http";}
else { $http = "https";}

my $cmd = 'curl -i -X POST --data \'{"login":"' . $user . '","email":"' . $email . '"}\' \'' . $http . '://' . $host . '/api/v3/admin/users/?access_token=' . $token . '\&since=0\'';

# backticks will return the command output from curl
if (not $verbose) {`$cmd`;}
# System returns the return code which in this case is the JSON data
else 
{
    print "$cmd \n";
    system($cmd);}



sub usage
{
    my $exit = shift;
    my $fh   = $exit ? \*STDOUT : \*STDERR;

    print "\n";
    print <<"END_OF_USAGE";
Usage: $0 [-help] -user -email -github -token

     -(h)elp        This help message
  
     -(e)mail       Email account for user id

     -(i)d          Token used to access GitHub

     -(g)ithub      FQDN of GitHub server or ipaddress

     -(s)sl         Specify if SSL is in use on the Github server
 
     -(v)erbose     If specified, returns JSON data and a sample curl command to STDOUT

     -(u)ser        Name of user id to create 
END_OF_USAGE
    exit $exit;
}

