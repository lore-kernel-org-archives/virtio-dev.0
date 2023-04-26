Return-Path: <virtio-dev-return-12426-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3435C77B78
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 05:52:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C15F72B143
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 05:52:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8CAFB98664C
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 05:52:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 69CD0983FE8; Wed, 26 Apr 2023 05:52:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 55E7F9865E2
	for <virtio-dev@lists.oasis-open.org>; Wed, 26 Apr 2023 05:52:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682488352; x=1685080352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6spGFkt+MKWyWetjlGkhBy7+PmdwfcT+xJ7n+5a7is=;
        b=dw324TyU2hekC9AVeibMgArmcNXdjSb2Y+aR4tF5M8Yq77B7vmJKeue1SgFc0xSshz
         oShBhBggcSudT8lYZjf5+laozfKQHBV1okJ5FQoq/18CWUV/3lE9RhMfYR5dY/xivgMS
         Mj9wiu0i/CH+VGVPd6cNuZcRv7QxHbmzP+a7cSHn59+TwiWzFc3dM2qcxRSi1f7f5G4b
         xghkRJP87IGFrqrEtHaRj9t9MD9Q10hb3r8ac/J75XP0Odt43JniHv4VZKZrkSd7fe6x
         VchqfnkYGmjfmzE+jlq84A3bqv3rtWhLFUZ9ZFGe39M3BT+Svc8iNxzZCLSeowGUmXhP
         qmJg==
X-Gm-Message-State: AAQBX9djM2oxzyNA2L34q5yY29kAKuDToqMDbK7xkDO8oLRevfy8+p75
	qAA2VKGmohD+pBmqFCi27ZsYIQPk3NgamKkDHhU=
X-Google-Smtp-Source: AKy350bc3LmdIo5CJRAvAdN5DG8FKSaOgkgyJ2ryF0ryui8DB6SNkmybX/m8+5SFYtAM+qZLKNNh6w==
X-Received: by 2002:a92:d94a:0:b0:32a:f852:318a with SMTP id l10-20020a92d94a000000b0032af852318amr10038288ilq.24.1682488351985;
        Tue, 25 Apr 2023 22:52:31 -0700 (PDT)
X-Received: by 2002:a05:6e02:1aae:b0:32c:a94e:b4b2 with SMTP id
 l14-20020a056e021aae00b0032ca94eb4b2mr119697ilv.7.1682488349751; Tue, 25 Apr
 2023 22:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com> <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com> <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com> <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com> <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com> <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com> <87o7nmk1rs.fsf@redhat.com>
 <96978ce8-0837-2e08-f5ca-66587807798b@opensynergy.com> <CAPBb6MUHXh0XYLH=8anWLNQaS+p6_VhMRki+qSqFQGeYQzBSSA@mail.gmail.com>
 <2d5df33a-c246-81ee-92e7-a44712600e62@opensynergy.com> <590378d1-83e0-b058-7eeb-2dbe5963670e@opensynergy.com>
In-Reply-To: <590378d1-83e0-b058-7eeb-2dbe5963670e@opensynergy.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Wed, 26 Apr 2023 14:52:17 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWMjvTiAdCwfUH62EpqYLHotFoDg7hAfqY2oLkpmYM_HQ@mail.gmail.com>
Message-ID: <CAPBb6MWMjvTiAdCwfUH62EpqYLHotFoDg7hAfqY2oLkpmYM_HQ@mail.gmail.com>
To: Alexander Gordeev <alexander.gordeev@opensynergy.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org, 
	Keiichi Watanabe <keiichiw@chromium.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=C3=B6ll?= <Matti.Moell@opensynergy.com>, 
	Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, 
	Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Bart=C5=82omiej_Grzesik?= <bag@semihalf.com>, 
	Tomasz Figa <tfiga@chromium.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Enric Balletbo i Serra <eballetb@redhat.com>, Albert Esteve <aesteve@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On Mon, Apr 24, 2023 at 4:52=E2=80=AFPM Alexander Gordeev
