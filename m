Return-Path: <virtio-dev-return-14123-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5ADC4167B
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Dec 2023 00:42:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7A0B12B244
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Dec 2023 00:42:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A25999868F4
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Dec 2023 00:42:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 08BFA983FE0; Wed,  6 Dec 2023 00:42:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6F0CD9866A3
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Dec 2023 00:42:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701823324; x=1702428124;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vjk7innmKGK8Em5fzDh//LPr+KhFuBslcZCk93qEQ/U=;
        b=REp//CdS3JK4UIWY7WZJrbqAPsbpAMS1jUpgYBGTWO4xQGUCUEoSrDl4uGwRckeBl9
         uyXanosUx/KX7OrFXiea9Jr7oEQBbeyDoV3RAVUC0DqQ4Y+MGg2DcB7wLlmZ0U9PLfdA
         xYObetL2YduakfHd02vCQzpDFfAghLmjDJz0jwfJOuHiMMOmS1tGdMOP7YQ7+kRESNc0
         SasDo2qlVtnYmp8MeS3QCDp80dI+S93iOc7ujF+Yukq+Wz7ODhcJDJxWjUBMlnQFiBFk
         tH3N/HhRHCGzbVWlTK21bPmrxBOMXfZ8DDDSeOU7FS8IizZDl5q1PC14W6eR7CR0UCao
         Mhig==
X-Gm-Message-State: AOJu0YyvUcNs3GlYW5edtIZ3OD9QrbpmfBz3/V1ycrjcXVmT00LThfmc
	VSAgQzCdwLTl5oAgIo2iIMUU43xGLYANgAziEJtbnc16
X-Google-Smtp-Source: AGHT+IEoF899U5Z3gRkNKeHAdsZsgiXNwJqJQf2qS+ShvYooFqIJFVkjBsNbz34W3ZSKW+rg73VNhuiPEIA9CTV5cNg=
X-Received: by 2002:a05:690c:810:b0:5d7:1940:dd65 with SMTP id
 bx16-20020a05690c081000b005d71940dd65mr22174ywb.59.1701823324494; Tue, 05 Dec
 2023 16:42:04 -0800 (PST)
MIME-Version: 1.0
From: Scott McGrath <scott.mcgrath@oasis-open.org>
Date: Tue, 5 Dec 2023 19:41:51 -0500
Message-ID: <CAD2Xst-WYNuZAdQERPUkCFUzmRKus9asOEGbDLHcXii7DojsuQ@mail.gmail.com>
To: avdl-dev@lists.oasis-open.org, bcm-dev@lists.oasis-open.org, 
	cam-dev@lists.oasis-open.org, cap-dev@lists.oasis-open.org, 
	clr-dev@lists.oasis-open.org, dsml-dev@lists.oasis-open.org, 
	dss-dev@lists.oasis-open.org, election-dev@lists.oasis-open.org, 
	emergency-dev@lists.oasis-open.org, eml-dev@lists.oasis-open.org, 
	saml-dev@lists.oasis-open.org, search-ws-dev@lists.oasis-open.org, 
	soa-rm-dev@lists.oasis-open.org, spml-dev@lists.oasis-open.org, 
	ubl-dev@lists.oasis-open.org, uddi-dev@lists.oasis-open.org, 
	virtio-dev@lists.oasis-open.org, ws-context-dev@lists.oasis-open.org, 
	ws-reliability-dev@lists.oasis-open.org, 
	ws-reliablemessaging-dev@lists.oasis-open.org, ws-sx-dev@lists.oasis-open.org, 
	ws-tx-dev@lists.oasis-open.org, wsbpel-dev@lists.oasis-open.org, 
	wsfed-dev@lists.oasis-open.org, wsn-dev@lists.oasis-open.org, 
	wsrf-dev@lists.oasis-open.org, wsrp-dev@lists.oasis-open.org, 
	wss-dev@lists.oasis-open.org, xacml-dev@lists.oasis-open.org, 
	xcbf-dev@lists.oasis-open.org, xmlcatalogs-dev@lists.oasis-open.org
Content-Type: multipart/alternative; boundary="000000000000ba327d060bcc9edb"
Subject: [virtio-dev] Changes coming to this mail list system

--000000000000ba327d060bcc9edb
Content-Type: text/plain; charset="UTF-8"

I am very pleased to announce a new List Mail system will be implemented
for this list shortly.

The legacy list engine in use since 2003 will be replaced in December.  You
are receiving this message because you are a subscriber to the list
receiving this message.

This transition will provide significant improvements and will change how
you interact with your mail lists.  See below for more information about
the changes, the transition schedule and what you can do to help.

Changes to Expect

