Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D2516F291
	for <virtio-dev@lists.linux.dev>; Fri,  7 Jun 2024 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757697; cv=none; b=MZt4lOO+6copOhLw22iXSDS3rqiag8HersJAbjKI8K9L6Yw6t8Llds/AsK59hSBxUIxenZquXSfWwBYh6xNOV/7/kTsK1m5Mmv2nwk6F17DQqdIPRJodTAKdc+f/ZxVe7RPqm25neKh176NnJLP5mtbqNRJ7kvYyA3F3Ge+bwuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757697; c=relaxed/simple;
	bh=T0evE2EGcBby3U0I7+8O3GcKdeTufmz9+14yJUYdM7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZPo6HdAEf+Ih9dKAY3jtEay9hcH4cfoMayBsalzE3c9cfFKZBAiOJH0mQ3OxMhaINp/GiadKjvWFjVOffx3TRT59MwvYRHXoc1x4CsEjip77MbHSU9tQfrefNf8WnVkke/BW8uOoMNjFywSnp7ngQk03FKjYm1LfsFKjWbt1B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBCCdc50; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBCCdc50"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717757694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3UIh/iy/gVvlV7bYG16aek3kGIMAyIVAC2rK8G8P4qY=;
	b=iBCCdc50Z1xcKQglC1oOrHtmhijXQLHAheOgQbj1r8KqS1to24uYav4IFL1cq7MNzDkmtZ
	wbJSy4YzSUMCbP6w/GB9IgKOjQJH9e2Ggni6V6hdjV0lp6dYFj0fNRd+x/sfKc2XwAlM7I
	rJ9yeG3CVDWDfnaBay9xo7teCr0dcYE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-4Ka4FcT_MyaCm3pLkRPJ-g-1; Fri, 07 Jun 2024 06:54:52 -0400
X-MC-Unique: 4Ka4FcT_MyaCm3pLkRPJ-g-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2bf8512aa8dso1814541a91.1
        for <virtio-dev@lists.linux.dev>; Fri, 07 Jun 2024 03:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717757692; x=1718362492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UIh/iy/gVvlV7bYG16aek3kGIMAyIVAC2rK8G8P4qY=;
        b=pSBYLzGIGUidsHQE3DNxjNi8jb3L25V80qgwsjbeI5dwRGargcRWfqK7RXY2ZEGPEm
         v3Cq4nla0RMsM01cWhOnT1nh2ayc1flRMn35ALK2QhnbsdsPIsBLlMdHB8H+l1U7LPmm
         o7lA97JXJcb5i+DW7KRQx7vmaRKb+NvgR3IlRsRG3M0Mjg5ouAHpFSKroTkcrmLGWO+S
         nHY8Q/HQhDM3tZgb7fFrOlpBA4avgik3eX1IZ9mzPNT1NA/oaJdSIOM+8pcbbSBLKx6e
         tRIzjJeJrCzPrGoYz67Kncf8PUciORWpKalQcXOeGjbbOZyYEk2RnivPHOV3sDPZyDav
         x+zg==
X-Gm-Message-State: AOJu0Yyl5YpvG9hqY1CY/KuhEs2Jt9WNxpGQICwXWaN88sr7W/jEAxJ0
	t3cSAcWzkAN9XlTuKfdok2kjZU8o3EAzlkT9VHmW4QALaT+HFTlyl2Zk+rrIA1an57ZnPk0E/qB
	phT2kRWMede+6VTsiIlwtTGAi0E7YHhNmwPKqiKcWU5i2NLK8Esezt2IVDUbPI8DnbVKQT5koEa
	mXSJKboa3c1uuPicmt7NST6S2yMefSqpio/Q==
X-Received: by 2002:a17:90a:aa86:b0:2b6:c650:fb54 with SMTP id 98e67ed59e1d1-2c2bcc619f3mr1818480a91.49.1717757691765;
        Fri, 07 Jun 2024 03:54:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQlBljv4euUtujYOMfKex0SYPYuQ/rStEMjk9KkBfS9BDu0shkN4v1r3pE6IoFzQvu9UURfkDD6Y2Z79iNiT0=
X-Received: by 2002:a17:90a:aa86:b0:2b6:c650:fb54 with SMTP id
 98e67ed59e1d1-2c2bcc619f3mr1818463a91.49.1717757691427; Fri, 07 Jun 2024
 03:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240607080045.1337046-1-aesteve@redhat.com> <20240607053839-mutt-send-email-mst@kernel.org>
 <CADSE00KP+dsN5W0DHzML8f4wjiH-NQEifQ5zxLusw65mEUb+wA@mail.gmail.com> <20240607062139-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240607062139-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 7 Jun 2024 12:54:40 +0200
Message-ID: <CADSE00LhUNbqr7Sc6XeTFCe6EBjOoTpBokhx4VvwORe0xJe6sg@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] virtio-media: Add device specification
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.linux.dev, Matti.Moell@opensynergy.com, cohuck@redhat.com, 
	acourbot@chromium.org, daniel.almeida@collabora.com, 
	Alexander.Gordeev@opensynergy.com, changyeon@google.com, 
	alex.bennee@linaro.org, gurchetansingh@google.com, ribalda@google.com, 
	nicolas.dufresne@collabora.com, eballetb@redhat.com, 
	linux-media@vger.kernel.org, virtio-comment@lists.oasis-open.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000021803061a4aa1a5"