<alexander.gordeev@opensynergy.com> wrote:
>
> On 21.04.23 18:01, Alexander Gordeev wrote:
>
> Hi Alexandre,
>
> On 21.04.23 06:02, Alexandre Courbot wrote:
>
> * I am still not convinced that V4L2 is lacking from a security
> perspective. It would take just one valid example to change my mind
> (and no, the way the queues are named is not valid). And btw, if it
> really introduces security issues, then this makes it invalid for
> inclusion in virtio entirely, just not OpSy's hypervisor.
>
>
> I'd like to start with this and then answer everything else later.
>
> Let's compare VIRTIO_VIDEO_CMD_RESOURCE_QUEUE with
> VIDIOC_QBUF+VIDIOC_DQBUF. Including the parameters, of course. First,
> let's compare the word count to get a very rough estimate of complexity.
> I counted 585 words for VIRTIO_VIDEO_CMD_RESOURCE_QUEUE, including the
> parameters. VIDIOC_QBUF+VIDIOC_DQBUF are defined together and take 1206
> words, they both use struct v4l2_buffer as a parameter. The struct takes
> 2716 words to be described. So the whole thing takes 3922 words. This is
> 6.7 times more, than VIRTIO_VIDEO_CMD_RESOURCE_QUEUE. If we check the
> definitions of the structs, it is also very obvious, that V4L2 UAPI is
> almost like an order of magnitude more complex.
>
>
> I think, it is best to add all the steps necessary to reproduce my calcul=
ations just in case.
>
> VIRTIO_VIDEO_CMD_RESOURCE_QUEUE is doing essentially the same thing as VI=
DIOC_QBUF+VIDIOC_DQBUF, so we're comparing apples to apples (if we don't fo=
rget to compare their parameters too).
>
> To get the word count for the VIRTIO_VIDEO_CMD_RESOURCE_QUEUE I opened th=
e rendered PDF of video section only from the first email in this thread. H=
ere is the link: https://drive.google.com/file/d/1Sm6LSqvKqQiwYmDE9BXZ0po3X=
TKnKYlD/view?usp=3Dsharing . Then I scrolled to page 11 and copied everythi=
ng related a text file. This is around two pages in the PDF. Then I removed=
 page numbers from the copied text and used 'wc -w' to count words.
>
> To get the word count for VIDIOC_QBUF+VIDIOC_DQBUF I opened this link: ht=
tps://docs.kernel.org/userspace-api/media/v4l/vidioc-qbuf.html . Then I sel=
ected all the text except table of contents and did followed the same proce=
dure.
>
> To get the word count for struct v4l2_buffer and other types, that are re=
ferenced from it, I opened this link: https://docs.kernel.org/userspace-api=
/media/v4l/buffer.html#struct-v4l2-buffer . Then I selected all the text ex=
cept the table of contents and the text above struct v4l2_buffer definition=
. The rest is the same.
>
> Also it's quite obvious if you look at them how much bigger struct v4l2_b=
uffer (including the referenced types) is compared to struct virtio_video_r=
esource_queue.

You are comparing not the complexity of the structures but the
verbosity of their documentation, which are written in a different
style, format, and by different people. And the V4L2 page also
contains the description of memory types, which is part of another
section in the virtio-video spec. There is no way to draw a meaningful
conclusion from this.

If you want to compare, do it with how the structures are actually
used. Here is how you would queue an input buffer with virtio-video:

  struct virtio_video_resource_queue queue_buf =3D {
      .cmd_type =3D VIRTIO_VIDEO_CMD_RESOURCE_QUEUE,
      .stream_id =3D 42,
      .queue_type =3D VIRTIO_VIDEO_QUEUE_TYPE_INPUT,
      .resource_id =3D 1,
      .timestamp =3D 0x10,
      .data_sizes =3D {
        [0] =3D 0x1000,
      },
  };

