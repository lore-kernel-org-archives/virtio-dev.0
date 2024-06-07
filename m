Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49F7200A0
	for <virtio-dev@lists.linux.dev>; Fri,  7 Jun 2024 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753733; cv=none; b=Xzd+ieOpwSIouZuyeA89vbzY7y4W8veXeWpFe+kGqOwEhMuARf8TAuUn+F9CX3NKGTx0NbDreFKV6XxMx0V72d8a5N9Cuym4EccrV0+x9NbyXfZwrgBuuXbzsb/tNW1HzRmSrjZDl0oroRRdgldzyqRZnR2W1OepMEsY97TatnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753733; c=relaxed/simple;
	bh=pi4ecyZMt2I3Jn4mSQ71Lj5gQn3Pi9KIQIxgMiwWJDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o13WtIx2Eg8K3LVPr58Zfow8YVktcW2xabSGaOL0kk5g5BhwEFpx1FvJZYvvfIJANpthi+/x5IByJC3ovc6mjGHuIBS41S0xL2NivqiugfqFtyc4y7mui/hhFmtJgW+TJLfk55nf7x8B6lzJg1Xg1S88mdnpowb4H/EEAYZTkqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JgFsjwn+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgFsjwn+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717753730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ehojtUTYtU0iW8mAi98fRbGWEqqwVmGO2O7UYcUhUGI=;
	b=JgFsjwn+ZkY89pS6GCHqQjTdVHSl/ZTNnH7IuEFWRMSOQaqMkQE+HAp4Yevv6BpQ9mRs+O
	N0aM1CLVPWu2RZLwICciHGk/50Y5Grsod50r9UqV5QOyP0fLBhNnXZUtrrK2UJD85tTEnN
	dlQaZNxEa5JcWycvhY5TG6il6P79iaU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-Jg9J8K2zODe5Z6T-VkB1sQ-1; Fri, 07 Jun 2024 05:48:48 -0400
X-MC-Unique: Jg9J8K2zODe5Z6T-VkB1sQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-66348aafadcso1573346a12.1
        for <virtio-dev@lists.linux.dev>; Fri, 07 Jun 2024 02:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717753728; x=1718358528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehojtUTYtU0iW8mAi98fRbGWEqqwVmGO2O7UYcUhUGI=;
        b=d8gNT1k9Q9YgbeKr7JoGicz5AcBQMHqpNXYV4yonC2nHgx5AFothkvkdPV+FPZ8kbB
         T+u74slBfmOHpcGXjNKZ8JSx366RrLzBzqzY1zbkzdDwuQ5KYy/Zxl/x8BnF5tyJZaBW
         FAgktWnk2FvjqXil4IqMj3vGCkOyR+NOvf7APG0QjeefMw4spWhny/NChxfJw3O2kFCy
         aetNS7s48lAz9hClJLu52F/Q5xHMS43y94tQ5YEfXGCo6VHeNR01PyUodCvasMf8LF+p
         /G0QFrgnM0J+D7+zYYCYTG5LK/6jILsnzvJK5xUuHHgHkk/qnw8ni9cL2CWTJjQk9QLv
         7Frw==
X-Gm-Message-State: AOJu0YyKN6ONfFuTCGGVzut0+3HA11oD/mTFMtdlrXNtzY1XtvnDOnLc
	9bGpodcVoRzIsTirytkbh5MZncMXnnnzVfzzHKRzJW8JOgJPinNYvGFXv5k9OgHFbcvBjXTwYAi
	efm8hOPcOjG3wpjXiLTBCCnfP1PiiQEzcU8qMnn2Ggfx0D5RGHN9pFoXWyFe/Q3t50QhPrAj3AE
	y7Midvz54y2uZsPui5F7PXWGNmDmgzsrpTTA==
X-Received: by 2002:a17:90b:3114:b0:2c1:b16e:7567 with SMTP id 98e67ed59e1d1-2c2bc9bdac0mr2088578a91.9.1717753727691;
        Fri, 07 Jun 2024 02:48:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB15c36umzxqJv3u6Yq9gwWqk3t82GOgaHinqstsSOFTaZkGD+8N1jLVzeRKFJED5ZrQIebR9nAJsSpJZBdl4=
