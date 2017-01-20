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

my ($http,$ssl,$team,$org,$host,$repo,$access,$help,$token,$verbose);

GetOptions('help'   => \$help,
    'org=s' => \$org,
    'repo=s'    => \$repo,
    'id=s'      => \$token,
    'ssl'       => \$ssl,
    'access=s'  => \$access,
    'verbose'   => \$verbose,
    'github=s'  => \$host,
    'team=s'    => \$team)
    or warn "Failed to parse options\n" and usage(1);

if ($help) {
    usage(0);
}

if (not $host or not $token or not $org or not $repo or not $team or not $access)
{
    usage(0);
}

if (not $ssl) {$http = "http";}
else { $http = "https";}

my $cmd = 'curl -i -X POST --data \'{"name":"' . $team . '","repo_names":["' . $org . '/' . $repo . '"],"privacy":"secret","permission":"' . $access . '"}\'  \'' . $http . '://' . $host . '/api/v3/orgs/' . $org . '/teams?access_token=' . $token . '\'';

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
Usage: $0 [-help] -repo -org -access -team

     -(h)elp        This help message

     -(r)epo        Repo team will have access to

     -(t)eam        Name of team to create 

     -(o)rg         Name of organization team exists in

     -(a)ccess      Level of access (admin, push or pull)
    
     -(i)d          Token used to access GitHub

     -(g)ithub      FQDN of GitHub server or ipaddress

     -(s)sl         Specify if SSL is in use on the Github server
 
     -(v)erbose     If specified, returns JSON data to STDOUT

END_OF_USAGE
    exit $exit;
}

