Return-Path: <virtio-dev-return-14288-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C28C47DDB
	for <virtio-dev@archiver.kernel.org>; Mon, 29 Jan 2024 17:08:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 57DF960268
	for <virtio-dev@archiver.kernel.org>; Mon, 29 Jan 2024 17:08:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D96E98687E
	for <virtio-dev@archiver.kernel.org>; Mon, 29 Jan 2024 17:08:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 27D7F983F75; Mon, 29 Jan 2024 17:08:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 18D57986872
	for <virtio-dev@lists.oasis-open.org>; Mon, 29 Jan 2024 17:08:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706548089; x=1707152889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lypBhT3rz7nU04OtSUvSngwmDqqZcJ3IQyRBbVq+h9E=;
        b=sdKolBNGn8ldz0PIDjz+bSFZAC+FZckfSnJ/M3i4Ot3XjAoQxAFw978oKWwR22e7k+
         sVhkz/R9bO+XpBZKnLHq9ODdhiMbW4hIQwyaz/vhpjwX7NOVeeHZYrMixBFvRcLdYGf/
         oqckJknCvgPgy+7jKdKSUfWybmf/ouyB2ohfSI7433zwxA0usaNpn2Mf//Q3tDiO+Sh2
         hLUkogYoF35yT26q3jEDphyQZAQrAm9K0i1hxQegJSXdtomD7pNFGQADTKfyvKTGQaCH
         8AGjCGwUpU31fn8S31m3Xew0NBQ9G/DZbDrzG5TawBsWW6GHtN7t/vgOexHc3axuq5To
         /LZg==
X-Gm-Message-State: AOJu0YwFQt53nqcPZHRukCU783oyo8aEE+nEgNXOi0zBAxziY/iup1iT
	937BOOjq0gSGSE/8rDmfgSc6gI0ga90POuBwvVgnrC2O5yCSLetL8HcDjtp34QxU+g3Vtfq1A/g
	AsQjpuMc4YWWgtddZrZLhnE0wMSdHdXJ6nIuT
X-Google-Smtp-Source: AGHT+IE5HOmMwAqp1Ebx64dFetiXYNrW8N7X5hAacMyLu0eDKybIabOGjtVPI4uG6VF5cMjnGkWMesHTGju8RCiQfFo=
X-Received: by 2002:a17:906:560a:b0:a35:74c1:272d with SMTP id
 f10-20020a170906560a00b00a3574c1272dmr3335106ejq.73.1706548088969; Mon, 29
 Jan 2024 09:08:08 -0800 (PST)
MIME-Version: 1.0
References: <CAB6OiKgcWwH_qprNv6Z=F4=Hc2PckoCqQEJCGgkgNVL9Xx4k5A@mail.gmail.com>
 <87cytkkx48.fsf@redhat.com>
In-Reply-To: <87cytkkx48.fsf@redhat.com>
From: Shujun Xue <shujunxue@google.com>
Date: Mon, 29 Jan 2024 09:07:56 -0800
Message-ID: <CAB6OiKhLR809jmQXdP8oaXG=pf4N-saMeo5s_pig5aJ_hC+QDw@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Slava Malyugin <slavamn@google.com>, 
	virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Content-Type: multipart/alternative; boundary="000000000000a336de061018b016"
Subject: Re: [virtio-dev] [PATCH] Define the DEVICE ID of Virtio Cpu balloon
 device as 47.

--000000000000a336de061018b016
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Is there ETA for the migration?

Bests,
Shujun


Cornelia Huck <cohuck@redhat.com>=E4=BA=8E2024=E5=B9=B41=E6=9C=8829=E6=97=
=A5 =E5=91=A8=E4=B8=80=E4=B8=8A=E5=8D=886:55=E5=86=99=E9=81=93=EF=BC=9A

> On Tue, Jan 23 2024, Shujun Xue <shujunxue@google.com> wrote:
>
> > The Virtio CPU balloon device is a primitive device for managing guest
> > CPU capacity: the device asks for certain CPU cores to be online,
> > offline or throttled, and the driver performs the requested operation.
> > This allows the guest to adapt to changes in allowance of underlying
> > CPU capacity.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/187
>
> >
> > Signed-off-by: Shujun Xue <shujunxue@google.com>
> > ---
> >  content.tex | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/content.tex b/content.tex
> > index 0a62dce..87f0238 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -739,6 +739,8 @@ \chapter{Device Types}\label{sec:Device Types}
> >  \hline
> >  45         &   SPI master \\
> >  \hline
> > +47         &   CPU balloon device \\
> > +\hline
> >  \end{tabular}
> >
> >  Some of the devices above are unspecified by this document,
>
> I'm holding off voting for now until the status of the OASIS
> infrastructure migration is clear (sigh).
>
>

--000000000000a336de061018b016
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Is there ETA for the migration?=C2=A0<br clear=3D"all"><b=
r clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartm=
ail=3D"gmail_signature"><div dir=3D"ltr">Bests,<div>Shujun</div></div></div=
></div></div><div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">Cornelia Huck &lt;<a href=3D"mailto:cohuck@redha=
t.com">cohuck@redhat.com</a>&gt;=E4=BA=8E2024=E5=B9=B41=E6=9C=8829=E6=97=A5=
 =E5=91=A8=E4=B8=80=E4=B8=8A=E5=8D=886:55=E5=86=99=E9=81=93=EF=BC=9A<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">On Tue, Jan 23 2024, Shujun Xue &lt;<a hr=
ef=3D"mailto:shujunxue@google.com" target=3D"_blank">shujunxue@google.com</=
a>&gt; wrote:<br>
<br>
&gt; The Virtio CPU balloon device is a primitive device for managing guest=
<br>
&gt; CPU capacity: the device asks for certain CPU cores to be online,<br>
&gt; offline or throttled, and the driver performs the requested operation.=
<br>
&gt; This allows the guest to adapt to changes in allowance of underlying<b=
r>
&gt; CPU capacity.<br>
<br>
Fixes: <a href=3D"https://github.com/oasis-tcs/virtio-spec/issues/187" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/oasis-tcs/virtio-spec/=
issues/187</a><br>
<br>
&gt;<br>
&gt; Signed-off-by: Shujun Xue &lt;<a href=3D"mailto:shujunxue@google.com" =
target=3D"_blank">shujunxue@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 content.tex | 2 ++<br>
&gt;=C2=A0 1 file changed, 2 insertions(+)<br>
&gt;<br>
&gt; diff --git a/content.tex b/content.tex<br>
&gt; index 0a62dce..87f0238 100644<br>
&gt; --- a/content.tex<br>
&gt; +++ b/content.tex<br>
&gt; @@ -739,6 +739,8 @@ \chapter{Device Types}\label{sec:Device Types}<br>
&gt;=C2=A0 \hline<br>
&gt;=C2=A0 45=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;=C2=A0 =C2=A0SPI master=
 \\<br>
&gt;=C2=A0 \hline<br>
&gt; +47=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;=C2=A0 =C2=A0CPU balloon dev=
ice \\<br>
&gt; +\hline<br>
&gt;=C2=A0 \end{tabular}<br>
&gt;<br>
&gt;=C2=A0 Some of the devices above are unspecified by this document,<br>
<br>
I&#39;m holding off voting for now until the status of the OASIS<br>
infrastructure migration is clear (sigh).<br>
<br>
</blockquote></div></div>

--000000000000a336de061018b016--
