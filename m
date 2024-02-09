Return-Path: <virtio-dev-return-14297-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27F1C4828F
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Feb 2024 23:01:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 06DAC1318F3
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Feb 2024 23:00:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F181D986570
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Feb 2024 23:00:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E0D16984699; Fri,  9 Feb 2024 23:00:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B5D6C986960
	for <virtio-dev@lists.oasis-open.org>; Fri,  9 Feb 2024 23:00:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707519629; x=1708124429;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=noKz2TlFrpnXOFAXMBpLyML6mhRtdB5gNywcNfzxtxo=;
        b=kquMzSU0IwdD+I+NtzJpISbiI1yARI8jXmPhrvbpUL3xf/g+dXDqvvDqqqtnjFJxPD
         LKlGRlu+Uc3ZSjV05S2Ovshvg4AwOd/HkvilX6/prZN4lKnaxXIGREaGk9phXHfX5I+J
         7emFniBnUwo84xRJx/3y62TQFGIXqhRq6Eu5t51yOa+qZO3h9q7SaZVy4V2ee8m29yXw
         HE98eG96APzAJd2VWEbNRFHaaK/gepdz6kxXxrxXbF6lVtLP/kfnvXdcpRh3JRwK7y7F
         LgfAF+0115areC5t8XnYcVQnOzHFT1jQdstKhjwcp7vJTd1wizt3sAOR5egdd66EYgSz
         o6sg==
X-Gm-Message-State: AOJu0Yy0l7dZHlRAq0ahwjS806vohRE6De4uQu7wwMyk6tSRbAqBvCYv
	CzsK1uWWlSW/mSpQrdsGqBxpuqRUliWgCA/XG8vvZvFpYQzTHvy7IKYQ3HVeT4wOJjVEeZTbezy
	6shXOmuj0VJgHMvqAp+g5Lh7UAeMrLHqr2nXc2DI7
X-Google-Smtp-Source: AGHT+IHwOwlbbUr+l/jH/XuZ173YEx5gza0K9beLWkMeiPPdzF6SBBs1D6CDWeVNVeRA/eHsP2JPYd/2NYQfqBDEX78=
X-Received: by 2002:a25:a28a:0:b0:dc6:1a18:12e0 with SMTP id
 c10-20020a25a28a000000b00dc61a1812e0mr632953ybi.28.1707519628835; Fri, 09 Feb
 2024 15:00:28 -0800 (PST)
MIME-Version: 1.0
From: Scott McGrath <scott.mcgrath@oasis-open.org>
Date: Fri, 9 Feb 2024 18:00:18 -0500
Message-ID: <CAD2Xst-9BQdv9MZNq2A0RpFsvdh2F5_kHAJcJ1vYb32Me0KHRQ@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000ec8dcf0610fae473"
Subject: [virtio-dev] Migration schedule update for this mail list

--000000000000ec8dcf0610fae473
Content-Type: text/plain; charset="UTF-8"

I am very pleased to announce a new List Mail system will be implemented
for this list shortly.

The legacy list engine in use since 2003 will go offline for migration
20-24 February.  You are receiving this message because you are a
subscriber to the list receiving this message.

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

   All resources created in the legacy email system will be migrated and
   available cohesively with your new work in the new platform.  All URL links
   for assets in the old platform will redirect to the new location



   -

   After the migration you will be directed where to send future messages
   for this list and where to find the archives.  You should update your
   bookmark and email contact list accordingly



   -

   After the migration you will be required to create or login to an
   existing OASIS public community or member account to manage your
   subscriptions.  Legacy-style subscribe and unsubscribe email messages to
   the server will not be respected.



The Transition Schedule

This mail list will be offline 20-24 February. During the downtime you will
not receive email messages sent to this list or have access to the
archive.  Senders will receive a reply pointing them to current migration
status information and where to find the new resources.

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

