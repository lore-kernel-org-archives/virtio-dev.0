Return-Path: <virtio-dev-return-14150-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB06C4332F
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Dec 2023 17:53:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7ADF11318D7
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Dec 2023 17:52:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5A201986973
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Dec 2023 17:52:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 41C529867AF; Thu, 14 Dec 2023 17:52:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6F175986AE6
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Dec 2023 17:49:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702576158; x=1703180958;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vspDngU/GkP+W8JovlDiSCzUTIfppJym89XjBrOySDM=;
        b=vbPT5pOW96EnxU5fpBd9mNp2Wye+TU4tsFuSYfhkDMSzyE4q63oSAjxgDz+JAYIRXL
         /Yu1OKoVFvCCQJXm1lu9YbwIOaAARN0vtzuYEa6/d0hWAmnUAX7f7Uld2Fng4FurOBVz
         uA1lvjv0VRAlb5f/D/vV72h24q4fHWEQeDbf9aFxs3gckpn55GFgA0OLP/XwgubyAVsJ
         SwVnBttxFDYshY+/TRPxXLF8uJGki5nE8Za5arlgKaj9KOHX7wcZdLVl9rSjR75e7zVi
         kdzhfsRn8gI9GQo5NFwhbkueyyft3CS+1NHn6T2MtEPEQoOIlGCcZ1zwf9kQdB8p3jyK
         rKxg==
X-Gm-Message-State: AOJu0YwKWIO76lcTVyWODm5GBEVHQDsBgbjhUPMtGzlaJyPLV9CGA6bf
	4+lPafyyW/CeCEjwFYa5RTRioPbKtsNjLOT/IVMU54od
X-Google-Smtp-Source: AGHT+IFBi70352RsoEaDl5wDdM111HuZd7hxAwjpPsCOSrSYwE8TjcVZqIrVtP7MB5FBLS1F6O8xKdhlhYlkYSsgsAI=
X-Received: by 2002:a25:9385:0:b0:dbc:cef2:b545 with SMTP id
 a5-20020a259385000000b00dbccef2b545mr1835147ybm.2.1702576158451; Thu, 14 Dec
 2023 09:49:18 -0800 (PST)
MIME-Version: 1.0
From: Scott McGrath <scott.mcgrath@oasis-open.org>
Date: Thu, 14 Dec 2023 12:49:07 -0500
Message-ID: <CAD2Xst_syJj=sWZdz-XuAEaDhBxYn1dN_Jho2Hh5XQbF53D46Q@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="00000000000020bddb060c7be764"
Subject: [virtio-dev] Updated schedule for OASIS mail list system upgrade

--00000000000020bddb060c7be764
Content-Type: text/plain; charset="UTF-8"

We Recently announced the migration to a new List Mail system for this
list. We've modified the implementation process to allow the legacy system
to continue running a bit longer and to have a shorter downtime during
transition.


*The system cut-over is now scheduled for the first week of January *


Miss the original announcement?  Here it is...

The legacy list engine in use since 2003 will be replaced in this upgrade.
You are receiving this message because you are a subscriber to the list
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

   Modern web interface and design for your committee internal work and
   public presentation of your work



   -

   If you are on this public list in addition to Technical Committees, Open
   Projects, and other community engagement mail lists you can manage this
   experience in one cohesive package



   -

   All archives created in the legacy email system will be migrated and
   available cohesively with your new work in the new platform.  All URL links
   for assets in the old platform will redirect to the new location



   -

   After the cutover starts, you will be directed where to send future
   messages for this list and where to find the archives. Any message sent to
   a legacy list address after the cutover begins will receive an auto reply
   with the new list address and archive location.



   -

   After the migration you can continue using the mail list as before. If
   you wish to join additional public lists or modify your delivery to the new
   digest delivery, you will be required to create or login to an existing
   OASIS public community or member account to manage your subscriptions.
   This account system will be used to confirm your email address once (as
   opposed to each subscription) and will be the same account you may be using
   now for OASIS membership, submitting e-CLA forms etc. Legacy-style
   subscribe and unsubscribe email messages to the server will not be
   respected in the new system.



The Transition Schedule

During the cut-over the first week of January, There will be some system
downtime during the cutover. During the downtime you will not receive email
messages sent to this list or have access to the archive.  All messages
sent after the cut-over begins will receive an auto reply announcing the
new list address and archive location.

We will announce the timing specific as we get closer to the transition.

What You Should Do Now

If you no longer wish to subscribe to this list, send a message to
[listname]-unsubscribe@lists.oasis-open.org

Otherwise, watch for further messages in the coming days to include the new
list mailing address and archive location.

