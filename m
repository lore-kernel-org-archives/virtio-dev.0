Return-Path: virtio-dev-return-7423-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 133D9986070
	for <virtio-dev@lists.oasis-open.org>; Thu, 28 May 2020 19:47:14 +0000 (UTC)
References: <87sgga4daf.fsf@linaro.org>
 <bb869ec95dc2479982e3390d650753d9@intel.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <bb869ec95dc2479982e3390d650753d9@intel.com>
Date: Thu, 28 May 2020 20:47:09 +0100
Message-ID: <871rn34zb6.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: VIRTIO RPMB Front End drivers for Linux
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huang,
 Yang" <yang.huang@intel.com>, "Zhu, Bing" <bing.zhu@intel.com>, "Michael
 S.Tsirkin" <mst@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>


Winkler, Tomas <tomas.winkler@intel.com> writes:

> Hi, yes the OASIS spec is based around this ACRN solution. We are still p=
lanning on another Linux kernel submission effort, actually in the next rel=
ease cycle.=20
> The capability message which is not implemented in the virtio solution is=
 due to NVMe support, which didn't make into OASIS spec.=20
> There is an rpmb tool under tools/rpmb of the Linux kernel, also AOS gues=
t on ACRN uses this interface, there should be doc under Documentation/driv=
er-api/rpmb/.=20

Thanks for the pointers they are really helpful.

> I'm not sure how updated is ACRN public tree, but I'll post
> https://github.com/tomasbw/linux-mei rpmb branch, I hope in a week or
> two.

Thanks. Looking at the ACRN tree when their base rpmb commit (01abd0e5)
as added on a 5.4 based machine. The commits have V10 references bellow
the --- which implies some changes from your series against v4.14-rc5.

I've cherry-picked the initial ones out of the ACRN tree and they seemed
to re-base onto v5.6.7 reasonably enough (untested branch):

  https://git.linaro.org/people/alex.bennee/linux.git/log/?h=3Dreview/rpmb

There are a bunch more commits touching that in the ACRN tree but
hopefully this will give me a minimum testing set without having
everything else that's in there.

It does make me wonder if any of these patches are on an upstream path
or are they likely to live in 3rd party trees forever?

> There is also a simulation HW drivers/char/rpmb/rpmb_sim.C it's based on =
eMMC part of the spec.=20
> I do have some very simple tests to exercise this interface. =20
>
> Thanks
> Tomas
>
>
>
>> -----Original Message-----
>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Sent: Friday, May 08, 2020 19:12
>> To: virtio-dev@lists.oasis-open.org; Winkler, Tomas
>> <tomas.winkler@intel.com>; Huang, Yang <yang.huang@intel.com>
>> Cc: Zhu, Bing <bing.zhu@intel.com>; Michael S.Tsirkin <mst@redhat.com>; =
Ilias
>> Apalodimas <ilias.apalodimas@linaro.org>
>> Subject: VIRTIO RPMB Front End drivers for Linux
>>=20
>>=20
>> Hi,
>>=20
>> I'm currently working on a vhost-user backend for virto-rpmb as defined =
in the
>> draft version of the OASIS spec (since 8c6acac2). I'm developing it with=
in the
>> QEMU source tree but it is intended to be a portable vhost-user binary w=
ith
>> minimal POSIX like dependencies.
>>=20
>> Part of the aim of the project is to experiment with a vhost-user backen=
d that
>> has minimal access to guest memory and RPMB makes sense as the vhost-use=
r
>> daemon only really needs to see the virt queues to pass the data back an=
d forth.
>> One eventual architecture would be to move the vhost-user driver into it=
's own
>> isolated VM with only minimal memory sharing between the guest and it's =
back-
>> end.
>>=20
>> I've gotten enough of the plumbing working now that I'm ready to start
>> implementing the RPMB spec itself. I've been looking for a front-end to =
use in
>> testing and I found the Linux driver sitting in Project ACRN's guest ker=
nel fork.
>> With this kernel and VIRTIO_ID_RPMB tweaked to the standard based one I =
get
>> far enough that the driver is initialised before my drivers falls over w=
hen an un-
>> handled feature is requested (0x130000000). This is slightly confusing b=
ecause
>> the spec doesn't define any feature bits. So a few questions:
>>=20
>>   - how divergent is the virtio-rpmb front/back-end in ACRN from the
>>     OASIS spec?
>>=20
>>   - is there likely to be another submission to the upstream kernel?
>>=20
>> I've also read the document on the ACRN website which talks about the se=
cure
>> architecture:
>>=20
>>   https://projectacrn.github.io/latest/tutorials/trustyACRN.html
>>=20
>> I was wondering if there was any low level usage information. From looki=
ng at
>> the Kconfig options it seems the virtio-rpmb driver interfaces with a wi=
der RPMB
>> sub-system which exposes a character device to the kernels user-space. S=
o:
>>=20
>>   - are there any special user-space tools to use this interface?
>>=20
>>   - is there a write-up somewhere of how to exercise the interface or
>>     any sort of test suite?
>>=20
>> Thanks in advance,
>>=20
>>=20
>> --
>> Alex Benn=C3=A9e


--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

