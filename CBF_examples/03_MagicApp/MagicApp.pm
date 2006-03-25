# MagicApp CBB

# This file uses the "Perlish" coding style
# please read http://perl.4pro.net/perlish_coding_style.html

### DESCRIPTION ###
# This is a CBB written to give a basic example
# of a very simple application using CGI::Builder and CGI::Builder::Magic
# This same application is available in other examples using also
# other integrations such as Apache::CGI::Builder or just
# CGI::Builder

# Please, check the other examples too, which will show how to use other
# useful integration, in order to reduce coding and programming effort

# Feel free to add more features to this CBB in order to better understand
# the documentation

############ CBB START ###########

# defines the CBB package
; package MagicApp

########## BUILD INCLUSION #########
# with this statement this CBB will inherit the CBF capabilities
# and methods. In this CBB, we don't need to include other super classes
; use CGI::Builder
  qw| CGI::Builder::Magic
    |


########## OVERRUNNING HANDLERS ##########
# We need no overrunning handler for this very basic application

   
############## PER-PAGE HANDLERS ################

# In order to better understand the magic behind the CGI::Builder::Magic
# extension, I suggest you to compare this CBB with the SimpleApp.pm CBB
# of the example 2

# In this simple application we don't need any page handler
# since the only thing the page handlers were doing in SimpleApp.pm
# was setting the page_content, and the page_content is set automatically
# by the template system

# We put a PH_env_page here, just to print a warn in the log, only to show
# that is called however (if it is defined)

; sub PH_env_page
   { warn 'PH_env_page called'
   }

# No PH_index but an index.html file with the magic labels inside
# No PH_pass_page but a pass_page.html file with the magic labels inside
# No PH_env_page but an env_page.html file with the magic labels inside
   
# This is a Switch Handler and it is called just for page 'env_page'.
# It checks if the user correctly fills the 'password' field
# by using 'CBF' as password, and switches back to pass_page on error
# after setting a page_error string (used in the pass_page)
; sub SH_env_page
   { my $s = shift
   ; unless ( ($s->cgi->param('password')||'') eq 'CBF' )
      { $s->page_error(err_password=>'Wrong password! Please, retry...')
      ; $s->switch_to('pass_page')
      }
   }

# Please note that the page_error is passed automatically as a
# lookup location of the template engine, so you can use the label
# 'err_password' inside the template

############## LOOKUPS SECTION ################

; package MagicApp::Lookups

; our $app_name = 'MagicApp 1.0'

; sub Time
   { scalar localtime
   }
   
sub ENV_table {
    my @table ;
    while (my @line = each %ENV) {
        push @table, \@line
    }
    \@table
}
   
; 1