Feel free to contact me with any questions, and thanks for your patience
with the inevitable short-term inconvenience implementing these
improvements will bring.

-- 
Scott McGrath

Chief Operating Officer

OASIS Open


+1 781-929-7308 Mobile
scott.mcgrath@oasis-open.org
www.oasis-open.org

--00000000000020bddb060c7be764
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span id=3D"gmail-docs-internal-guid-64dc5fe4-7fff-eafa-5d=
8c-6960ff2ec20d"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;ma=
rgin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif=
;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;=
font-variant-east-asian:normal;font-variant-alternates:normal;vertical-alig=
n:baseline">We Recently announced the migration to a new List Mail system f=
or this list.  We&#39;ve modified the implementation process to allow the l=
egacy system to continue running a bit longer and to have a shorter downtim=
e during transition.</span></p><p dir=3D"ltr" style=3D"line-height:1.38;mar=
gin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Ar=
ial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-n=
umeric:normal;font-variant-east-asian:normal;font-variant-alternates:normal=
;vertical-align:baseline"><br></span></p><p style=3D"line-height:1.38;margi=
n-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Aria=
l,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-num=
eric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;v=
ertical-align:baseline"><b>The system cut-over is now scheduled for the fir=
st week of January=C2=A0</b></span></p><div><br></div><div><br></div>Miss t=
he original announcement?=C2=A0 Here it is...</span><div><br><p dir=3D"ltr"=
 style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D=
"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-co=
lor:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;=
font-variant-alternates:normal;vertical-align:baseline">The legacy list eng=
ine in use since 2003 will be replaced in this upgrade.=C2=A0 You are recei=
ving this message because you are a subscriber to the list receiving this m=
essage.</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0=
pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-=
serif;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:no=
rmal;font-variant-east-asian:normal;font-variant-alternates:normal;vertical=
-align:baseline">This transition will provide significant improvements and =
will change how you interact with your mail lists.=C2=A0 See below for more=
 information about the changes, the transition schedule and what you can do=
 to help.</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top=
:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,san=
s-serif;color:rgb(0,0,0);background-color:transparent;font-weight:700;font-=
variant-numeric:normal;font-variant-east-asian:normal;font-variant-alternat=
es:normal;vertical-align:baseline">Changes to Expect</span></p><br><p dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span =
style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);backg=
round-color:transparent;font-variant-numeric:normal;font-variant-east-asian=
:normal;font-variant-alternates:normal;vertical-align:baseline">The new pla=
tform is built in a modern web environment and mail delivery mechanism. wit=
h a number of new features to improve both your platform user experience an=
d ability to engage with the OASIS community.=C2=A0 Key features include:</=
span></p><br><ul style=3D"margin-top:0px;margin-bottom:0px"><li dir=3D"ltr"=
 style=3D"list-style-type:disc;font-size:11pt;font-family:Arial,sans-serif;=
color:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;f=
ont-variant-east-asian:normal;font-variant-alternates:normal;vertical-align=
:baseline;white-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-=
top:0pt;margin-bottom:0pt" role=3D"presentation"><span style=3D"font-size:1=
1pt;background-color:transparent;font-variant-numeric:normal;font-variant-e=
ast-asian:normal;font-variant-alternates:normal;vertical-align:baseline">Ma=
il systems that you can depend on!=C2=A0 The new tools support and comply w=
ith major deliverability and anti-spoofing standards.=C2=A0 This will elimi=
nate many of the sending and deliverability issues your group may be experi=
encing</span></p></li></ul><br><ul style=3D"margin-top:0px;margin-bottom:0p=
x"><li dir=3D"ltr" style=3D"list-style-type:disc;font-size:11pt;font-family=
:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-varian=
t-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:nor=
mal;vertical-align:baseline;white-space:pre"><p dir=3D"ltr" style=3D"line-h=
eight:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"presentation"><span st=
yle=3D"font-size:11pt;background-color:transparent;font-variant-numeric:nor=
mal;font-variant-east-asian:normal;font-variant-alternates:normal;vertical-=
align:baseline">Modern web interface and design for your committee internal=
 work and public presentation of your work</span></p></li></ul><br><ul styl=
