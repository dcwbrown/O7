use strict;
use warnings;
use LWP::UserAgent;

my $base = 'https://www.inf.ethz.ch/personal/wirth/ProjectOberon';

my $ua = LWP::UserAgent->new(ssl_opts => { verify_hostname => 0 });

sub downloadproject {
  my ($project, $baseurl) = @_;
  my $response = $ua->get("$baseurl/index.html");
  die $response->status_line unless $response->is_success;
  mkdir $project;
  for (split /^/, $response->decoded_content) {
    if (/HREF=\"([^"]+)\"\>([^<]+)\</) {
      my ($filename, $description) = ($1, $2);
      my $dir = "";
      if ($filename =~ /^(.*)\//) {$dir = $1}

      unless ($dir =~/^http:\/\/|[.\/]/) {
        #print $_;
        print "  $project/$filename: $description\n";
        #print "$filename\n";
        if ($dir ne "") {mkdir "$project/$dir";}
        $ua->mirror("$baseurl/$filename", "$project/$filename");
      }
    }
  }
}


downloadproject("Oberon", "https://www.inf.ethz.ch/personal/wirth/Oberon");
downloadproject("ProjectOberon", "https://www.inf.ethz.ch/personal/wirth/ProjectOberon");
downloadproject("Lola", "https://www.inf.ethz.ch/personal/wirth/Lola");