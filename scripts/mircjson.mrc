alias JSONOpen {
  var %switches = -
  if (-* iswm $1) {
    %switches = $1
    tokenize 32 $2-
  }
  var %close = $false

  var %com = JSONHandler:: $+ $1, %error, %file, %rem
  var %init = function init(a,b){errortext="";data="";url=b ? b : "";method="GET";headers=[];parsedJSON={};status=a;fso=new ActiveXObject("Scripting.FileSystemObject")}
  var %read = function readFile(filename){var ado=new ActiveXObject("ADODB.Stream");ado.CharSet="utf-8";ado.Open();ado.LoadFromFile(filename);if(!ado.EOF){data=ado.ReadText();}ado.close()}
  var %json = "object"!==typeof JSON&&(JSON={});(function(){function m(a){return 10>a?"0"+a:a}function t(a){p.lastIndex=0;return p.test(a)?'"'+a.replace(p,function(a){var c=u[a];return"string"===typeof c?c:"\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4)})+'"':'"'+a+'"'}function q(a,l){var c,d,h,r,g=e,f,b=l[a];b&&"object"===typeof b&&"function"===typeof b.toJSON&&(b=b.toJSON(a));"function"===typeof k&&(b=k.call(l,a,b));switch(typeof b){case "string":return t(b);case "number":return isFinite(b)?String(b):"null";case "boolean":case "null":return String(b);case "object":if(!b)return"null";e+=n;f=[];if("[object Array]"===Object.prototype.toString.apply(b)){r=b.length;for(c=0;c<r;c+=1)f[c]=q(c,b)||"null";h=0===f.length?"[]":e?"[\n"+e+f.join(",\n"+e)+"\n"+g+"]":"["+f.join(",")+"]";e=g;return h}if(k&&"object"===typeof k)for(r=k.length,c=0;c<r;c+=1)"string"===typeof k[c]&&(d=k[c],(h=q(d,b))&&f.push(t(d)+(e?": ":":")+h));else for(d in b)Object.prototype.hasOwnProperty.call(b,d)&&(h=q(d,b))&&f.push(t(d)+(e?": ":":")+h);h=0===f.length?"{}":e?"{\n"+e+f.join(",\n"+e)+"\n"+g+"}":"{"+f.join(",")+"}";e=g;return h}}"function"!==typeof Date.prototype.toJSON&&(Date.prototype.toJSON=function(){return isFinite(this.valueOf())?this.getUTCFullYear()+"-"+m(this.getUTCMonth()+1)+"-"+m(this.getUTCDate())+"T"+m(this.getUTCHours())+":"+m(this.getUTCMinutes())+":"+m(this.getUTCSeconds())+"Z":null},String.prototype.toJSON=Number.prototype.toJSON=Boolean.prototype.toJSON=function(){return this.valueOf()});var s,p,e,n,u,k;"function"!==typeof JSON.stringify&&(p=/[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,u={"\b":"\\b","\t":"\\t","\n":"\\n","\f":"\\f","\r":"\\r",'"':'\\"',"\\":"\\\\"},JSON.stringify=function(a,l,c){var d;n=e="";if("number"===typeof c)for(d=0;d<c;d+=1)n+=" ";else"string"===typeof c&&(n=c);if((k=l)&&"function"!==typeof l&&("object"!==typeof l||"number"!==typeof l.length))throw Error("JSON.stringify");return q("",{"":a})});"function"!==typeof JSON.parse&&(s=/[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,JSON.parse=function(a,e){function c(a,d){var g,f,b=a[d];if(b&&"object"===typeof b)for(g in b)Object.prototype.hasOwnProperty.call(b,g)&&(f=c(b,g),void 0!==f?b[g]=f:delete b[g]);return e.call(a,d,b)}var d;a=String(a);s.lastIndex=0;s.test(a)&&(a=a.replace(s,function(a){return"\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4)}));if(/^[\],:{}\s]*$/.test(a.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g,"@").replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g,"]").replace(/(?:^|:|,)(?:\s*\[)+/g,"")))return d=eval("("+a+")"),"function"===typeof e?c({"":d},""):d;throw new SyntaxError("JSON.parse");})})();
  var %xhr = function xhr(){var a,b=['MSXML2.SERVERXMLHTTP.6.0','MSXML2.SERVERXMLHTTP.3.0','MSXML2.SERVERXMLHTTP','MSXML2.XMLHTTP.6.0','MSXML2.XMLHTTP.3.0','Microsoft.XMLHTTP'],c;for(a=0;a<b.length;a++){try{c=new ActiveXObject(b[a]);break}catch(e){}}if(typeof c==="undefined"){errortext = "Unable to locate an XMLHTTP object for use"}else{c.open(method,url,false);for(a=0;a<headers.length;a++){c.setRequestHeader(headers[a][0],headers[a][1])}c.send(data);if(c.status!==200){errortext="Unable to retrieve data - Server Error: " + c.status}else{status="Parsed";try{parsedJSON=JSON.parse(c.responseText)}catch(ee){errortext="Unable to parse Retrieved Data"}}}}

  if (!$regex(%switches, /^-[ufbwd]*$/)) {
    %error = Invalid switches specified
  }
  elseif ($regex(%switches, /([ufbwd])\1/)) {
    %error = Duplicate switch specified ( $+ $regml(1) $+ )
  }
  elseif ($regex(%switches, /([ufb])/g) > 1) {
    %error = Conflicting switches specified (- $+ $regml(1) $+ , - $+ $regml(2) $+ $iif($regml(3), $chr(44) - $+ $v1) $+ )
  }
  elseif (w isin %switches && u !isin %switches) {
    %error = Invalid switch (-w is only for use with -u)
  }
  elseif ($0 < 2) {
    %error = Required parameters missing
  }
  elseif (!$regex($1,/^[a-z\d_.-]+$/i)) {
    %error = Invalid name specified (Can only contant letters, numbers, _, ., and -)
  }
  elseif ($com(%com)) {
    %error = Specified name in use
  }
  elseif (u isin %switches && $0 > 2) {
    %error = Invalid URL specified. (Contains Spaces: $2-)
  }
  elseif (f isin %switches && !$isfile($2-)) {
    %error = File not found: $2-
  }
  elseif (b isin %switches && &* !iswm $2) {
    %error = Invalid binary variable specified (No '&' Prefix)
  }
  elseif (b isin %switches && $0 > 2) {
    %error = Invalid binary variable specified (Contains Spaces: $2-)
  }
  elseif (b isin %switches && $bvar($2, 0) < 1) {
    %error = Invalid binary variable specified (No content)
  }
  else {
    %close = $true
    if (!$JSON::ComOpen(%com, MSScriptControl.ScriptControl) || $comerr) {
      %error = Unable to create an instance of MSScriptControl.ScriptControl
    }
    elseif (!$com(%com, language, 4, bstr, jscript) || $comerr) {
      %error = Unable to set ScriptControl's language to Javascript
    } 
    elseif (!$com(%com, addcode, 1, bstr, %init) || $comerr) {
      %error = Unable to add init() to ScriptControl
    }
    elseif (!$com(%com, addcode, 1, bstr, %xhr) || $comerr) {
      %error = Unable to add xhr() to ScriptControl
    }
    elseif (!$com(%com, addcode, 1, bstr, %read) || $comerr) {
      %error = Unable to add readFile() to ScriptControl
    }
    elseif (!$com(%com, ExecuteStatement, 1, bstr, %JSON) || $comerr) {
      %error = Unable to Initalize the JSON parser object
    }
    elseif (!$com(%com, ExecuteStatement, 1, bstr, $iif(u isin %switches, $+(init,$chr(40), "XHR", $chr(44), $qt($JSON::Escape($2)),$chr(41)), $+(init,$chr(40), "Parsed", $chr(44), "", $chr(41)))) || $comerr) {
      %error = Unable to initalize variables for ScriptControl
    }
    else {
      if (u isin %switches) {
        if (w !isin %switches) {
          var %i = $com(%com, ExecuteStatement, 1, bstr, $+(xhr,$chr(40),$chr(41)))
          if (!%i || $comerr) {
            %error = Unable to retrieve data from $2 :: $com(%com).error :: $com(%com).errortext
          }
          elseif (!$com(%com, eval, 1, bstr, errortext) || $com(%com).result) {
            %error = Unable to retrieve data $+ $iif($v1,: $v1,)
          }
        }
      }
      else {
        %file = $JSON::File($1)
        if (f isin %switches) {
          %file = $longfn($2)
        }
        elseif (b isin %switches) {
          bwrite $qt(%file) 0 -1 $2
          %rem = $true
        }
        else {
          write -n $qt(%file) $2-
          %rem = $true
        }
        if (!$com(%com, ExecuteStatement, 1, bstr, $JSON::Funct(readFile, $qt($JSON::Escape(%file)))) || $comerr) {
          %error = Unable to read contents of data-passing file
        }
        elseif (!$com(%com, ExecuteStatement, 1, bstr, $JSON::Funct(parsedJSON=JSON.parse,data)) || $comerr) {
          %error = Unable to parse data into valid JSON
        }
      }
      if (d isin %switches) {
        $+(.timer,%com) 1 0 JSONClose $1
      }
    }
  }
  :error
  %error = $iif($error, $v1, %error)
  if (%rem && %file && $isfile(%file)) {
    .remove $qt(%file)
  }
  if (%error) {
    if ($timer(%com)) { $+(.timer,%com) off }
    if (%close && $com(%com)) { 
      set -eu0 $+(%,%com,::error) %error
      set -eu0 %JSONError %error
      .comclose %com
    }
    else {
      set -eu0 %JSONError %error
    }
  }
  else {
    unset $+(%,%com,::error)
    unset %JSONError
  }
}
alias -l JSONError { return %JSONError }

alias JSONURLOption {
  var %com = JSONHandler:: $+ $1, %error, %head, %value, %x = 2

  if (!$com(%com)) {
    return
  }
  unset % [ $+ [ %com ] $+ ] ::error
  if ($0 < 3) {
    %error = Missing parameters
  }
  elseif (!$com(%com, eval, 1, bstr, status) || $com(%com).result != XHR) {
    %error = HTTP Request already completed or wasn't specified
  }
  elseif ($2 == method) {
    if (!$regex($3-, /^(?:GET|POST|PUT|DELETE)$/i)) {
      %error = Invalid HTTP Request method Specified: $3-
    }
    elseif (!$com(%com, ExecuteStatement, 1, bstr, method=" $+ $3 $+ ") || $comerr) {
      %error = Unable to set HTTP Request method
    }
  }
  else {
    if (!$com(%com, ExecuteStatement, 1, bstr, $JSON::Funct(headers.push,[ $+ $qt($JSON::Escape($2)), $qt($JSON::Escape($3-)) $+ ])) || $comerr) {
      %error = Unable to set HTTP Header: %head $+ : $+ %value
    }
  }
  :error
  %error = $iif($error, $v1, %error)
  if (%error) {
    reseterror
    set -e $+(%,%com,::Error) %error
  }
}
alias JSONGet { 
  var %switches -
  if (-* iswm $1) {
    %switches = $1
    tokenize 32 $2-
  }
  var %com = JSONHandler:: $+ $1
  var %file = $JSON::File($1)
  var %error
  var %rem
  if ($com(%com)) {
    if ($com(%com, eval, 1, bstr, status) && $com(%com).result !== XHR) {
      %error = HTTP Request already completed or wasn't specified
    }
    elseif (!$regex(%switches, /^-[bf]*$/)) {
      %error = Invalid switches specified
    }
    elseif ($regex(%switches, /([bf])\1/)) {
      %error = Duplicate switch specified ( $+ $regml(1) $+ )
    }
    elseif ($regex(%switches, /([bf])/g) > 1) {
      %error = Conflicting switches specified (- $+ $regml(1) $+ , - $+ $regml(2) $+ )
    }
    elseif (b isin %switches && &* !iswm $2) {
      %error = Invalid binary variable specified (No '&' Prefix)
    }
    elseif (b isin %switches && $0 > 2) {
      %error = Invalid binary variable specified (Contains Spaces: $2-)
    }
    elseif (f isin %switches && !$isfile($2-)) {
      %error = File not found: $2-
    }
    else {
      if (b isin %switches && $bvar($2,0)) {
        bwrite $qt(%file) 0 -1 $2
        %rem = $true
      }
      elseif (f isin %switches) {
        %file = $2-
      }      
      elseif ($2-) {
        write -n $qt(%file) $2-
        %rem = $true
      }
      %file = $longfn(%file)
      if ($isfile(%file) && (!$com(%com, ExecuteStatement, 1, bstr, $JSON::Funct(readFile,$qt($JSON::Escape(%file)))) || $comerr)) {
        %error = Unable to pass data to JSON Handler
      }
      elseif (!$com(%com, ExecuteStatement, 1, bstr, xhr $+ $chr(40) $+ $chr(41)) || $comerr) {
        %error = Unable to retrieve data from specified URL :: $com(%com).error :: $com(%com).errortext     
      }
      elseif (!$com(%com, eval, 1, bstr, errortext) || $com(%com).result) {
        %error = $v1
      }
      if (%rem && $isfile(%file)) { .remove %file }
    }
  }
  :error
  %error = $iif($error, $v1, %error)
  if (%error) {
    reseterror
    set -eu0 $+(%,%com,::Error) %error
  }
}
alias JSON {
  var %com, %x = 1, %i = 0, %get = parsedJSON, %tok, %res, %LTLError
  if ($regex($1,/^\d+$/) && $0 === 1) {
    while ($com(%x)) {
      if (JSONHandler::* iswm $v1) {
        %com = $v2
        inc %i
        if (%i === $1) { return $mid(%com,14-) }
      }
      inc %x
    }
    return $iif($1 == 0, %i)
  }
  elseif ($regex($1, /^JSONHandler::CHILD::([^:]+)::(.*)$/)) {
    %com = $regml(1)
    %get = $regml(2)
  }
  else {
    %com = JSONHandler:: $+ $1
  }
  if ($com(%com)) {
    if ($0 == 1) {
      if ($prop == isChild) {
        return $iif($regex($1, /^JSONHandler::CHILD::([^:]+)::(.*)$/), $true, $false)
      }
      elseif ($prop == error || $prop === errormsg) {
        return $(,$+(%,%com,::error))
      }
      elseif ($com($1)) {
        return $1
      }
    }
    elseif (!$com(%com, eval, 1, bstr, status) || $com(%com).result != parsed) {
      set -eu0 $+(%,%com,::error) JSON Handler waiting for HTTP Request
    }
    else {
      %x = 2
      while (%x <= $0) {
        %tok = $(,$ $+ %x)
        if (!$regex(%tok, /^\d+$/)) {
          %tok = $qt($replace(%tok,\,\\,",\"))
        }
        %get = $+(%get,[,%tok,])
        inc %x
      }
      if (!$com(%com, eval, 1, bstr, %get) || $comerr) {
        set -eu0 $+(%,%com,::error) Invalid Item|index specified
      }
      else {
        %LLLError = $true
        %res = $com(%com).result
        %LLLError = $false
        if (%res == [object]) {
          return JSONHandler::CHILD:: $+ $1 $+ :: $+ %get
        }
        else {
          return %res
        }
      }
    }
  }
  return
  :error
  set -eu0 $+(%,%com,::error) $iif(%LLLError, Line to Long; truncated at 4000 bytes, $error)
  reseterror
  if (%LLLError) {
    %res = $left($com(%com).result, 4000)
  }
  unset %LLLError
}
alias JSONClose {
  var %com = JSONHandler:: $+ $1
  unset % [ $+ [ %com ] $+ ] ::*
  if ($com(%com)) { .comclose $v1 }
  if ($timer(%com)) { $+(.timer,%com) off }
}
alias JSONList {
  var %x = 1, %i = 0
  while ($com(%x)) {
    if (JSONHandler::* iswm $v1) {
      inc %i
      echo $color(info text) -a * # $+ %i : $regsubex($v2, /^JSONHandler::/,)
    }
    inc %x
  }
  if (!%i) {
    echo $color(info text) -a * No active JSON handlers
  }   
}
on *:Start: unset %JSONHandler::*
alias -l JSON::ComOpen { .comopen $1- | if ($com($1) && !$comerr) { return $true } | :error | reseterror | if ($com($1)) { .comclose $1 } }
alias -l JSON::Escape { return $replace($1,\,\\,",\") }
alias -l JSON::File { var %a = 1 | while ($isfile(JSON $+ $1 $+ %a $+ .json)) { inc %a } | return $+(JSON, $1, %a, .json) }
alias -l JSON::Funct { var %a = $1 $+ $chr(40), %i = 1 | while (%i < $0) { inc %i | %a = $+(%a,$iif(%i > 2,$chr(44)),$(, $ $+ %i)) } | return %a $+ $chr(41) }
