Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E330157A40
	for <virtio-dev@lists.linux.dev>; Fri,  7 Jun 2024 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717748527; cv=none; b=hkLJfFyFPsauwj1Z1VKz1wJPiamIxkrdEKKp0JYBrB63Hre8MWmmHzbp9IGlM7V4vLvLuuYOOzwDUd+NlbUkM3PAQBRkVYaovvnDC+UEdWHWUuF7NEwzPUUU+wtEHJF+PLcesgv7QhhLcjcK6kbcAOj9pX1m8USsxISFtzR8/lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717748527; c=relaxed/simple;
	bh=yM0bAJzuOHoftI3UpCwU0XMBcTxMcVQ7u4ND6hhr6Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPYdT7vCzQ4P/IUa2G0ol2SwbPjImUsx8B6yEGF3KN61+33hUa5YnO1wjpBuofLAlPYnAHtKxUT/xUL9W4yMe0AlwEEy3/5nkcH6O3MRs+uru31oQDzrm3x99F672/e3qNz3ksJ1Stk0TGO3L2CdZcn8dVQuu4F4SISAbgwnnIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ij6KEFlk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ij6KEFlk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717748524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2BX+W73/j6oWxyQY8d06kAeV+whdofoQPSB/WKl+pc8=;
	b=ij6KEFlk5tqJdDdxqaoOAk0MmkP6LP4Iluqe99iLVbyDmYY4zR6DH/AJADhJEIq8/A1TY1
	Gu2Y24YRFgqnoeZNDqAwNtgpoMe/J87Hf/Y1iz02fbLe2r1uOfVx+p5cOJL2NgmGIAx4Vd
	qZ8eUAEbEmkSatGKK5IX1tbN/78pwcI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-fzii7Sq_NhqS7C3KGYKttQ-1; Fri, 07 Jun 2024 04:22:03 -0400
X-MC-Unique: fzii7Sq_NhqS7C3KGYKttQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-6507e2f0615so1613617a12.1
        for <virtio-dev@lists.linux.dev>; Fri, 07 Jun 2024 01:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717748520; x=1718353320;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BX+W73/j6oWxyQY8d06kAeV+whdofoQPSB/WKl+pc8=;
        b=OJOXBTJDS7EvaCgQ+tE5Ve4uMmYMnjEF6O2XyZfwf/NvJx8qD9vqFyA+3t3c2NvEBi
         nEmUnhsVUiMm4fWXBZPEaajM8/fI7nj8aE5y8yArsj6Sg5cUzIIIkjY5y3Fs+YoaFuSf
         lkFfd0jmbA1DdriJmAYbd79gdOlv5bFQfzk2RfDmoH8FuTJQfRY5ksQGkB4pZdcUnUrA
         BpVGs/7L/8cnKtmLoeR3WsRW27B/y9IvPhG75F61GvlhDPPRhaR5gM6RHE8IgbX1HM5W
         X8Iz8rXlmrSsmc2OQ3yQ2IrpPPjj13BVEo6VBwvCjbhXP2Frj7Pg3UmZDX8+lg6tEH4X
         skzw==
X-Gm-Message-State: AOJu0YweVggZLYrdaK+RrJCfmLFAS1nzI/ppyAObqUc50dK18048s1mK
	D2LWR0Jb+hs2xCf0CTck3+MKWmOTJgx6VDf0D5Thyx6uhsmCuU5NOPDbdq7kKivmRI9Pi6/+Cdy
	ZKtEKFfMNc3zQqhnpyR8GYveRrO/ObuPVGYmcW2AHwUwGGnDYlWQCgtYTbwxGEO4lXTRZx8Suix
	k0SnvUa45G/mydLXLlQqmtlChPHueoUCWgToS/ydGQfg==
X-Received: by 2002:a17:90a:a110:b0:2c1:ad46:7133 with SMTP id 98e67ed59e1d1-2c2bcaccf44mr1845561a91.8.1717748519781;
        Fri, 07 Jun 2024 01:21:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGosqPwvujOIdIz6JGJ2HWaIOsMg0fA043C6tEozISszDD6JiW00jWYTDRZryTtaO732FNHoc8MVI9IAX/52co=
X-Received: by 2002:a17:90a:a110:b0:2c1:ad46:7133 with SMTP id
 98e67ed59e1d1-2c2bcaccf44mr1845534a91.8.1717748519150; Fri, 07 Jun 2024
 01:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240607080045.1337046-1-aesteve@redhat.com>