X-Received: by 2002:a17:90b:3114:b0:2c1:b16e:7567 with SMTP id
 98e67ed59e1d1-2c2bc9bdac0mr2088560a91.9.1717753727369; Fri, 07 Jun 2024
 02:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240607080045.1337046-1-aesteve@redhat.com> <20240607053839-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240607053839-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 7 Jun 2024 11:48:36 +0200
Message-ID: <CADSE00KP+dsN5W0DHzML8f4wjiH-NQEifQ5zxLusw65mEUb+wA@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000bb573c061a49b446"

--000000000000bb573c061a49b446
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 11:41=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> On Fri, Jun 07, 2024 at 10:00:44AM +0200, Albert Esteve wrote:
> > Hi,
> >
> > This a formal attempt of including virtio-media
> > device specification.
>
> This was sent to a wrong mailing list.
> Please repost to the correct list.
>
> Albert, when you subscribed to virtio-dev you should
> have received a message that read, in part:
>
> When to use this list:
> - questions and change proposals for Virtio drivers and devices
>   implementing the specification.
>
> When not to use this list:
> - questions and change proposals for the Virtio specification,
>   including the specification of basic functionality, transports and
>   devices (please use the virtio-comment mailing list
>   [mailto:virtio-comment@lists.linux.dev] for this).
>
> To do:
> - send email preferably in text format (best for archiving)
>
> Not to do:
> - copy both virtio-dev and virtio-comment mailing lists (instead, pick
>   one)
> - send full copies of the virtio spec (in any format)
>
>
>
> So what made you send a specification change proposal to
> virtio-dev, and also copy the defunct, non-functional
> list at virtio-dev@lists.oasis-open.org ?
>
>
> Was the message unclear? If yes I'd like to improve it.
>

My bad.
The instructions were clear, and I set up the mail to be sent to the
correct virtio-dev mailing list address. But I had the configuration
of the project set to automatically add both of the old addresses to the
patch. I only noticed after sending, so the damage was already
made.

I will fix it for the next drop.


>
>
> --
> MST
>
>

--000000000000bb573c061a49b446
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 7, 2024 at 11:41=
=E2=80=AFAM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@re=
dhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">On Fri, Jun 07, 2024 at 10:00:44AM +0200, Albert Esteve wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; This a formal attempt of including virtio-media<br>
&gt; device specification.<br>
<br>
This was sent to a wrong mailing list.<br>
Please repost to the correct list.<br>
<br>
Albert, when you subscribed to virtio-dev you should<br>
have received a message that read, in part:<br>
<br>
When to use this list:<br>
- questions and change proposals for Virtio drivers and devices<br>
=C2=A0 implementing the specification.<br>
<br>
When not to use this list:<br>
- questions and change proposals for the Virtio specification,<br>
=C2=A0 including the specification of basic functionality, transports and<b=
r>
=C2=A0 devices (please use the virtio-comment mailing list<br>
=C2=A0 [mailto:<a href=3D"mailto:virtio-comment@lists.linux.dev" target=3D"=
_blank">virtio-comment@lists.linux.dev</a>] for this).<br>
<br>
To do:<br>
- send email preferably in text format (best for archiving)<br>
<br>
Not to do:<br>
- copy both virtio-dev and virtio-comment mailing lists (instead, pick<br>
=C2=A0 one)<br>
- send full copies of the virtio spec (in any format)<br>
<br>
<br>
<br>
So what made you send a specification change proposal to<br>
virtio-dev, and also copy the defunct, non-functional<br>
list at <a href=3D"mailto:virtio-dev@lists.oasis-open.org" target=3D"_blank=
">virtio-dev@lists.oasis-open.org</a> ?<br>
<br>
<br>
Was the message unclear? If yes I&#39;d like to improve it.<br></blockquote=
><div><br></div><div>My bad.</div><div>The instructions were clear, and I s=
et up the mail to be sent to the</div><div>correct virtio-dev mailing list =
address. But I had the configuration</div><div>of the project set to automa=
tically add both of the old addresses to the</div><div>patch. I only notice=
d after sending, so the damage was already</div><div>made.=C2=A0</div><div>=
<br></div><div>I will fix it for the next drop.</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
-- <br>
MST<br>
<br>
</blockquote></div></div>

--000000000000bb573c061a49b446--

