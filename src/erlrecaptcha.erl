% Copyright (c) 2014 İbrahim Yılmaz (drlinux)
%
% Permission is hereby granted, free of charge, to any person
% obtaining a copy of this software and associated documentation
% files (the "Software"), to deal in the Software without
% restriction, including without limitation the rights to use,
% copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the
% Software is furnished to do so, subject to the following
% conditions:
% 
% The above copyright notice and this permission notice shall be
% included in all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
% EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
% OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
% NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
% HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
% WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
% FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
% OTHER DEALINGS IN THE SOFTWARE.

-module(erlrecaptcha).
-include("../include/constant.hrl").
-export([verify/2]).


verify(RemoteIp, Response) ->
	application:start(crypto),	
	application:start(asn1),
    	application:start(public_key),
    	application:start(ssl),
	inets:start(),
	Data =	 ?RECAPTHA_API_URL ++ "?"
		"secret="++ ?RECAPTHA_PRIVATE_KEY ++ "&"
		"remoteip=" ++ RemoteIp ++ "&"
		"response=" ++ Response,
	HttpResponse = 
		httpc:request(get,
			{Data,[]}, 
			[],[]),
	BodyStr = 
		case HttpResponse of
			{ok, saved_to_file} -> "saved";
			{ok, Result} -> 
				case Result of
					{_Status, _Headers, Body} -> Body;
					{_Status, Body} -> Body
				end;
			{error, _Reason} -> "error"
		end,
	Lines = string:tokens(BodyStr, "\r\n"),
	Maps=jiffy:decode(Lines,[return_maps]),
	Res=maps:get(<<"success">>, Maps),
	Res.