In-Reply-To: <20240607080045.1337046-1-aesteve@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 7 Jun 2024 10:21:48 +0200
Message-ID: <CADSE00JYK-e_ORNrNvJcLVYe126XecHnEkPQdYDgUTXXhcK5uA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] virtio-media: Add device specification
To: virtio-dev@lists.linux.dev
Cc: Matti.Moell@opensynergy.com, cohuck@redhat.com, mst@redhat.com, 
	acourbot@chromium.org, daniel.almeida@collabora.com, 
	Alexander.Gordeev@opensynergy.com, changyeon@google.com, 
	alex.bennee@linaro.org, gurchetansingh@google.com, ribalda@google.com, 
	nicolas.dufresne@collabora.com, eballetb@redhat.com, 
	linux-media@vger.kernel.org, virtio-comment@lists.oasis-open.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000004c427e061a487edf"

--0000000000004c427e061a487edf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, forgot the changeset. I will collect this for the next version.

v1->v2:
- Remove naming host/guest in the text
- Explicitly specify endian-ness of the device
- Change address by offset in the MMAP operation
- Specify SHM region for MMAP operation


On Fri, Jun 7, 2024 at 10:00=E2=80=AFAM Albert Esteve <aesteve@redhat.com> =
wrote:

> Hi,
>
> This a formal attempt of including virtio-media
> device specification.
>
> Virtio-media came from a discussion on virtio-dev
> mailing list, which lead to presenting virtio-v4l2[1]
> specification as an alternative to virtio-video.
>
> Later, virtio-v4l2 was renamed to virtio-media[2]
> and published through:
>
> https://github.com/chromeos/virtio-media
>
> The repository above includes a virtio-media driver able
> to pass v4l2-compliance when proxying the vivid/vicodec
> virtual devices or an actual UVC camera using the
> V4L2 vhost device (available in the repository).
> Steps to reproduce are also detailed[3].
>
> There is some overlap with virtio-video in regards
> to which devices it can handle. However,
> as virtio-media will likely be the virtualization
> solution for ChromeOS (already landed into the chromeos
> organization) and possibly other Google projects for
> media devices, it would be desirable to include the
> specification in the next virtio release despite
> the aforementioned overlap.
>
> The device ID in this document differs from
> the ID in the virtio-media project repository.
> And it will probably need some discussion on which
> would be the correct definitive ID.
>
> Full PDF:
> https://drive.google.com/file/d/1pNCFP06VoV8Zuyx0aDVQ7HAT4xp-pZ0a/view?us=
p=3Dsharing
> PDF with the media section only:
> https://drive.google.com/file/d/1sn3NUUeCm46zVyJKHkpytTIgGw1fUt5T/view?us=
p=3Dsharing
>
> [1]
> https://mail.google.com/mail/u/0?ui=3D2&ik=3D73ebd65ebd&attid=3D0.1&permm=
sgid=3Dmsg-f:1767388565327924962&th=3D1887068940754ee2&view=3Datt&disp=3Din=
line&realattid=3Df_libalimc0
> [2]
> https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg12665.htm=
l
> [3] https://github.com/chromeos/virtio-media/blob/main/TRY_IT_OUT.md
>
> Albert Esteve (1):
>   virtio-media: Add virtio media device specification
>
>  conformance.tex                           |  13 +-
>  content.tex                               |   1 +
>  device-types/media/description.tex        | 578 ++++++++++++++++++++++
>  device-types/media/device-conformance.tex |  11 +
>  device-types/media/driver-conformance.tex |   9 +
>  5 files changed, 608 insertions(+), 4 deletions(-)
>  create mode 100644 device-types/media/description.tex
>  create mode 100644 device-types/media/device-conformance.tex
>  create mode 100644 device-types/media/driver-conformance.tex
>
> --
> 2.44.0
>
>

