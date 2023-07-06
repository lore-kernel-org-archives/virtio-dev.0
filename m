Return-Path: <virtio-dev-return-13253-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF43EB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 08:27:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BA30AEEA11
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 08:27:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9014C98672C
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 08:27:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 71D3A986724; Thu,  6 Jul 2023 08:27:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5CE74986726
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jul 2023 08:27:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: tczrbVCAMkGGBp0ly2Sv2A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688632051; x=1691224051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jc7IE0myDz5TPenigLGqwL759yJ0I5n4x+zWlEqGcvM=;
        b=cOu1AF3Nbp5uTBSRyHGzZwEtZnUHQrHOSyJnb+LoTNWL/fT+1e+wwYHAKLp6SpMFQn
         IQr67k9o/rC6kLCiXvcwyWV8WpqeMnl+44hoQZiIEBi6siGCbbNEV8O7An1vTTQomi2t
         i6Etz4Gq9c/CWAXWCiALpOq34YjMmciD1P964XRf0Ydn3bUeKAlCbr4ZrvlVe/NsjWCM
         iXCKTGET0hO++XT2T1VprGnKOnTLxVRTGc1kPVTeyA2QggwVpuKWCs4TgMsWejWtUzuk
         cwj05gn9YEthwQPMRN61l0n3j2jLA0nu/jyPQfscNWqq5kEaGbZQnS3UlyBlc7trAB/I
         fFGg==
X-Gm-Message-State: ABy/qLbowRnZ/rKaw7sQQ/UMa5Wg/a9vLZ8sUrWeZGm3UAqQSGYhsYTw
	2m1ymB5VMPzVgR4fjeGqTEsVhNB46gjzKgq/aI/4w9PZwUtRSMVM+Q2pcuaM6oqww45kVAHMVZf
	os8sBIXMNp+ri3vkfa9gxshmQXX1zTg89wSFDk91av7X3
X-Received: by 2002:a05:6a00:1952:b0:679:9639:1f6a with SMTP id s18-20020a056a00195200b0067996391f6amr1042525pfk.14.1688632050975;
        Thu, 06 Jul 2023 01:27:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHdyhfr8Anbq5R89YE33dBE6enM8WSJTYKKGfyrJdARHelk8STkHQit1SMKqxFNgD9og3NA8XgJT1Z0SkrhJsM=
X-Received: by 2002:a05:6a00:1952:b0:679:9639:1f6a with SMTP id
 s18-20020a056a00195200b0067996391f6amr1042499pfk.14.1688632050637; Thu, 06
 Jul 2023 01:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAPBb6MXBaKKFGg8Yt2Me8kjUwCm4utWcsVOiCS1Qunjhza4Ycg@mail.gmail.com>
 <20230531020611-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230531020611-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 6 Jul 2023 10:27:19 +0200
Message-ID: <CADSE00KRu3b94kZMVV4XMqA=rTFKGSZ1fK=orN71P9PTSFCZvg@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexandre Courbot <acourbot@google.com>, virtio-comment@lists.oasis-open.org, 
	virtio-dev@lists.oasis-open.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Andrew Gazizov <andrew.gazizov@opensynergy.com>, 
	Andrii Cherniavskyi <andrii.cherniavskyi@opensynergy.com>, Cornelia Huck <cohuck@redhat.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Enric Balletbo i Serra <eballetb@redhat.com>, 
	Enrico Granata <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, 
	Keiichi Watanabe <keiichiw@chromium.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Alexander Gordeev <alexander.gordeev@opensynergy.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Tomasz Figa <tfiga@chromium.org>, =?UTF-8?Q?Matti_M=C3=B6ll?= <Matti.Moell@opensynergy.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000088f01e05ffcd4927"
Subject: [virtio-dev] Re: virtio-v4l2 specification draft

--00000000000088f01e05ffcd4927
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Sorry for the late reply. I think this is a nice solution, specially for
the host-guest
memory management part. I was intrigued with how would you solve this, as
the v4l2 struct memory fields can't be directly used.

In that sense, sending a field that is going to be ignored by both driver
and device,
feels like kindof a waste. But I guess there is not a good solution to that=
.
Have you considered avoiding using struct v4l2_buffer for QBUF and DQBUF
ioctls,
and having virtio-v4l2 specific struct for them? The device would have the
burden to
copy the all the fields and leave the `m` field out, so it may have its own
downsides.

In any case, the specs are short and clear to follow. Great work!

I just have a couple comments/questions:

- The text in `0.1.6.3` and `0.1.6.3.1` is saying the same thing twice (?).
Maybe would be
  clearer to unify?

- If I understood correctly, the `stream_id` is assigned by the device
after receiving
  a VIRTIO_V4L2_CMD_OPEN? Is it supposed to be a correlative natural number
(1, 2, etc.)?
  I assume that after (successfully) closing the stream, its stream_id can
be reused?

