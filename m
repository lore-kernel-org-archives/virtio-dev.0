Return-Path: virtio-dev-return-5737-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 04253985E0A
	for <virtio-dev@lists.oasis-open.org>; Sat, 11 May 2019 20:49:08 +0000 (UTC)
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
From: Marco Martinelli - 13Byte srl <marco@13byte.com>
Message-ID: <91bb7417-fc62-27e6-95a7-d5588699d5e1@13byte.com>
Date: Sat, 11 May 2019 22:49:04 +0200
MIME-Version: 1.0
In-Reply-To: <76D732A88286A1478FFA94B453B715C1EEA25EB1@MXS02.open-synergy.com>
Content-Type: text/plain; charset="iso-8859-2"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>, Stefan Hajnoczi <stefanha@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, =?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Wow, it seems like you guys from opensinergy beat me on time. Nice job,=20
congratulations!

Your work is way ahead of mine, so much that I'm thinking of stepping=20
aside and letting you do the specifications, while experimenting on my=20
code privately just for the fun of it.
Just a couple of questions.
You mentioned that the PoC was tested on Linux and Windows 10. I presume=20
these are the guest OSs.
On the host side are you working on qemu or another hypervisor?
Besides contributing to the specifications, will you open source the=20
actual implementation?
 From your website I see you work in the automotive business. Will your=20
implementation be automotive oriented or general purpose?
My idea was to support the general public and in particular the gamers=20
and the musicians with my project. I want to be sure that these=20
categories will be supported.
The reason I'm asking these questions is to see if it makes sense for me=20
to keep working on this project, perhaps to implement the specifications=20
proposed by you, or if you're already taking care of everything I was=20
interested in implementing.


Best regards,
Marco


Il 10/05/19 19:13, Anton Yakovlev ha scritto:
>> Shared memory isn't a native concept to VIRTIO.  The device and the
>> driver don't assume shared memory access in the general case (i.e.
>> virtqueue buffers could even be copied and virtio-blk, virtio-net, etc
>> would still work!).
>>
>> There is currently a spec extension on the mailing list to add Shared
>> Memory Resources to VIRTIO and new device types will use it.  However, I
>> don't think this is necessary for this use case.
> Yes, we are awared about VIRTIO and shared memory relationships. Our orig=
inal propose was to support classic way of communications by default. And, =
thanks to your comments, it can be further improved.
>
> But there's one issue. An audio device is a real-time device. It has expl=
icit hard deadline. And there're many factors helping an audio device to fa=
il to meet the deadline due to virtualization overhead. And in that sense a=
 virtual audio device differs from each and every other virtual devices. If=
 a block device becomes slower - not a big deal, if a network device become=
s slower - not a big deal, if a GPU device starts to skip frames - not very=
 nice, but also not a big deal. But if an audio device starts to skip frame=
s - it's a big problem, and device is nonfunctional as a matter of fact. Go=
od audio device implementation must met two criterias:
>
> 1. Low latency
> 2. No frame dropping at all
>
> All I want to say is that any queue-based approach can not guaranty corre=
ct functionality to an audio device for all possible use cases. Because a q=
ueue has its natural limitations: either in terms of additional latency due=
 to queue notifications, or due to queue limited size. And an audio device =
eventually will hit one of them for some application. It means, we can not =
support some cases, which works pretty fine in native operating systems. Bu=
t such limitations are artificial ones due, again, using a queue for data t=
ransfers. In case of shared memory such limitations are just gone.
>
> So, our proposal is to support classic way of communications by default a=
nd introduce shared memory based approach as either non-standard extension =
or part of future VIRTIO device types. And switch to this mode where it's p=
ossible or make sense. Like, all modern type-2 hypervisors usually have no =
problems with sharing memory between guest and host, so why not provide to =
user high quality virtual audio device?
>
> --
> Anton Yakovlev
> Senior Software Engineer
>
> OpenSynergy GmbH
> Rotherstr. 20, 10245 Berlin
>
> www.opensynergy.com
>
> Please mind our privacy notice<https://www.opensynergy.com/datenschutzerk=
laerung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-=
general-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unse=
re Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www=
.opensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaef=
tspartner-gem-art-13-dsgvo/>
> COQOS Hypervisor certified by T=DCV S=DCD
>                  [COQOS Hypervisor certified by T=DCV S=DCD]
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

