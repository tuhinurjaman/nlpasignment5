#This program created by Tuhinur Jaman
#system will try to  answer Who, What, When and Where questions.
#this  system will try to answer questions from any domain,
# and will try to provide answers  fro specified Question.
use warnings;
use WWW::Wikipedia;
use open ':std', ':encoding(UTF-8)';
  # my $question ;
my $filename = $ARGV[0];#taking the
open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
print "This is a QA system by Tuhinur Jaman(TJ). It will try to answer Who, What, When or Where questions.
\nEnter \"exit\" to leave the program.\n \n ";

while(<STDIN>){
    my $question = $_;
    chomp;
    exit if $_ eq "exit";

my $s1;#question type.
my $s2;#verb
my $s3;#articale
my $s4;#questions sense
my $s5;
#Who/What type question.use regular expression to get the sense of the
#question and send wiki to serch .
#####################################################################
  if($question=~m/(Who|what) (was|is|were|are) (the |an? )?(.*)\?/i){
    #who is barack obama? divide the questions and send only barack obama to wiki.
    $s1=$1;#question type.
    $s2=$2;#verb
    $s3=$3;#articale
    $s4=$4;#question sence.
    $s5 = ucfirst($s4);#make the first letter uppercase.
    my $wiki = WWW::Wikipedia->new(clean_html =>1);
    my $result=$wiki->search($s4);
      if($result){
        my $text= $result ->text();
        $text=~s/\'//g;
        $text=~s/\(.*?\)//g;
        $text=~s/\s+/ /g;
        #find the match of tje question.
          if ($text =~ / (?:is|was|were|are) ((a|an|the)[^.]*)./gm){
            print "$s5 $s2 $1.\n";
            }
        }else{
          print "I'm sorry, I don't know.\n";
        }

  }
  #Where type question.use regular expression to get the sense of the
  #question and send wiki to serch .
#########################################################################
  elsif($question=~m/(where) (was|is|were|are) (the |an? )?(.*)\?/i){
    #where is bangladesh? $s1=where.$s2=is.$s4=bangladesh.
   $s1=$1;#question type.
   $s2=$2;#verb
   $s3=$3;#articale
   $s4=$4;#question sence.
   $s5 = ucfirst($s4);#making first charecter upper case.
   #sending Bangladesh to search in wiki.
   my $wiki = WWW::Wikipedia->new(clean_html =>1);
   my $result=$wiki->search($s4);
     if($result){
      my $text= $result ->text();
       $text=~s/\'//g;
       $text=~s/\(.*?\)//g;
       $text=~s/\s+/ /g;
       #using regular expression to get the exact answer.
          if ($text =~ / (?:is|was|were|are) ((a|an|the)[^.]*)./gm){
            $answer="$s5 $s2 $1";
            print "$answer.\n";
          }
     }else{#if the question answer doesnt match
      print "I'm sorry, I don't know.\n";
     }
  }
  #When type question.use regular expression to get the sense of the
  #question and send wiki to serch .
########################################################################
   elsif($question= ~m/(When) (was|is|were|are) (the |an? )?(.*)\?/i){
     #when is mothers day?
     #divide the question.
     $s1=$1;#question type.
     $s2=$2;#verb
     $s3=$3;#articale
     $s4=$4;#question sence.
    $s5 = ucfirst($s4);
    my $wiki = WWW::Wikipedia->new(clean_html =>1);
    my $result=$wiki->search($s4);#search for mothers day
      if($result){
        my $text= $result ->text();
        $text=~s/\'//g;
        $text=~s/\(.*?\)//g;
        $text=~s/\s+/ /g;
          #using regular expression to get the exact answer.
           if ($text =~ / (?:is|was|were|are) ((a|an|the)[^.]*)./gm){
             #if find the match.
               $answer="$s5 $s2 $1";
               print "$answer.\n";
             }
      }else{#if the question answer doesnt match
      print "I'm sorry, I don't know.\n";
      }

    }

    else{#defalt.if none of the question condition matches.
    print "I'm sorry, I don't know.\n";
    }




}