--0000000000004c427e061a487edf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div class=3D"gmail_signature" data-smartmail=3D"gmai=
l_signature">Sorry, forgot the changeset. I will collect this for the next =
version.</div></div><div class=3D"gmail_signature" data-smartmail=3D"gmail_=
signature"><br></div><div class=3D"gmail_signature" data-smartmail=3D"gmail=
_signature">v1-&gt;v2:</div><div class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature">- Remove naming host/guest in the text</div><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature">- Explicitly specif=
y endian-ness of the device</div><div class=3D"gmail_signature" data-smartm=
ail=3D"gmail_signature">- Change address by offset in the MMAP operation</d=
iv><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature">- Spec=
ify SHM region for MMAP operation</div><br></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 7, 2024 at 10:00=E2=
=80=AFAM Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com">aesteve@re=
dhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">Hi,<br>
<br>
This a formal attempt of including virtio-media<br>
device specification.<br>
<br>
Virtio-media came from a discussion on virtio-dev<br>
mailing list, which lead to presenting virtio-v4l2[1]<br>
specification as an alternative to virtio-video.<br>
<br>
Later, virtio-v4l2 was renamed to virtio-media[2]<br>
and published through:<br>
<br>
<a href=3D"https://github.com/chromeos/virtio-media" rel=3D"noreferrer" tar=
get=3D"_blank">https://github.com/chromeos/virtio-media</a><br>
<br>
The repository above includes a virtio-media driver able<br>
to pass v4l2-compliance when proxying the vivid/vicodec<br>
virtual devices or an actual UVC camera using the<br>
V4L2 vhost device (available in the repository).<br>
Steps to reproduce are also detailed[3].<br>
<br>
There is some overlap with virtio-video in regards<br>
to which devices it can handle. However,<br>
as virtio-media will likely be the virtualization<br>
solution for ChromeOS (already landed into the chromeos<br>
organization) and possibly other Google projects for<br>
media devices, it would be desirable to include the<br>
specification in the next virtio release despite<br>
the aforementioned overlap.<br>
<br>
The device ID in this document differs from<br>
the ID in the virtio-media project repository.<br>
And it will probably need some discussion on which<br>
would be the correct definitive ID.<br>
<br>
Full PDF: <a href=3D"https://drive.google.com/file/d/1pNCFP06VoV8Zuyx0aDVQ7=
HAT4xp-pZ0a/view?usp=3Dsharing" rel=3D"noreferrer" target=3D"_blank">https:=
//drive.google.com/file/d/1pNCFP06VoV8Zuyx0aDVQ7HAT4xp-pZ0a/view?usp=3Dshar=
ing</a><br>
PDF with the media section only: <a href=3D"https://drive.google.com/file/d=
/1sn3NUUeCm46zVyJKHkpytTIgGw1fUt5T/view?usp=3Dsharing" rel=3D"noreferrer" t=
arget=3D"_blank">https://drive.google.com/file/d/1sn3NUUeCm46zVyJKHkpytTIgG=
w1fUt5T/view?usp=3Dsharing</a><br>
<br>
[1] <a href=3D"https://mail.google.com/mail/u/0?ui=3D2&amp;ik=3D73ebd65ebd&=
amp;attid=3D0.1&amp;permmsgid=3Dmsg-f:1767388565327924962&amp;th=3D18870689=
40754ee2&amp;view=3Datt&amp;disp=3Dinline&amp;realattid=3Df_libalimc0" rel=
=3D"noreferrer" target=3D"_blank">https://mail.google.com/mail/u/0?ui=3D2&a=
mp;ik=3D73ebd65ebd&amp;attid=3D0.1&amp;permmsgid=3Dmsg-f:176738856532792496=
2&amp;th=3D1887068940754ee2&amp;view=3Datt&amp;disp=3Dinline&amp;realattid=
=3Df_libalimc0</a><br>
[2] <a href=3D"https://www.mail-archive.com/virtio-dev@lists.oasis-open.org=
/msg12665.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archi=
ve.com/virtio-dev@lists.oasis-open.org/msg12665.html</a><br>
[3] <a href=3D"https://github.com/chromeos/virtio-media/blob/main/TRY_IT_OU=
T.md" rel=3D"noreferrer" target=3D"_blank">https://github.com/chromeos/virt=
io-media/blob/main/TRY_IT_OUT.md</a><br>
<br>
Albert Esteve (1):<br>
=C2=A0 virtio-media: Add virtio media device specification<br>
<br>
=C2=A0conformance.tex=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 13 +-<br>
=C2=A0content.tex=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br=
>
=C2=A0device-types/media/description.tex=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 578 +=
+++++++++++++++++++++<br>
=C2=A0device-types/media/device-conformance.tex |=C2=A0 11 +<br>
=C2=A0device-types/media/driver-conformance.tex |=C2=A0 =C2=A09 +<br>
=C2=A05 files changed, 608 insertions(+), 4 deletions(-)<br>
=C2=A0create mode 100644 device-types/media/description.tex<br>
=C2=A0create mode 100644 device-types/media/device-conformance.tex<br>
=C2=A0create mode 100644 device-types/media/driver-conformance.tex<br>
<br>
-- <br>
2.44.0<br>
<br>
</blockquote></div>

--0000000000004c427e061a487edf--