--000000000000021803061a4aa1a5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 12:22=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> On Fri, Jun 07, 2024 at 11:48:36AM +0200, Albert Esteve wrote:
> >
> >
> > On Fri, Jun 7, 2024 at 11:41=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com>
> wrote:
> >
> >     On Fri, Jun 07, 2024 at 10:00:44AM +0200, Albert Esteve wrote:
> >     > Hi,
> >     >
> >     > This a formal attempt of including virtio-media
> >     > device specification.
> >
> >     This was sent to a wrong mailing list.
> >     Please repost to the correct list.
> >
> >     Albert, when you subscribed to virtio-dev you should
> >     have received a message that read, in part:
> >
> >     When to use this list:
> >     - questions and change proposals for Virtio drivers and devices
> >       implementing the specification.
> >
> >     When not to use this list:
> >     - questions and change proposals for the Virtio specification,
> >       including the specification of basic functionality, transports an=
d
> >       devices (please use the virtio-comment mailing list
> >       [mailto:virtio-comment@lists.linux.dev] for this).
> >
> >     To do:
> >     - send email preferably in text format (best for archiving)
> >
> >     Not to do:
> >     - copy both virtio-dev and virtio-comment mailing lists (instead,
> pick
> >       one)
> >     - send full copies of the virtio spec (in any format)
> >
> >
> >
> >     So what made you send a specification change proposal to
> >     virtio-dev, and also copy the defunct, non-functional
> >     list at virtio-dev@lists.oasis-open.org ?
> >
> >
> >     Was the message unclear? If yes I'd like to improve it.
> >
> >
> > My bad.
> > The instructions were clear, and I set up the mail to be sent to the
> > correct virtio-dev mailing list address.
>
>
> Hmm no, it's actually virtio-comment@lists.linux.dev for change
> proposals for the Virtio specification which is what you have here.
>
>
Ok, then I'll repost to virtio-comment.


>
> > But I had the configuration
> > of the project set to automatically add both of the old addresses to th=
e
> > patch. I only noticed after sending, so the damage was already
> > made.
> >
> > I will fix it for the next drop.
> >
> >
> >
> >
> >     --
> >     MST
> >
> >
>
>

--000000000000021803061a4aa1a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 7, 2024 at 12:22=
=E2=80=AFPM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@re=
dhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">On Fri, Jun 07, 2024 at 11:48:36AM +0200, Albert Esteve wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Fri, Jun 7, 2024 at 11:41=E2=80=AFAM Michael S. Tsirkin &lt;<a href=
=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Fri, Jun 07, 2024 at 10:00:44AM +0200, Albert Es=
teve wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; This a formal attempt of including virtio-medi=
a<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; device specification.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This was sent to a wrong mailing list.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Please repost to the correct list.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Albert, when you subscribed to virtio-dev you shoul=
d<br>
&gt;=C2=A0 =C2=A0 =C2=A0have received a message that read, in part:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0When to use this list:<br>
&gt;=C2=A0 =C2=A0 =C2=A0- questions and change proposals for Virtio drivers=
 and devices<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 implementing the specification.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0When not to use this list:<br>
&gt;=C2=A0 =C2=A0 =C2=A0- questions and change proposals for the Virtio spe=
cification,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 including the specification of basic functio=
nality, transports and<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 devices (please use the virtio-comment maili=
ng list<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 [mailto:<a href=3D"mailto:virtio-comment@lis=
ts.linux.dev" target=3D"_blank">virtio-comment@lists.linux.dev</a>] for thi=
s).<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0To do:<br>
&gt;=C2=A0 =C2=A0 =C2=A0- send email preferably in text format (best for ar=
chiving)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Not to do:<br>
&gt;=C2=A0 =C2=A0 =C2=A0- copy both virtio-dev and virtio-comment mailing l=
ists (instead, pick<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 one)<br>
&gt;=C2=A0 =C2=A0 =C2=A0- send full copies of the virtio spec (in any forma=
t)<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0So what made you send a specification change propos=
al to<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio-dev, and also copy the defunct, non-function=
al<br>
&gt;=C2=A0 =C2=A0 =C2=A0list at <a href=3D"mailto:virtio-dev@lists.oasis-op=
en.org" target=3D"_blank">virtio-dev@lists.oasis-open.org</a> ?<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Was the message unclear? If yes I&#39;d like to imp=
rove it.<br>
&gt; <br>
&gt; <br>
&gt; My bad.<br>
&gt; The instructions were clear, and I set up the mail to be sent to the<b=
r>
&gt; correct virtio-dev mailing list address.<br>
<br>
<br>
Hmm no, it&#39;s actually <a href=3D"mailto:virtio-comment@lists.linux.dev"=
 target=3D"_blank">virtio-comment@lists.linux.dev</a> for change<br>
proposals for the Virtio specification which is what you have here.<br>
<br></blockquote><div><br></div><div>Ok, then I&#39;ll repost to virtio-com=
ment.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
&gt; But I had the configuration<br>
&gt; of the project set to automatically add both of the old addresses to t=
he<br>
&gt; patch. I only noticed after sending, so the damage was already<br>
&gt; made.=C2=A0<br>
&gt; <br>
&gt; I will fix it for the next drop.<br>
&gt; =C2=A0<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0MST<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div>

--000000000000021803061a4aa1a5--

