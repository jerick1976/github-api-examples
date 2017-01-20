#!/usr/bin/perl
use strict;
use Getopt::Long;
use File::Which;

#
#  GitHub Documentation this wrapper is based off of:
#
#  https://developer.github.com/v3/orgs/teams/#add-or-update-team-repository
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

my ($ssl,$http,$host,$token,$team_id,$org,$repo,$help,$perms,$verbose);

GetOptions('help'  => \$help,
    'repo=s'       => \$repo, 
    'org=s'        => \$org,
    'id=s'         => \$token,
    'github=s'      => \$host,
    'team_id=s'    => \$team_id,
    'access=s'     => \$perms,
    'ssl'          => \$ssl,
    'verbose'      => \$verbose)
    or warn "Failed to parse options\n" and usage(1);

my %paths;
$paths{curl} = which('curl');

if ($help) 
{
    usage(0);
}

if (not $host or not $repo or not $team_id or not $token)
{
    usage(0);
}

if (not $ssl) {$http = "http";}
else { $http = "https";}

if (not $perms) {$perms = "pull";}

sub usage
{
    my $exit = shift;
    my $fh   = $exit ? \*STDOUT : \*STDERR;

    print "\n";
    print <<"END_OF_USAGE";
Usage: $0 [-help] -server -team <numeric id of team> -user <github user name>

     -(h)elp        This help message

     -(g)ithub      FQDN of GitHub server or ipaddress

     -(t)eam        Name of Team (must exist already)

     -(r)epo        Name of GitHub repository to add to team

     -(o)rg         Organization where the team and repository reside

     -(i)d          Token used to access the Github Server
 
     -(a)ccess      Role of the team (admin, push, pull), 
                    The default if not specified is pull
     
     -(s)sl         Specify if SSL is in use on the Github server

     -(v)erbose     If specified, returns the curl command and JSON data to STDOUT

END_OF_USAGE
    exit $exit;
}
my $cmd = 'curl -i -X PUT -d \'{"permission":"' . $perms . '"}\' \'' . $http . '://www-github.cisco.com/api/v3/teams/' . $team_id . '/repos/' . $org . '/' . $repo . '?access_token=' . $token . '\'';

# backticks returns the output from curl
if (not $verbose) { `$cmd`; }
# System will return the return code which in this case is the JSON data
else 
{ 
    print "$cmd \n";
    system($cmd);
}