--000000000000ec8dcf0610fae473
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span id=3D"gmail-docs-internal-guid-cd17843b-7fff-0109-34=
2d-587a2dfea827"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;ma=
rgin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif=
;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;=
font-variant-east-asian:normal;font-variant-alternates:normal;vertical-alig=
n:baseline">I am very pleased to announce a new List Mail system will be im=
plemented for this list shortly.=C2=A0</span></p><br><p dir=3D"ltr" style=
=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-=
size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:tr=
ansparent;font-weight:700;font-variant-numeric:normal;font-variant-east-asi=
an:normal;font-variant-alternates:normal;vertical-align:baseline">The legac=
y list engine in use since 2003 will go offline for migration 20-24 Februar=
y.</span><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:r=
gb(0,0,0);background-color:transparent;font-variant-numeric:normal;font-var=
iant-east-asian:normal;font-variant-alternates:normal;vertical-align:baseli=
ne">=C2=A0 You are receiving this message because you are a subscriber to t=
he list receiving this message.</span></p><br><p dir=3D"ltr" style=3D"line-=
height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt=
;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent=
;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-al=
ternates:normal;vertical-align:baseline">This transition will provide signi=
ficant improvements and will change how you interact with your mail lists.=
=C2=A0 See below for more information about the changes, the transition sch=
edule and what you can do to help.</span></p><br><p dir=3D"ltr" style=3D"li=
ne-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:1=
1pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transpar=
ent;font-weight:700;font-variant-numeric:normal;font-variant-east-asian:nor=
mal;font-variant-alternates:normal;vertical-align:baseline">Changes to Expe=
ct</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;ma=
rgin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif=
;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;=
font-variant-east-asian:normal;font-variant-alternates:normal;vertical-alig=
n:baseline">The new platform is built in a modern web environment and mail =
delivery mechanism. with a number of new features to improve both your plat=
form user experience and ability to engage with the OASIS community.=C2=A0 =
Key features include:</span></p><br><ul style=3D"margin-top:0px;margin-bott=
om:0px"><li dir=3D"ltr" style=3D"list-style-type:disc;font-size:11pt;font-f=
amily:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-v=
ariant-numeric:normal;font-variant-east-asian:normal;font-variant-alternate=
s:normal;vertical-align:baseline;white-space:pre"><p dir=3D"ltr" style=3D"l=
ine-height:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"presentation"><sp=
an style=3D"font-size:11pt;background-color:transparent;font-variant-numeri=
c:normal;font-variant-east-asian:normal;font-variant-alternates:normal;vert=
ical-align:baseline">Mail systems that you can depend on!=C2=A0 The new too=
ls support and comply with major deliverability and anti-spoofing standards=
.=C2=A0 This will eliminate many of the sending and deliverability issues y=
our group may be experiencing</span></p></li></ul><br><ul style=3D"margin-t=
op:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-style-type:disc;fon=
t-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:=
transparent;font-variant-numeric:normal;font-variant-east-asian:normal;font=
-variant-alternates:normal;vertical-align:baseline;white-space:pre"><p dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" role=
=3D"presentation"><span style=3D"font-size:11pt;background-color:transparen=
t;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-a=
lternates:normal;vertical-align:baseline">Modern web interface and design f=
or your committee internal work and public presentation of your work</span>=
</p></li></ul><br><ul style=3D"margin-top:0px;margin-bottom:0px"><li dir=3D=
"ltr" style=3D"list-style-type:disc;font-size:11pt;font-family:Arial,sans-s=
erif;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:nor=
mal;font-variant-east-asian:normal;font-variant-alternates:normal;vertical-=
align:baseline;white-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38;ma=
rgin-top:0pt;margin-bottom:0pt" role=3D"presentation"><span style=3D"font-s=
ize:11pt;background-color:transparent;font-variant-numeric:normal;font-vari=
ant-east-asian:normal;font-variant-alternates:normal;vertical-align:baselin=
e">If you are on this public list in addition to Technical Committees, Open=
 Projects, and other community engagement mail lists you can manage this ex=
perience in one cohesive package=C2=A0=C2=A0</span></p></li></ul><br><ul st=
yle=3D"margin-top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-styl=
e-type:disc;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);ba=
ckground-color:transparent;font-variant-numeric:normal;font-variant-east-as=
ian:normal;font-variant-alternates:normal;vertical-align:baseline;white-spa=
ce:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bott=
om:0pt" role=3D"presentation"><span style=3D"font-size:11pt;background-colo=
r:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;fo=
nt-variant-alternates:normal;vertical-align:baseline">All resources created=
 in the legacy email system will be migrated and available cohesively with =