The new platform is built in a modern web environment and mail delivery
mechanism. with a number of new features to improve both your platform user
experience and ability to engage with the OASIS community.  Key features
include:


   -

   Mail systems that you can depend on!  The new tools support and comply
   with major deliverability and anti-spoofing standards.  This will eliminate
   many of the sending and deliverability issues your group may be experiencing



   -

   If you are on this public list in addition to Technical Committees, Open
   Projects, and other community engagement mail lists you can manage this
   experience in one cohesive package



   -

   All resources created in the legacy email system will be migrated and
   available cohesively with your new work in the new platform.  All URL links
   for assets in the old platform will redirect to the new location



   -

   After the migration you will be directed where to send future messages
   for this list and where to find the archives.



   -

   After the migration you will be required to create or login to an
   existing OASIS public community or member account to manage your
   subscriptions.  Legacy-style subscribe and unsubscribe email messages to
   the server will not be respected.



The Transition Schedule

Starting 14 December, there may be as much as several days of system
downtime. During the downtime you will not receive email messages sent to
this list or have access to the archive.

We will announce the timing specific as we get closer to the transition.

What You Should Do Now

If you no longer wish to subscribe to this list, send a message to

[listname]-unsubscribe@lists.oasis-open.org

Otherwise, watch for further messages in the coming days to include the new
list mailing address and archive location.

Feel free to contact me with any questions, and thanks for your patience
with the inevitable short-term inconvenience implementing these
improvements will bring.

Scott...

-- 
Scott McGrath

Chief Operating Officer

OASIS Open


+1 781-929-7308 Mobile
scott.mcgrath@oasis-open.org
www.oasis-open.org

--000000000000ba327d060bcc9edb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span id=3D"m_-8054209138448829342m_7439167174213750436m_-=
9022550266226993129gmail-docs-internal-guid-a2e49186-7fff-d1d6-b8f0-259f621=
a0ee3"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-botto=
m:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb=
(0,0,0);background-color:transparent;font-variant-numeric:normal;font-varia=
nt-east-asian:normal;font-variant-alternates:normal;vertical-align:baseline=
">I am very pleased to announce a new List Mail system will be implemented =
for this list shortly.=C2=A0</span></p><br><p dir=3D"ltr" style=3D"line-hei=
ght:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;fo=
nt-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;fo=
nt-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alter=
nates:normal;vertical-align:baseline">The legacy list engine in use since 2=
003 will be replaced in December.=C2=A0 You are receiving this message beca=
use you are a subscriber to the list receiving this message.</span></p><br>=
<p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt">=
<span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0)=
;background-color:transparent;font-variant-numeric:normal;font-variant-east=
-asian:normal;font-variant-alternates:normal;vertical-align:baseline">This =
transition will provide significant improvements and will change how you in=
teract with your mail lists.=C2=A0 See below for more information about the=
 changes, the transition schedule and what you can do to help.</span></p><b=
r><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt=
"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,=
0);background-color:transparent;font-weight:700;font-variant-numeric:normal=
;font-variant-east-asian:normal;font-variant-alternates:normal;vertical-ali=
gn:baseline">Changes to Expect</span></p><br><p dir=3D"ltr" style=3D"line-h=
eight:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;=
font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;=
font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alt=
ernates:normal;vertical-align:baseline">The new platform is built in a mode=
rn web environment and mail delivery mechanism. with a number of new featur=
es to improve both your platform user experience and ability to engage with=
 the OASIS community.=C2=A0 Key features include:</span></p><br><ul style=
=3D"margin-top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"margin-left:=
15px;list-style-type:disc;font-size:11pt;font-family:Arial,sans-serif;color=
:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;font-v=
ariant-east-asian:normal;font-variant-alternates:normal;vertical-align:base=
line"><p dir=3D"ltr" role=3D"presentation" style=3D"line-height:1.38;margin=
-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;background-color:=
transparent;font-variant-numeric:normal;font-variant-east-asian:normal;font=
-variant-alternates:normal;vertical-align:baseline">Mail systems that you c=
an depend on!=C2=A0 The new tools support and comply with major deliverabil=
ity and anti-spoofing standards.=C2=A0 This will eliminate many of the send=
ing and deliverability issues your group may be experiencing</span></p></li=
></ul><font color=3D"#000000" face=3D"Arial, sans-serif"><span style=3D"fon=
t-size:14.6667px"><br></span></font><ul style=3D"margin-top:0px;margin-bott=
om:0px"><li dir=3D"ltr" style=3D"margin-left:15px;list-style-type:disc;font=
-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:t=
ransparent;font-variant-numeric:normal;font-variant-east-asian:normal;font-=
variant-alternates:normal;vertical-align:baseline"><p dir=3D"ltr" role=3D"p=
resentation" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><s=
pan style=3D"font-size:11pt;background-color:transparent;font-variant-numer=
ic:normal;font-variant-east-asian:normal;font-variant-alternates:normal;ver=
tical-align:baseline">If you are on this public list in addition to Technic=
al Committees, Open Projects, and other community engagement mail lists you=
 can manage this experience in one cohesive package=C2=A0=C2=A0</span></p><=