Now the same with virtio-v4l2:

  struct virtio_v4l2_queue_buf queue_buf =3D {
      .cmd =3D VIRTIO_V4L2_CMD_IOCTL,
      .code =3D VIDIOC_QBUF,
      .session_id =3D 42,
      .buffer.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
      .buffer.index =3D 1,
      .buffer.timestamp.tv_usec =3D 0x10,
      .buffer.memory =3D V4L2_MEMORY_MMAP,
      .planes =3D {
        [0] =3D { .bytesused =3D 0x1000 },
      }
  };

In both cases, you pass a structure with some members set, and the
rest to 0. The host receives basically the same thing - it's the same
data! The only difference is how it is laid out.

Also as mentioned by Bart, the apparent simplicity of
VIRTIO_VIDEO_CMD_RESOURCE_QUEUE, which does not require a dequeue
operation as the dequeue is sent with its response, is actually a
fallacy: that design choice makes the specification simpler, but at
the cost of more complexity on the device side and the potential to
starve on command descriptors. By contrast, adopting the V4L2 model
resulted in simpler code on both sides and no possibility to deadlock.
That point could be addressed by revising the virtio-video spec, but
then you get even closer to V4L2.

>
> Do we agree now, that V4L2 UAPI is not only marginally more complex?

No, and I rest my case on the code samples above.

>
>
> Also please read:
>
> https://medium.com/starting-up-security/evidence-of-absence-8148958da092
>
>
> This reference probably needs a clarification. You argued, that V4L2 has =
a good track record so far. Here is the quote:
>
> FWIW V4L2 has been in use for a looong time (including in Chromebooks
> that do secure playback) and I am not aware of fundamental security
> issues with it.
>
> But absence of found major security issues doesn't tell us much about the=
 number of not found ones. Absence of evidence is not an evidence of absenc=
e. At the link above a former Director of Security at Facebook shares his t=
houghts about what could be a good evidence of absence of major security pr=
oblems.

You are just FUDing now. The exact same argument could be made about
virtio-video. If you want to borrow from the security world, I can ask
you how going with virtio-video when V4L2 exists is different from
rolling your own crypto.

>
> So a bug bounty program with high premiums that covers V4L2 would be a be=
tter argument in favor of *already written code* in my opinion. Not for new=
 code. Also probably it is also an argument in favor of the spec, that is t=
he V4L2 UAPI. Like that it is polished enough. Not so sure about that thoug=
h.
>
> There actually are several bug bounty programs, that cover the kernel. Th=
ese are Google's kctf, ZDI's pwn2own, and zerodium AFAIK. However the premi=
ums are not even close to the ones mentioned in my reference. Anyway this m=
eans, that using *the existing V4L2 code in the kernel* is probably OK. But=
 this creates some limitations if we want the actual code to still be cover=
ed with these bug bounties, right? This means, that the host OS has to be L=
inux and the actual hardware has to be exposed through a stable V4L2 driver=
, that is in mainline for some time, and there has to be no or little proce=
ssing on top. For us this is not possible unfortunately. In the end both th=
ings could be secure:
>
> 1. V4L2 pass through can be secure because of the bug bounty programs and=
 a lot of attention to the kernel in general.
> 2. For the new code this doesn't work, so the spec should be as simple an=
d device-centric as possible. Because, all other things being equal, there =
are fewer errors in simpler programs. So defining a subset of V4L2 UAPI inc=
luding the data types looks like a good idea to me. The stateful decoder in=
terface, that you point to, does not define a subset in the data types.

Wouldn't you have exactly the same problem by using a new guest-host
protocol? Are you going to start a bounty program for virtio-video to
get an assurance that it is secure?

>
> This is basically my reasoning.
>
> Also these two specs don't need to compete with each other. They have dif=
ferent limitations and they are for different audiences. If you check the X=
KCD's comic, it is about competing standards.

They allow exactly the same thing (virtualization of video
decoding/encoding) and there isn't any use-case of virtio-video that
could not be covered equally well by V4L2. Reinventing a new video
specification is pointless and will lead to unneeded fragmentation.

We should also expect reticence from the Linux community to upstream
two virtual video drivers that basically do the same thing.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