e=3D"margin-top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-style-=
type:disc;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);back=
ground-color:transparent;font-variant-numeric:normal;font-variant-east-asia=
n:normal;font-variant-alternates:normal;vertical-align:baseline;white-space=
:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom=
:0pt" role=3D"presentation"><span style=3D"font-size:11pt;background-color:=
transparent;font-variant-numeric:normal;font-variant-east-asian:normal;font=
-variant-alternates:normal;vertical-align:baseline">If you are on this publ=
ic list in addition to Technical Committees, Open Projects, and other commu=
nity engagement mail lists you can manage this experience in one cohesive p=
ackage=C2=A0=C2=A0</span></p></li></ul><br><ul style=3D"margin-top:0px;marg=
in-bottom:0px"><li dir=3D"ltr" style=3D"list-style-type:disc;font-size:11pt=
;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent=
;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-al=
ternates:normal;vertical-align:baseline;white-space:pre"><p dir=3D"ltr" sty=
le=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"presentati=
on"><span style=3D"font-size:11pt;background-color:transparent;font-variant=
-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norm=
al;vertical-align:baseline">All archives created in the legacy email system=
 will be migrated and available cohesively with your new work in the new pl=
atform.=C2=A0 All URL links for assets in the old platform will redirect to=
 the new location</span></p></li></ul><br><ul style=3D"margin-top:0px;margi=
n-bottom:0px"><li dir=3D"ltr" style=3D"list-style-type:disc;font-size:11pt;=
font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;=
font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alt=
ernates:normal;vertical-align:baseline;white-space:pre"><p dir=3D"ltr" styl=
e=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"presentatio=
n"><span style=3D"font-size:11pt;background-color:transparent;font-variant-=
numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norma=
l;vertical-align:baseline">After the cutover starts, you will be directed w=
here to send future messages for this list and where to find the archives. =
 Any message sent to a legacy list address after the cutover begins will re=
ceive an auto reply with the new list address and archive location.</span><=
/p></li></ul><br><ul style=3D"margin-top:0px;margin-bottom:0px"><li dir=3D"=
ltr" style=3D"list-style-type:disc;font-size:11pt;font-family:Arial,sans-se=
rif;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:norm=
al;font-variant-east-asian:normal;font-variant-alternates:normal;vertical-a=
lign:baseline;white-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38;mar=
gin-top:0pt;margin-bottom:0pt" role=3D"presentation"><span style=3D"font-si=
ze:11pt;background-color:transparent;font-variant-numeric:normal;font-varia=
nt-east-asian:normal;font-variant-alternates:normal;vertical-align:baseline=
">After the migration you can continue using the mail list as before.  If y=
ou wish to join additional public lists or modify your delivery to the new =
digest delivery, you will be required to create or login to an existing OAS=
IS public community or member account to manage your subscriptions.=C2=A0 T=
his account system will be used to confirm your email address once (as oppo=
sed to each subscription) and will be the same account you may be using now=
 for OASIS membership, submitting e-CLA forms etc.   Legacy-style subscribe=
 and unsubscribe email messages to the server will not be respected in the =
new system.</span></p></li></ul><br><br><p dir=3D"ltr" style=3D"line-height=
:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-=
family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-=
weight:700;font-variant-numeric:normal;font-variant-east-asian:normal;font-=
variant-alternates:normal;vertical-align:baseline">The Transition Schedule<=
/span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margi=
n-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;co=
lor:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;fon=
t-variant-east-asian:normal;font-variant-alternates:normal;vertical-align:b=
aseline">During the cut-over the first week of January,  There will be some=
 system downtime during the cutover. During the downtime you will not recei=
ve email messages sent to this list or have access to the archive.=C2=A0=C2=
=A0All messages sent after the cut-over begins will receive an auto reply a=
nnouncing the new list address and archive location.</span></p><br><p dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span =
style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);backg=
round-color:transparent;font-variant-numeric:normal;font-variant-east-asian=
:normal;font-variant-alternates:normal;vertical-align:baseline">We will ann=
ounce the timing specific as we get closer to the transition.</span></p><br=
><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0=
);background-color:transparent;font-weight:700;font-variant-numeric:normal;=
font-variant-east-asian:normal;font-variant-alternates:normal;vertical-alig=
n:baseline">What You Should Do Now</span></p><br><p dir=3D"ltr" style=3D"li=
ne-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:1=
1pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transpar=
ent;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant=
-alternates:normal;vertical-align:baseline">If you no longer wish to subscr=
ibe to this list, send a message to [listname]</span><a href=3D"mailto:-uns=
ubscribe@lists.oasis-open.org" style=3D"text-decoration-line:none"><span st=
yle=3D"font-size:11pt;font-family:Arial,sans-serif;background-color:transpa=
rent;font-variant-numeric:normal;font-variant-east-asian:normal;font-varian=
t-alternates:normal;text-decoration-line:underline;vertical-align:baseline"=
>-unsubscribe@lists.oasis-open.org</span></a></p><br><p dir=3D"ltr" style=
=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-=
size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:tr=
ansparent;font-variant-numeric:normal;font-variant-east-asian:normal;font-v=
ariant-alternates:normal;vertical-align:baseline">Otherwise, watch for furt=
her messages in the coming days to include the new list mailing address and=
 archive location.</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;m=
