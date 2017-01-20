#!/usr/bin/perl
#
#  GitHub Documentation this wrapper is based off of:
#
#  https://developer.github.com/v3/orgs/teams/#create-team
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
#
 
use strict;
use Getopt::Long;
use File::Which;

my ($host,$http,$token,$help,$verbose);

GetOptions('help'  => \$help,
    'id=s'         => \$token,
    'github=s'     => \$host,
    'ssl'          => \$http,
    'verbose'      => \$verbose)
    or warn "Failed to parse options\n" and usage(1);

my %paths;
$paths{curl} = which('curl');

my $maint = "maintainer";

if ($help) {
    usage(0);
}

if (not $user or not $token)
{
    usage(0);
}


sub usage
{
    my $exit = shift;
    my $fh   = $exit ? \*STDOUT : \*STDERR;

    print "\n";
    print <<"END_OF_USAGE";
Usage: $0 [-help] -team <numeric id of team> -user <github user name>

     -(h)elp        This help message

     -(g)ithub      FQDN of GitHub server or ipaddress

     -(i)d          Token used to access the Github Server

     -(s)sl         Specify if SSL is in use on the Github server
 
     -(v)erbose     If specified, returns the command run and JSON data to STDOUT

END_OF_USAGE
    exit $exit;
}

my $cmd = 'curl -i -X PUT --data \'{"role":"' . $perms . '"}\' \'' . $http . '://' . $host . '/api/v3/teams/' . $team_id . '/memberships/' . $user . '?access_token=' . $token . '\'';

# backticks returns the output from curl
if (not $verbose) { `$cmd`; }
# System will return the return code which in this case is the JSON data
else 
{ 
    print "$cmd \n";
    system($cmd);
}