/li></ul><br><ul style=3D"margin-top:0px;margin-bottom:0px"><li dir=3D"ltr"=
 style=3D"margin-left:15px;list-style-type:disc;font-size:11pt;font-family:=
Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant=
-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norm=
al;vertical-align:baseline"><p dir=3D"ltr" role=3D"presentation" style=3D"l=
ine-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:=
11pt;background-color:transparent;font-variant-numeric:normal;font-variant-=
east-asian:normal;font-variant-alternates:normal;vertical-align:baseline">A=
ll resources created in the legacy email system will be migrated and availa=
ble cohesively with your new work in the new platform.=C2=A0 All URL links =
for assets in the old platform will redirect to the new location</span></p>=
</li></ul><br><ul style=3D"margin-top:0px;margin-bottom:0px"><li dir=3D"ltr=
" style=3D"margin-left:15px;list-style-type:disc;font-size:11pt;font-family=
:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-varian=
t-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:nor=
mal;vertical-align:baseline"><p dir=3D"ltr" role=3D"presentation" style=3D"=
line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size=
:11pt;background-color:transparent;font-variant-numeric:normal;font-variant=
-east-asian:normal;font-variant-alternates:normal;vertical-align:baseline">=
After the migration you will be directed where to send future messages for =
this list and where to find the archives.</span></p></li></ul><br><ul style=
=3D"margin-top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"margin-left:=
15px;list-style-type:disc;font-size:11pt;font-family:Arial,sans-serif;color=
:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;font-v=
ariant-east-asian:normal;font-variant-alternates:normal;vertical-align:base=
line"><p dir=3D"ltr" role=3D"presentation" style=3D"line-height:1.38;margin=
-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;background-color:=
transparent;font-variant-numeric:normal;font-variant-east-asian:normal;font=
-variant-alternates:normal;vertical-align:baseline">After the migration you=
 will be required to create or login to an existing OASIS public community =
or member account to manage your subscriptions.=C2=A0 Legacy-style subscrib=
e and unsubscribe email messages to the server will not be respected.</span=
></p></li></ul><br><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:=
0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans=
-serif;color:rgb(0,0,0);background-color:transparent;font-weight:700;font-v=
ariant-numeric:normal;font-variant-east-asian:normal;font-variant-alternate=
s:normal;vertical-align:baseline">The Transition Schedule</span></p><br><p =
dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><sp=
an style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);ba=
ckground-color:transparent;font-variant-numeric:normal;font-variant-east-as=
ian:normal;font-variant-alternates:normal;vertical-align:baseline">Starting=
 14 December, there may be as much as several days of system downtime. Duri=
ng the downtime you will not receive email messages sent to this list or ha=
ve access to the archive.=C2=A0=C2=A0</span></p><br><p dir=3D"ltr" style=3D=
"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-siz=
e:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:trans=
parent;font-variant-numeric:normal;font-variant-east-asian:normal;font-vari=
ant-alternates:normal;vertical-align:baseline">We will announce the timing =
specific as we get closer to the transition.</span></p><br><p dir=3D"ltr" s=
tyle=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"f=
ont-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-colo=
r:transparent;font-weight:700;font-variant-numeric:normal;font-variant-east=
-asian:normal;font-variant-alternates:normal;vertical-align:baseline">What =
You Should Do Now</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;ma=
rgin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:A=
rial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-=
numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norma=
l;vertical-align:baseline">If you no longer wish to subscribe to this list,=
 send a message to=C2=A0</span></p><p dir=3D"ltr" style=3D"line-height:1.38=