- For section `0.1.6.7` I think it would be good to refer (again) to the
section `0.1.6.5` so that
  we can quickly navigate to the section that explains the memory fields in
the presented events.

Best regards,
Albert

On Wed, May 31, 2023 at 8:08=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> On Wed, May 31, 2023 at 03:02:04PM +0900, Alexandre Courbot wrote:
> > Hello everyone,
> >
> > With the virtio-video call taking place soon, I thought it would help
> > everyone understand both proposals if I sent a more formal
> > specification of what virtio-v4l2 looks like. Please find it attached
> > to this email.
> >
> > I apologize for not finishing and sending this earlier, but hopefully
> > at 7 and a half pages it should be rather quick to skim through. :)
> >
> > Despite its short size, this spec is capable of supporting camera and
> > image processor devices (on top of decoder/encoders), and also allows
> > for another kind of memory backing for buffers (host-managed) that is
> > not supported by virtio-video.
> >
> > For convenience I have made use of clickable links to the relevant
> > parts of the V4L2 documentation, since it is supposed to be used
> > alongside this spec.
> >
> > Looking forward to a fruitful discussion tomorrow!
> >
> > Cheers,
> > Alex.
>
>
> Can you please post patch with tex source inline as opposed as
> pdf as an attachment? Thanks!
>
> --
> MST
>
>

--00000000000088f01e05ffcd4927
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Alex,<div><br></div><div>Sorry=C2=A0for the late reply.=
 I think this is a nice solution, specially for the host-guest</div><div>me=
mory management part. I was intrigued with how would you solve this, as</di=
v><div>the v4l2 struct memory fields can&#39;t be directly used.</div><div>=
<br></div><div>In that sense, sending a field that is going to be ignored b=
y both driver and device,</div><div>feels like kindof a waste. But I guess =
there is not a good solution to that.</div><div>Have you considered avoidin=
g using struct v4l2_buffer for QBUF and DQBUF ioctls,</div><div>and having =
virtio-v4l2 specific struct for them? The device would have the burden to</=
div><div>copy the all the fields and leave the `m` field out, so it may hav=
e its own downsides.</div><div></div><div><br></div><div>In any case, the s=
pecs are short and clear to=C2=A0follow. Great work!</div><div><br></div><d=
iv>I just have a couple comments/questions:</div><div><br></div><div>- The =
text in `0.1.6.3` and `0.1.6.3.1` is saying the same thing twice (?). Maybe=
 would be</div><div>=C2=A0 clearer to unify?</div><div><br></div><div>- If =
I understood correctly, the `stream_id` is assigned by the device after rec=
eiving</div><div>=C2=A0 a=C2=A0VIRTIO_V4L2_CMD_OPEN? Is it=C2=A0supposed=C2=
=A0to be a correlative natural number (1, 2, etc.)?</div><div>=C2=A0 I assu=
me that after (successfully) closing the stream, its stream_id can be reuse=
d?</div><div><br></div><div>- For section `0.1.6.7` I think it would be goo=
d to refer (again) to the section `0.1.6.5` so that</div><div>=C2=A0 we can=
 quickly navigate to the section that explains the memory fields in the pre=
sented events.</div><div><br></div><div>Best regards,</div><div>Albert</div=
></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>On Wed, May 31, 2023 at 8:08=E2=80=AFAM Michael S. Tsirkin &lt;<a href=3D"=
mailto:mst@redhat.com">mst@redhat.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On Wed, May 31, 2023 at 03:02:04PM +09=
00, Alexandre Courbot wrote:<br>
&gt; Hello everyone,<br>
&gt; <br>
&gt; With the virtio-video call taking place soon, I thought it would help<=
br>
&gt; everyone understand both proposals if I sent a more formal<br>
&gt; specification of what virtio-v4l2 looks like. Please find it attached<=
br>
&gt; to this email.<br>
&gt; <br>
&gt; I apologize for not finishing and sending this earlier, but hopefully<=
br>
&gt; at 7 and a half pages it should be rather quick to skim through. :)<br=
>
&gt; <br>
&gt; Despite its short size, this spec is capable of supporting camera and<=
br>
&gt; image processor devices (on top of decoder/encoders), and also allows<=
br>
&gt; for another kind of memory backing for buffers (host-managed) that is<=
br>
&gt; not supported by virtio-video.<br>
&gt; <br>
&gt; For convenience I have made use of clickable links to the relevant<br>
&gt; parts of the V4L2 documentation, since it is supposed to be used<br>
&gt; alongside this spec.<br>
&gt; <br>
&gt; Looking forward to a fruitful discussion tomorrow!<br>
&gt; <br>
&gt; Cheers,<br>
&gt; Alex.<br>
<br>
<br>
Can you please post patch with tex source inline as opposed as<br>
pdf as an attachment? Thanks!<br>
<br>
-- <br>
MST<br>
<br>
</blockquote></div>

--00000000000088f01e05ffcd4927--

