Return-Path: <virtio-dev-return-14147-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA167C4167D
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Dec 2023 14:18:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 32C898812D
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Dec 2023 14:18:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0DCF49866EA
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Dec 2023 14:18:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E3B4D9866E1; Thu, 14 Dec 2023 14:18:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1AE19866E0
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Dec 2023 14:18:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702563522; x=1703168322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pl4y3h233bpt32reFX3c6bnwI7tu2519PGMsZMS7IFg=;
        b=G83pXeTeuyOhS+pq24zBDe+mk/s+ZLhF1Pq+7UHtkWDSb7kDBwln+00l5hMyGpdHz5
         o2QZFWln6CkjNApPd4OzjzwQM1j74Km4iTShqa0gg4CZBfNcsRObnZBfhpY7rtyMTsdU
         ZGF034usILlwc4/jPxAt/Cf3hSVfrSfLD8ftbzKhdx2ct7Ch7wY3C6Wr7GN8GrHm+CwU
         RjWQz9iKq3NwhnCEvX7evFWakM4ojDmbPJEQoOqvX2yuqogy5pQPdf2xL+qI55j4vKZe
         DxqyH6bYg8q4BHwB8dF5gPU05zHrLTxQNHSmdJYI+Mc4cZthK2taK5b2bjP5LQBfJEbR
         KNfw==
X-Gm-Message-State: AOJu0YyPt5FkaA/j+uTNRL2uESu+t1Tg3mgAvAulyFIlucEaiQmF20eX
	Wy6/QeaxWJGDhBedWjSxgGxvL1gQBOvRB5D97/Ab+Tbb
X-Google-Smtp-Source: AGHT+IG7hIiHlflBYewKwocQuNDtktR970d/cVJTYueLUcn4I2NrIpBVrKy2QTyBLQQGo3Tq5yMvFWfXQXH/OH3g5RA=
X-Received: by 2002:a5b:f81:0:b0:db5:4ee8:b304 with SMTP id
 q1-20020a5b0f81000000b00db54ee8b304mr6348574ybh.39.1702563522562; Thu, 14 Dec
 2023 06:18:42 -0800 (PST)
MIME-Version: 1.0
References: <CAD2Xst-H_xBEyaM7R=bygwVafWUfGNADEdXq0F6drAD1rKy4zg@mail.gmail.com>
 <878r5xghh7.fsf@redhat.com>
In-Reply-To: <878r5xghh7.fsf@redhat.com>
From: Scott McGrath <scott.mcgrath@oasis-open.org>
Date: Thu, 14 Dec 2023 09:18:30 -0500
Message-ID: <CAD2Xst8O4Tnd3eUXfmrHQu3MzppguT7L3f--A6U1KjcPr3fitA@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, 
	virtio-comment@lists.oasis-open.org
Content-Type: multipart/alternative; boundary="000000000000f85ee5060c78f56e"
Subject: [virtio-dev] Re: [virtio-comment] Changes coming to this mail list system

--000000000000f85ee5060c78f56e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes,  the cut-over to the new system is now expected the first week of
January.  We've delayed the process, in part, because we've found ways to
shorten the downtime for the mail lists and are working on some of those
implementation steps now in the background while the legacy systems
continue to serve.  Of course, closing in on the holidays os an issue as
well factoring in the delay.

Two other notes:

I'll push the announcement to all other lists (non-member lists) this
morning.

The migration plan changes will better ensure messages sent during the
downtime will not be lost and the downtime will be less than we originally
expected.

Hope that helps,

Scott...

On Thu, Dec 14, 2023 at 6:18=E2=80=AFAM Cornelia Huck <cohuck@redhat.com> w=
rote:

> On Tue, Dec 05 2023, Scott McGrath <scott.mcgrath@oasis-open.org> wrote:
>
> [dropped non-virtio lists, added the other virtio lists]
>
> > The Transition Schedule
> >
> > Starting 14 December, there may be as much as several days of system
> > downtime. During the downtime you will not receive email messages sent =
to
> > this list or have access to the archive.
> >
> > We will announce the timing specific as we get closer to the transition=
.
>
> I've received off-list notification that this change is now postponed to
> January -- can you please confirm? It is important for us to plan how we
> are going to proceed with the 1.3 version of the virtio spec.  (And it
> is of course also important for people reading those lists, who may not
> have an account in the system.)
>
>

--=20
Scott McGrath

Chief Operating Officer

OASIS Open


+1 781-929-7308 Mobile
scott.mcgrath@oasis-open.org
www.oasis-open.org

--000000000000f85ee5060c78f56e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes,=C2=A0 the cut-over to the new system is now expected =
the first week of January.=C2=A0 We&#39;ve delayed the process, in part,=C2=
=A0because=C2=A0we&#39;ve found ways to shorten the downtime for the mail l=
ists and are working on some of those implementation steps now in the backg=
round while the legacy systems continue to serve.=C2=A0 Of course, closing =
in on the holidays os an issue as well factoring in the delay.<div><br></di=
v><div>Two other notes:</div><div><br></div><div>I&#39;ll push the announce=
ment to all other lists (non-member lists) this morning.</div><div><br></di=
v><div>The migration plan changes will better ensure messages sent during t=
he downtime=C2=A0will not be lost and the downtime will be less than we ori=
ginally expected.</div><div><br></div><div>Hope that helps,</div><div><br><=
/div><div>Scott...</div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Dec 14, 2023 at 6:18=E2=80=AFAM Cornelia Hu=
ck &lt;<a href=3D"mailto:cohuck@redhat.com">cohuck@redhat.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Dec 05=
 2023, Scott McGrath &lt;<a href=3D"mailto:scott.mcgrath@oasis-open.org" ta=