;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-famil=
y:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-varia=
nt-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:no=
rmal;vertical-align:baseline">[listname]</span><a href=3D"mailto:-unsubscri=
be@lists.oasis-open.org" target=3D"_blank" style=3D"text-decoration-line:no=
ne"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;background-c=
olor:transparent;font-variant-numeric:normal;font-variant-east-asian:normal=
;font-variant-alternates:normal;text-decoration-line:underline;vertical-ali=
gn:baseline">-unsubscribe@lists.oasis-open.org</span></a></p><br><p dir=3D"=
ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span styl=
e=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);backgroun=
d-color:transparent;font-variant-numeric:normal;font-variant-east-asian:nor=
mal;font-variant-alternates:normal;vertical-align:baseline">Otherwise, watc=
h for further messages in the coming days to include the new list mailing a=
ddress and archive location.</span></p><br><p dir=3D"ltr" style=3D"line-hei=
ght:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;fo=
nt-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;fo=
nt-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alter=
nates:normal;vertical-align:baseline">Feel free to contact me with any ques=
tions, and thanks for your patience with the inevitable short-term inconven=
ience implementing these improvements will bring.</span></p></span><br><div=
>Scott...</div><div><br></div><span class=3D"gmail_signature_prefix">-- </s=
pan><br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_=
signature"><div dir=3D"ltr"><table cellspacing=3D"0" cellpadding=3D"0" styl=
e=3D"font-family:Arial;vertical-align:-webkit-baseline-middle"><tbody><tr><=
td width=3D"70" style=3D"vertical-align:middle"><span style=3D"margin-right=
:5px;display:block"><img width=3D"70" height=3D"70" style=3D"max-width:70px=
" src=3D"https://ci3.googleusercontent.com/mail-sig/AIorK4wWWvttK4QvAyLjmQR=
fbisd2jdvX84ncnFeBuJn9NtWvi8WHJIwVlm1HGm8Re2Ji0U6N10brtc"></span></td><td s=
tyle=3D"vertical-align:middle"><h3 style=3D"margin:0px;font-size:16px;color=
:rgb(0,0,0)">Scott=C2=A0McGrath</h3><p style=3D"margin:0px;color:rgb(0,0,0)=
;font-size:12px;line-height:20px">Chief Operating Officer</p><p style=3D"ma=
rgin:0px;color:rgb(0,0,0);font-size:12px;line-height:20px">OASIS Open</p></=
td><td width=3D"30">=C2=A0</td><td width=3D"1" style=3D"width:1px;border-bo=
ttom:none;border-left:1px solid rgb(34,72,229)">=C2=A0</td><td width=3D"30"=
>=C2=A0</td><td style=3D"vertical-align:middle"><table cellspacing=3D"0" ce=
llpadding=3D"0" style=3D"vertical-align:-webkit-baseline-middle;font-family=
:Arial"><tbody><tr style=3D"vertical-align:middle"><td width=3D"30" style=
=3D"vertical-align:middle"><table cellspacing=3D"0" cellpadding=3D"0" style=
=3D"vertical-align:-webkit-baseline-middle;font-family:Arial"><tbody><tr><t=
d style=3D"vertical-align:bottom"><span style=3D"display:block;background-c=
olor:rgb(34,72,229)"><img src=3D"https://cdn2.hubspot.net/hubfs/53/tools/em=
ail-signature-generator/icons/phone-icon-2x.png" width=3D"13" style=3D"disp=
lay:block"></span></td></tr></tbody></table></td><td style=3D"padding:2px;c=
olor:rgb(0,0,0)"><br>+1 781-929-7308 Mobile</td></tr><tr style=3D"vertical-=
align:middle"><td width=3D"30" style=3D"vertical-align:middle"><table cells=
pacing=3D"0" cellpadding=3D"0" style=3D"vertical-align:-webkit-baseline-mid=
dle;font-family:Arial"><tbody><tr><td style=3D"vertical-align:bottom"><span=
 style=3D"display:block;background-color:rgb(34,72,229)"><img src=3D"https:=
//cdn2.hubspot.net/hubfs/53/tools/email-signature-generator/icons/email-ico=
n-2x.png" width=3D"13" style=3D"display:block"></span></td></tr></tbody></t=
able></td><td style=3D"padding:2px"><a href=3D"mailto:scott.mcgrath@oasis-o=
pen.org" style=3D"color:rgb(0,0,0);font-size:12px" target=3D"_blank">scott.=
mcgrath@oasis-open.org</a></td></tr><tr style=3D"vertical-align:middle"><td=
 width=3D"30" style=3D"vertical-align:middle"><table cellspacing=3D"0" cell=
padding=3D"0" style=3D"vertical-align:-webkit-baseline-middle;font-family:A=
rial"><tbody><tr><td style=3D"vertical-align:bottom"><span style=3D"display=
:block;background-color:rgb(34,72,229)"><img src=3D"https://cdn2.hubspot.ne=
t/hubfs/53/tools/email-signature-generator/icons/link-icon-2x.png" width=3D=
"13" style=3D"display:block"></span></td></tr></tbody></table></td><td styl=
e=3D"padding:2px"><a href=3D"https://www.oasis-open.org/" style=3D"color:rg=
b(0,0,0);font-size:12px" target=3D"_blank">www.oasis-open.org</a></td></tr>=
</tbody></table></td></tr></tbody></table></div></div></div>

--000000000000ba327d060bcc9edb--
