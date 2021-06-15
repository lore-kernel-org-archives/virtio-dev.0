Return-Path: virtio-dev-return-8193-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BF7279864A1
	for <virtio-dev@lists.oasis-open.org>; Tue, 15 Jun 2021 21:26:55 +0000 (UTC)
MIME-Version: 1.0
References: <20210614232650.265428-1-chenhaosjtuacm@google.com>
 <CABATKF8CSfNs3VJViX44Ui=ugJriWX680Grm3w6VxtQkE5+LSw@mail.gmail.com> <28d71143-5dc2-f730-5590-399d377bde8f@metux.net>
In-Reply-To: <28d71143-5dc2-f730-5590-399d377bde8f@metux.net>
From: Hao Chen <chenhaosjtuacm@google.com>
Date: Tue, 15 Jun 2021 14:26:43 -0700
Message-ID: <CABATKF-CK+oG8=Sjw8ewXLg4YqnCSMVaT-fkjqg2i3+yXyc_2Q@mail.gmail.com>
Subject: Re: [virtio-dev] Fwd: [PATCH v1] Add virtio audio policy device specification
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

> Audio in general is a complex matter as soon as RT requirements,
> multiple producers, various codecs, filters, harware mixing and routing,
> etc, come in.

I agree, but this is not the problem we want to solve here. Like you
said, this is purely voluntary.
The device will basically notify the VMs when others are playing. The
mixer on the host may or
may not do something to the VM's audio output (e.g., mute), but the VM
does not need to know.

Speaking of being voluntary, you can say it is "voluntary" because we
never enforce the action
of the process of the VM when receiving a notice, but there are
(hardware and/or software) mixers below, so if
this process choose to ignore the notice, it may lose the content when
the underlying mixer decides to mute it.

> It seems that this is just an simple arbiter that doesn't do much more
> than managing flags in a central place. Doesn't seem to related to any
> actual (virtio) devices at all. Why not just using some remote file syste=
m like 9P for that ?

Like I said in another patch, we can do whatever we want. We can use
any protocol we like and interpret
the meaning of the moving bytes as we like, but it doesn't mean
anything. The good thing about putting
them into a spec is when everybody agrees on it, we can build based on
the spec without needing to
persuade others "hey, let's use 9P. BTW, 0001 means I am about to mute you"=
.

> What is this really meant for ? Are there any actual implementations for
> that approach ?

We use it for controlling audio streams on cars. For example, the
music and navigation audio streams from your
IVI and safety chimes from the car. They are on different OSes.
Currently we have an implementation but not based
on virtio.

Thanks,
Hao

On Tue, Jun 15, 2021 at 5:04 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 15.06.21 01:28, Hao Chen wrote:
>
> Hi,
>
> > ---------- Forwarded message ---------
> > From: Hao Chen <chenhaosjtuacm@google.com>
> > Date: Mon, Jun 14, 2021 at 4:26 PM
> > Subject: [PATCH v1] Add virtio audio policy device specification
> > To: <chenhaosjtuacm@google.com>
> >
> >
> > This patch includes a new device for coordinating audio among mutliple
> > VMs.
>
> Wouldn't this be better a case for audio servers (e.g. PA) ?
> Once we already have several VMs (or just multiple programs) playing to
> the same output channel we're IMHO directly within the use case of audio
> servers.
>
> Audio in general is a complex matter as soon as RT requirements,
> multiple producers, various codecs, filters, harware mixing and routing,
> etc, come in.
>
> It seems we currently only have a pretty trivial virtio audio device
> that even only supports raw PCM.
>
> <snip>
>
> > +When there are multiple guest VMs playing sounds, they may want to coo=
perate
> > +with each other. For example, a VM is playing something very critical =
and want
> > +to mute everyone else; or it is OK for other to lower the volume ("duc=
k") but
> > +keep playing; or it is OK to playing concurrently with other sounds. T=
hey can
> > +cooperate via audio policy device. The driver notifies the device when=
 the
> > +guest VM is playing, and the device will notify other VMs. The driver =
can also
> > +suggest the device to mute or duck some audio devices based on the inf=
ormation
> > +it received from the device.
>
> It seems that this is just an simple arbiter that doesn't do much more
> than managing flags in a central place. Doesn't seem to related to any
> actual (virtio) devices at all. And purely volountarily (not enforcing
> anything, just notifying)
>
> Why not just using some remote file system like 9P for that ?
>
> Really seems to be a very special case thing to me, and I'm really
> unsure whether there's much gain in having an own virtio device for that
> at all.
>
> What is this really meant for ? Are there any actual implementations for
> that approach ?
>
>
> --mtx
>
> --
> ---
> Hinweis: unverschl=C3=BCsselte E-Mails k=C3=B6nnen leicht abgeh=C3=B6rt u=
nd manipuliert
> werden ! F=C3=BCr eine vertrauliche Kommunikation senden Sie bitte ihren
> GPG/PGP-Schl=C3=BCssel zu.
> ---
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