rget=3D"_blank">scott.mcgrath@oasis-open.org</a>&gt; wrote:<br>
<br>
[dropped non-virtio lists, added the other virtio lists]<br>
<br>
&gt; The Transition Schedule<br>
&gt;<br>
&gt; Starting 14 December, there may be as much as several days of system<b=
r>
&gt; downtime. During the downtime you will not receive email messages sent=
 to<br>
&gt; this list or have access to the archive.<br>
&gt;<br>
&gt; We will announce the timing specific as we get closer to the transitio=
n.<br>
<br>
I&#39;ve received off-list notification that this change is now postponed t=
o<br>
January -- can you please confirm? It is important for us to plan how we<br=
>
are going to proceed with the 1.3 version of the virtio spec.=C2=A0 (And it=
<br>
is of course also important for people reading those lists, who may not<br>
have an account in the system.)<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><table cellspacing=3D"0" cellpadding=3D"0" style=3D"font-fam=
ily:Arial;vertical-align:-webkit-baseline-middle"><tbody><tr><td width=3D"7=
0" style=3D"vertical-align:middle"><span style=3D"margin-right:5px;display:=
block"><img width=3D"70" height=3D"70" style=3D"max-width: 70px;" src=3D"ht=
tps://ci3.googleusercontent.com/mail-sig/AIorK4wWWvttK4QvAyLjmQRfbisd2jdvX8=
4ncnFeBuJn9NtWvi8WHJIwVlm1HGm8Re2Ji0U6N10brtc"></span></td><td style=3D"ver=
tical-align:middle"><h3 style=3D"margin:0px;font-size:16px;color:rgb(0,0,0)=
">Scott=C2=A0McGrath</h3><p style=3D"margin:0px;color:rgb(0,0,0);font-size:=
12px;line-height:20px">Chief Operating Officer</p><p style=3D"margin:0px;co=
lor:rgb(0,0,0);font-size:12px;line-height:20px">OASIS Open</p></td><td widt=
h=3D"30">=C2=A0</td><td width=3D"1" style=3D"width:1px;border-bottom:none;b=
order-left:1px solid rgb(34,72,229)">=C2=A0</td><td width=3D"30">=C2=A0</td=
><td style=3D"vertical-align:middle"><table cellspacing=3D"0" cellpadding=
=3D"0" style=3D"vertical-align:-webkit-baseline-middle;font-family:Arial"><=
tbody><tr style=3D"vertical-align:middle"><td width=3D"30" style=3D"vertica=
l-align:middle"><table cellspacing=3D"0" cellpadding=3D"0" style=3D"vertica=
l-align:-webkit-baseline-middle;font-family:Arial"><tbody><tr><td style=3D"=
vertical-align:bottom"><span style=3D"display:block;background-color:rgb(34=
,72,229)"><img src=3D"https://cdn2.hubspot.net/hubfs/53/tools/email-signatu=
re-generator/icons/phone-icon-2x.png" width=3D"13" style=3D"display: block;=
"></span></td></tr></tbody></table></td><td style=3D"padding:2px;color:rgb(=
0,0,0)"><br>+1 781-929-7308 Mobile</td></tr><tr style=3D"vertical-align:mid=
dle"><td width=3D"30" style=3D"vertical-align:middle"><table cellspacing=3D=
"0" cellpadding=3D"0" style=3D"vertical-align:-webkit-baseline-middle;font-=
family:Arial"><tbody><tr><td style=3D"vertical-align:bottom"><span style=3D=
"display:block;background-color:rgb(34,72,229)"><img src=3D"https://cdn2.hu=
bspot.net/hubfs/53/tools/email-signature-generator/icons/email-icon-2x.png"=
 width=3D"13" style=3D"display: block;"></span></td></tr></tbody></table></=
td><td style=3D"padding:2px"><a href=3D"mailto:scott.mcgrath@oasis-open.org=
" style=3D"color:rgb(0,0,0);font-size:12px" target=3D"_blank">scott.mcgrath=
@oasis-open.org</a></td></tr><tr style=3D"vertical-align:middle"><td width=
=3D"30" style=3D"vertical-align:middle"><table cellspacing=3D"0" cellpaddin=
g=3D"0" style=3D"vertical-align:-webkit-baseline-middle;font-family:Arial">=
<tbody><tr><td style=3D"vertical-align:bottom"><span style=3D"display:block=
;background-color:rgb(34,72,229)"><img src=3D"https://cdn2.hubspot.net/hubf=
s/53/tools/email-signature-generator/icons/link-icon-2x.png" width=3D"13" s=
tyle=3D"display: block;"></span></td></tr></tbody></table></td><td style=3D=
"padding:2px"><a href=3D"https://www.oasis-open.org/" style=3D"color:rgb(0,=
0,0);font-size:12px" target=3D"_blank">www.oasis-open.org</a></td></tr></tb=
ody></table></td></tr></tbody></table></div></div>

--000000000000f85ee5060c78f56e--
