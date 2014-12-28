erlrecaptcha
=============

Google recaptcha app for Erlang.

For more information about recapctcha please visit https://developers.google.com/recaptcha/

This module requies [jiffy](https://github.com/davisp/jiffy).

####Installation

Open includes/constant.hrl and change the value YOUR_PRIVATE_KEY with your own key.

Everything definded in rebar.config. So, you just need to do :

    $ ./rebar g-d && ./rebar co && ./start.sh

    $ Eshell V6.3  (abort with ^G)
    1> erlrecaptcha:verify("192.168.1.1","c822c1b63853ed273b89687ac505f9fa").
    false


#####Chicago Boss

You may use the app in your Chicago Boss project. You just need to add in your rebar.conf debs :

    {deps, [
    
    ...
    
    {erlrecaptcha,".*",{git, "git://github.com/drlinux/erlrecaptcha.git", "master"}}
    
    ]}.

    $ ./rebar g-d
  
Open deps/erlrecaptcha/includes/constant.hrl and change the value YOUR_PRIVATE_KEY with your own key.

Now you can use the app your validation test as well as in the following code:

    validation_tests() -> 
         [
         
         {fun() -> length(Name) >= 7 end,
    	              "Name area seems invalid!"},
         {fun() -> erlrecaptcha:verify(RemoteIp, Token) end,
    	               "You are not human!"}
    	   ].


