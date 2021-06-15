Return-Path: virtio-dev-return-8192-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6C3B19865A0
	for <virtio-dev@lists.oasis-open.org>; Tue, 15 Jun 2021 12:04:25 +0000 (UTC)
References: <20210614232650.265428-1-chenhaosjtuacm@google.com>
 <CABATKF8CSfNs3VJViX44Ui=ugJriWX680Grm3w6VxtQkE5+LSw@mail.gmail.com>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <28d71143-5dc2-f730-5590-399d377bde8f@metux.net>
Date: Tue, 15 Jun 2021 14:04:21 +0200
MIME-Version: 1.0
In-Reply-To: <CABATKF8CSfNs3VJViX44Ui=ugJriWX680Grm3w6VxtQkE5+LSw@mail.gmail.com>
Subject: Re: [virtio-dev] Fwd: [PATCH v1] Add virtio audio policy device
 specification
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: quoted-printable
To: Hao Chen <chenhaosjtuacm@google.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 15.06.21 01:28, Hao Chen wrote:

Hi,

> ---------- Forwarded message ---------
> From: Hao Chen <chenhaosjtuacm@google.com>
> Date: Mon, Jun 14, 2021 at 4:26 PM
> Subject: [PATCH v1] Add virtio audio policy device specification
> To: <chenhaosjtuacm@google.com>
>=20
>=20
> This patch includes a new device for coordinating audio among mutliple
> VMs.

Wouldn't this be better a case for audio servers (e.g. PA) ?
Once we already have several VMs (or just multiple programs) playing to
the same output channel we're IMHO directly within the use case of audio
servers.

Audio in general is a complex matter as soon as RT requirements,
multiple producers, various codecs, filters, harware mixing and routing,
etc, come in.

It seems we currently only have a pretty trivial virtio audio device
that even only supports raw PCM.

<snip>

> +When there are multiple guest VMs playing sounds, they may want to coope=
rate
> +with each other. For example, a VM is playing something very critical an=
d want
> +to mute everyone else; or it is OK for other to lower the volume ("duck"=
) but
> +keep playing; or it is OK to playing concurrently with other sounds. The=
y can
> +cooperate via audio policy device. The driver notifies the device when t=
he
> +guest VM is playing, and the device will notify other VMs. The driver ca=
n also
> +suggest the device to mute or duck some audio devices based on the infor=
mation
> +it received from the device.

It seems that this is just an simple arbiter that doesn't do much more
than managing flags in a central place. Doesn't seem to related to any
actual (virtio) devices at all. And purely volountarily (not enforcing
anything, just notifying)

Why not just using some remote file system like 9P for that ?

Really seems to be a very special case thing to me, and I'm really
unsure whether there's much gain in having an own virtio device for that
at all.

What is this really meant for ? Are there any actual implementations for
that approach ?


--mtx

--=20
---
Hinweis: unverschl=C3=BCsselte E-Mails k=C3=B6nnen leicht abgeh=C3=B6rt und=
 manipuliert
werden ! F=C3=BCr eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schl=C3=BCssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