your new work in the new platform.=C2=A0 All URL links for assets in the ol=
d platform will redirect to the new location</span></p></li></ul><br><ul st=
yle=3D"margin-top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-styl=
e-type:disc;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);ba=
ckground-color:transparent;font-variant-numeric:normal;font-variant-east-as=
ian:normal;font-variant-alternates:normal;vertical-align:baseline;white-spa=
ce:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bott=
om:0pt" role=3D"presentation"><span style=3D"font-size:11pt;background-colo=
r:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;fo=
nt-variant-alternates:normal;vertical-align:baseline">After the migration y=
ou will be directed where to send future messages for this list and where t=
o find the archives.=C2=A0 You should update your bookmark and email contac=
t list accordingly</span></p></li></ul><br><ul style=3D"margin-top:0px;marg=
in-bottom:0px"><li dir=3D"ltr" style=3D"list-style-type:disc;font-size:11pt=
;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent=
;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-al=
ternates:normal;vertical-align:baseline;white-space:pre"><p dir=3D"ltr" sty=
le=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"presentati=
on"><span style=3D"font-size:11pt;background-color:transparent;font-variant=
-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norm=
al;vertical-align:baseline">After the migration you will be required to cre=
ate or login to an existing OASIS public community or member account to man=
age your subscriptions.=C2=A0 Legacy-style subscribe and unsubscribe email =
messages to the server will not be respected.</span></p></li></ul><br><br><=
p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><=
span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);=
background-color:transparent;font-weight:700;font-variant-numeric:normal;fo=
nt-variant-east-asian:normal;font-variant-alternates:normal;vertical-align:=
baseline">The Transition Schedule</span></p><br><p dir=3D"ltr" style=3D"lin=
e-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11=
pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transpare=
nt;font-weight:700;font-variant-numeric:normal;font-variant-east-asian:norm=
al;font-variant-alternates:normal;vertical-align:baseline">This mail list w=
ill be offline 20-24 February. </span><span style=3D"font-size:11pt;font-fa=
mily:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-va=
riant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates=
:normal;vertical-align:baseline">During the downtime you will not receive e=
mail messages sent to this list or have access to the archive.=C2=A0 Sender=
s will receive a reply pointing them to current migration status informatio=
n and where to find the new resources.</span></p><br><p dir=3D"ltr" style=
=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-=
size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:tr=
ansparent;font-weight:700;font-variant-numeric:normal;font-variant-east-asi=
an:normal;font-variant-alternates:normal;vertical-align:baseline">What You =
Should Do Now</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin=
-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial=
,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-nume=
ric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;ve=
rtical-align:baseline">If you no longer wish to subscribe to this list, sen=
d a message to [listname]</span><a href=3D"mailto:-unsubscribe@lists.oasis-=
open.org" style=3D"text-decoration-line:none"><span style=3D"font-size:11pt=
;font-family:Arial,sans-serif;background-color:transparent;font-variant-num=
eric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;t=
ext-decoration-line:underline;vertical-align:baseline">-unsubscribe@lists.o=
asis-open.org</span></a></p><br><p dir=3D"ltr" style=3D"line-height:1.38;ma=
rgin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:A=
rial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-=
numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norma=
l;vertical-align:baseline">Otherwise, watch for further messages in the com=
ing days to include the new list mailing address and archive location.</spa=
n></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bo=
ttom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:=
rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;font-va=
riant-east-asian:normal;font-variant-alternates:normal;vertical-align:basel=
ine">Feel free to contact me with any questions, and thanks for your patien=
ce with the inevitable short-term inconvenience implementing these improvem=
ents will bring.</span></p></span><br class=3D"gmail-Apple-interchange-newl=
ine"><div><br></div><span class=3D"gmail_signature_prefix">-- </span><br><d=
iv dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"=
><div dir=3D"ltr"><table cellspacing=3D"0" cellpadding=3D"0" style=3D"font-=
family:Arial;vertical-align:-webkit-baseline-middle"><tbody><tr><td width=
=3D"70" style=3D"vertical-align:middle"><span style=3D"margin-right:5px;dis=
play:block"><img width=3D"70" height=3D"70" style=3D"max-width:70px" src=3D=
"https://ci3.googleusercontent.com/mail-sig/AIorK4wWWvttK4QvAyLjmQRfbisd2jd=
vX84ncnFeBuJn9NtWvi8WHJIwVlm1HGm8Re2Ji0U6N10brtc"></span></td><td style=3D"=
vertical-align:middle"><h3 style=3D"margin:0px;font-size:16px;color:rgb(0,0=
,0)">Scott=C2=A0McGrath</h3><p style=3D"margin:0px;color:rgb(0,0,0);font-si=
ze:12px;line-height:20px">Chief Operating Officer</p><p style=3D"margin:0px=
;color:rgb(0,0,0);font-size:12px;line-height:20px">OASIS Open</p></td><td w=
idth=3D"30">=C2=A0</td><td width=3D"1" style=3D"width:1px;border-bottom:non=
e;border-left:1px solid rgb(34,72,229)">=C2=A0</td><td width=3D"30">=C2=A0<=
/td><td style=3D"vertical-align:middle"><table cellspacing=3D"0" cellpaddin=
g=3D"0" style=3D"vertical-align:-webkit-baseline-middle;font-family:Arial">=
<tbody><tr style=3D"vertical-align:middle"><td width=3D"30" style=3D"vertic=
al-align:middle"><table cellspacing=3D"0" cellpadding=3D"0" style=3D"vertic=
al-align:-webkit-baseline-middle;font-family:Arial"><tbody><tr><td style=3D=
"vertical-align:bottom"><span style=3D"display:block;background-color:rgb(3=
4,72,229)"><img src=3D"https://cdn2.hubspot.net/hubfs/53/tools/email-signat=
ure-generator/icons/phone-icon-2x.png" width=3D"13" style=3D"display:block"=
></span></td></tr></tbody></table></td><td style=3D"padding:2px;color:rgb(0=
,0,0)"><br>+1 781-929-7308 Mobile</td></tr><tr style=3D"vertical-align:midd=
le"><td width=3D"30" style=3D"vertical-align:middle"><table cellspacing=3D"=
0" cellpadding=3D"0" style=3D"vertical-align:-webkit-baseline-middle;font-f=
amily:Arial"><tbody><tr><td style=3D"vertical-align:bottom"><span style=3D"=
display:block;background-color:rgb(34,72,229)"><img src=3D"https://cdn2.hub=
spot.net/hubfs/53/tools/email-signature-generator/icons/email-icon-2x.png" =
width=3D"13" style=3D"display:block"></span></td></tr></tbody></table></td>=
<td style=3D"padding:2px"><a href=3D"mailto:scott.mcgrath@oasis-open.org" s=
tyle=3D"color:rgb(0,0,0);font-size:12px" target=3D"_blank">scott.mcgrath@oa=
sis-open.org</a></td></tr><tr style=3D"vertical-align:middle"><td width=3D"=
30" style=3D"vertical-align:middle"><table cellspacing=3D"0" cellpadding=3D=
"0" style=3D"vertical-align:-webkit-baseline-middle;font-family:Arial"><tbo=
dy><tr><td style=3D"vertical-align:bottom"><span style=3D"display:block;bac=
kground-color:rgb(34,72,229)"><img src=3D"https://cdn2.hubspot.net/hubfs/53=
/tools/email-signature-generator/icons/link-icon-2x.png" width=3D"13" style=
=3D"display:block"></span></td></tr></tbody></table></td><td style=3D"paddi=
ng:2px"><a href=3D"https://www.oasis-open.org/" style=3D"color:rgb(0,0,0);f=
ont-size:12px" target=3D"_blank">www.oasis-open.org</a></td></tr></tbody></=
table></td></tr></tbody></table></div></div></div>

--000000000000ec8dcf0610fae473--
