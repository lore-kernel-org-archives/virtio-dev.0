Return-Path: virtio-dev-return-5740-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 76CD2984410
	for <virtio-dev@lists.oasis-open.org>; Sun, 12 May 2019 20:02:50 +0000 (UTC)
References: <20190501170525.GB22391@stefanha-x1.localdomain>
 <c74aebe9-5db4-902f-ef0b-f0a786806acd@13byte.com>
 <20190503164501.GB8373@stefanha-x1.localdomain>
 <863e1be1-11cc-816b-896d-3954427e98f3@13byte.com>
 <20190506052715.vkdopunuauyhl22m@sirius.home.kraxel.org>
 <7ac2ae97-bcb7-22cc-272a-723e7209910c@13byte.com>
 <20190509122710.rfhfnhqez2u7inju@sirius.home.kraxel.org>
 <5d316321-2c48-342b-f2ce-359e3596dae0@opensynergy.com>
 <20190510121656.3ab7w5xef6io764o@sirius.home.kraxel.org>
 <76D732A88286A1478FFA94B453B715C1EEA25DD4@MXS02.open-synergy.com>
 <20190510154824.GJ22311@stefanha-x1.localdomain>
 <76D732A88286A1478FFA94B453B715C1EEA25EB1@MXS02.open-synergy.com>
 <91bb7417-fc62-27e6-95a7-d5588699d5e1@13byte.com>
From: Matti Moell <Matti.Moell@opensynergy.com>
Message-ID: <07e218fa-1496-721c-7651-59c492d021d8@opensynergy.com>
Date: Sun, 12 May 2019 22:01:43 +0200
MIME-Version: 1.0
In-Reply-To: <91bb7417-fc62-27e6-95a7-d5588699d5e1@13byte.com>
Content-Type: text/plain; charset="iso-8859-2"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Marco Martinelli - 13Byte srl <marco@13byte.com>, Anton Yakovlev <Anton.Yakovlev@opensynergy.com>, Stefan Hajnoczi <stefanha@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, =?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Marco,

On 11.05.19 22:49, Marco Martinelli - 13Byte srl wrote:
> Wow, it seems like you guys from opensinergy beat me on time. Nice job,
> congratulations!
Thanks a lot, I think out main problem was that we kept it under the
covers for so long.
>
> Your work is way ahead of mine, so much that I'm thinking of stepping
> aside and letting you do the specifications, while experimenting on my
> code privately just for the fun of it.
> Just a couple of questions.
> You mentioned that the PoC was tested on Linux and Windows 10. I presume
> these are the guest OSs.
For us, Linux is the primary guest OS at the moment.
> On the host side are you working on qemu or another hypervisor?
> Besides contributing to the specifications, will you open source the
> actual implementation?
The host side is another hypervisor.
> From your website I see you work in the automotive business. Will your
> implementation be automotive oriented or general purpose?
> My idea was to support the general public and in particular the gamers
> and the musicians with my project. I want to be sure that these
> categories will be supported.
Well, virtio is general purpose and so should all devices, even if we
use it in automotive contexts. TBH, automotive requirements aren't that
different from gaming or music production. You will often have very
strict latency requirements and need support for multiple channels
(coherent and non-coherent). So I think the overlap is huge.

But, as a matter of fact, I don't think Anton and I know exactly what
the general public is interested in so, your help would be very
appreciated here.

> The reason I'm asking these questions is to see if it makes sense for me
> to keep working on this project, perhaps to implement the specifications
> proposed by you, or if you're already taking care of everything I was
> interested in implementing.

It definitely makes sense for you to keep working on this, I believe
that we might not have the time at the moment to work on a full qemu
implementation and having an independent implementation of the device
side would be pretty awesome.

We plan to send patches for the device driver in Linux in the near
future and we might even be able to share the windows one (Anton should
know).

Cheers,

                Matti

----

Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