argin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:=
Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant=
-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norm=
al;vertical-align:baseline">Feel free to contact me with any questions, and=
 thanks for your patience with the inevitable short-term inconvenience impl=
ementing these improvements will bring.</span></p></div><div><br></div><spa=
n class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"=
gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><table=
 cellspacing=3D"0" cellpadding=3D"0" style=3D"font-family:Arial;vertical-al=
ign:-webkit-baseline-middle"><tbody><tr><td width=3D"70" style=3D"vertical-=
align:middle"><span style=3D"margin-right:5px;display:block"><img width=3D"=
70" height=3D"70" style=3D"max-width:70px" src=3D"https://ci3.googleusercon=
tent.com/mail-sig/AIorK4wWWvttK4QvAyLjmQRfbisd2jdvX84ncnFeBuJn9NtWvi8WHJIwV=
lm1HGm8Re2Ji0U6N10brtc"></span></td><td style=3D"vertical-align:middle"><h3=
 style=3D"margin:0px;font-size:16px;color:rgb(0,0,0)">Scott=C2=A0McGrath</h=
3><p style=3D"margin:0px;color:rgb(0,0,0);font-size:12px;line-height:20px">=
Chief Operating Officer</p><p style=3D"margin:0px;color:rgb(0,0,0);font-siz=
e:12px;line-height:20px">OASIS Open</p></td><td width=3D"30">=C2=A0</td><td=
 width=3D"1" style=3D"width:1px;border-bottom:none;border-left:1px solid rg=
b(34,72,229)">=C2=A0</td><td width=3D"30">=C2=A0</td><td style=3D"vertical-=
align:middle"><table cellspacing=3D"0" cellpadding=3D"0" style=3D"vertical-=
align:-webkit-baseline-middle;font-family:Arial"><tbody><tr style=3D"vertic=
al-align:middle"><td width=3D"30" style=3D"vertical-align:middle"><table ce=
llspacing=3D"0" cellpadding=3D"0" style=3D"vertical-align:-webkit-baseline-=
middle;font-family:Arial"><tbody><tr><td style=3D"vertical-align:bottom"><s=
pan style=3D"display:block;background-color:rgb(34,72,229)"><img src=3D"htt=
ps://cdn2.hubspot.net/hubfs/53/tools/email-signature-generator/icons/phone-=
icon-2x.png" width=3D"13" style=3D"display:block"></span></td></tr></tbody>=
</table></td><td style=3D"padding:2px;color:rgb(0,0,0)"><br>+1 781-929-7308=
 Mobile</td></tr><tr style=3D"vertical-align:middle"><td width=3D"30" style=
=3D"vertical-align:middle"><table cellspacing=3D"0" cellpadding=3D"0" style=
=3D"vertical-align:-webkit-baseline-middle;font-family:Arial"><tbody><tr><t=
d style=3D"vertical-align:bottom"><span style=3D"display:block;background-c=
olor:rgb(34,72,229)"><img src=3D"https://cdn2.hubspot.net/hubfs/53/tools/em=
ail-signature-generator/icons/email-icon-2x.png" width=3D"13" style=3D"disp=
lay:block"></span></td></tr></tbody></table></td><td style=3D"padding:2px">=
<a href=3D"mailto:scott.mcgrath@oasis-open.org" style=3D"color:rgb(0,0,0);f=
ont-size:12px" target=3D"_blank">scott.mcgrath@oasis-open.org</a></td></tr>=
<tr style=3D"vertical-align:middle"><td width=3D"30" style=3D"vertical-alig=
n:middle"><table cellspacing=3D"0" cellpadding=3D"0" style=3D"vertical-alig=
n:-webkit-baseline-middle;font-family:Arial"><tbody><tr><td style=3D"vertic=
al-align:bottom"><span style=3D"display:block;background-color:rgb(34,72,22=
9)"><img src=3D"https://cdn2.hubspot.net/hubfs/53/tools/email-signature-gen=
erator/icons/link-icon-2x.png" width=3D"13" style=3D"display:block"></span>=
</td></tr></tbody></table></td><td style=3D"padding:2px"><a href=3D"https:/=
/www.oasis-open.org/" style=3D"color:rgb(0,0,0);font-size:12px" target=3D"_=
blank">www.oasis-open.org</a></td></tr></tbody></table></td></tr></tbody></=
table></div></div></div>

--00000000000020bddb060c7be764--
