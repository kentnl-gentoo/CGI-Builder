# SimpleApp CBB

# This file uses the "Perlish" coding style
# please read http://perl.4pro.net/perlish_coding_style.html

### DESCRIPTION ###
# This is a CBB written to give a basic example
# of a very simple application using just CGI::Builder.
# This same application is available in other examples using also
# other integrations such as Apache::CGI::Builder and
# CGI::Builder::Magic

# Please, check the other examples too, which will show how to use other
# useful integration, in order to reduce coding and programming effort

# Feel free to add more features to this CBB in order to better understand
# the documentation


############ CBB START ###########

# defines the CBB package
; package SimpleApp

########## BUILD INCLUSION #########
# with this statement this CBB will inherit the CBF capabilities
# and methods. In this CBB, we don't need to include other extensions
# or super classes
; use CGI::Builder


########## OVERRUNNING HANDLERS ##########
# We need no overrunning handler for this very basic application

   
############## PER-PAGE HANDLERS ################

# These are the handlers called on a per page basis,
# i.e. each per Page Handler is called ONLY for a certain requested page.
# Unless you use some extension that sets the page_content on its own,
# you usually need one PH_* handler per page in order to set the page_content

# This CBB implements just the index and 2 page handlers

# called when no page has been requested (i.e. no 'p' param defined)
; sub PH_index
   { my $s = shift
   ; my $Time = $s->Time()
   ; $s->page_content = << "EOS"
<html>

	<head>
		<meta http-equiv="content-type" content="text/html;charset=iso-8859-1">
		<title>Index Page</title>
	</head>

	<body bgcolor="#ffffff">
		<p>This page is the index (default) page of the application. </p>
		<hr>
		<p><a href="is.cgi?p=pass_page">Go to page 'pass_page'</a></p>
		<p>The following link will not show you the env_page (because of the SH_env_page), instead it will switch you to the pass_page regardless the URL<br>
			<a href="is.cgi?p=env_page">Go to page 'env_page'</a> </p>
			<hr>Generated by $app_name at $Time
	</body>

</html>
EOS
   }

   
# this handler is called just for page 'pass_page'
# it contain a simple form which requires a password
; sub PH_pass_page
   { my $s = shift
   ; my $Time = $s->Time()
   ; $err = $s->page_error
   ; $s->page_content = << "EOS"
<html>

	<head>
		<meta http-equiv="content-type" content="text/html;charset=iso-8859-1">
		<title>Password Page</title>
	</head>

	<body bgcolor="#ffffff">
		<p>This page is a sort of simplified login page. By filling the 'password' field with the correct password you can go to the 'env_page', while you will have this page displayed again if the password is wrong.</p>
		<p> </p>
		<hr>
		<p><font color="red"><b>$$err{err_password}</b></font></p>
		<form action="is.cgi" method="post">
		Password: ('CBF') <input type="password" name="password" size="24" border="0">
		<input type="hidden" name="p" value="env_page" border="0"><input type="submit" value="Go To env_page" border="0">
		</form>
			<hr>Generated by $app_name at $Time
	</body>

</html>
EOS
   }
   
# This is a Switch Handler and it is called just for page 'env_page'.
# It checks if the user correctly fills the 'password' field
# by using 'CBF' as password, and switches back to pass_page on error
# after setting a page_error string (used in the pass_page)
; sub SH_env_page
   { my $s = shift
   ; unless ( $s->cgi->param('password')||'' eq 'CBF' )
      { $s->page_error(err_password=>'Wrong password! Please, retry...')
      ; $s->switch_to('pass_page')
      }
   }
   
# this handler is called just for page 'submitted_page'
# it is called only if the password is 'CBF' (see SH_env_page)
# it displays the ENVIRONMENT
; sub PH_env_page
   { my $s = shift
   ; my $Time = $s->Time()
   ; $s->page_content = << 'EOSTART'
<html>

<head>
<meta http-equiv=content-type content="text/html;charset=iso-8859-1">
<title>ENVIRONMENT</title>
<style media=screen type=text/css><!--
td  { font-size: 9pt; font-family: Arial }
tr   { vertical-align: top }
--></style>
</head>

<body bgcolor=#ffffff>
<table border=0 cellpadding=3 cellspacing=1 width=100%>
<tr><td bgcolor=#666699 nowrap colspan=2><font size=3 color=white><b>ENVIRONMENT</b></font></td></tr>
EOSTART

; while (my ($name, $value) = each %ENV)
   { $s->page_content .= << "EOTABLE"
<tr>
<td bgcolor=#d0d0ff nowrap><b>$name</b></td>
<td bgcolor=#e6e6fa width=100%>$value</td>
</tr>
EOTABLE
   }
   
   ; $s->page_content .= << "END" ;
</table>
			<hr>Generated by $app_name at $Time
</body>

</html>
END
   }

# PH_AUTOLOAD is called when no page handler have been defined
# for a certain requested page, and no page_content has been defined so far.
# You should define it only if you need to display some special page in the
# above situation, anyway, if you don't define it, the CBF will handle
# the request automatically by sending the correct header to the client
; sub PH_AUTOLOAD
   { my $s = shift
   ; $s->page_content = << "EOS"
<html>

	<head>
		<meta http-equiv="content-type" content="text/html;charset=iso-8859-1">
		<title>Unknown page!</title>
	</head>

	<body bgcolor="#ffffff">
		<h1>Unknown page!</h1>
			<hr>Generated by $app_name at $Time
	</body>

</html>
EOS
   }


############## PRIVATE SECTION ################

# This section is not part of the CBF, and is defined
# just for this specific CBB

; our $app_name = 'SimpleApp 1.0'

; sub Time
   { scalar localtime
   }
   
   
; 1