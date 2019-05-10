Return-Path: virtio-dev-return-5731-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA165985DFB
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 May 2019 17:13:37 +0000 (UTC)
From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Date: Fri, 10 May 2019 17:13:26 +0000
Message-ID: <76D732A88286A1478FFA94B453B715C1EEA25EB1@MXS02.open-synergy.com>
References: <20190501170525.GB22391@stefanha-x1.localdomain>
 <c74aebe9-5db4-902f-ef0b-f0a786806acd@13byte.com>
 <20190503164501.GB8373@stefanha-x1.localdomain>
 <863e1be1-11cc-816b-896d-3954427e98f3@13byte.com>
 <20190506052715.vkdopunuauyhl22m@sirius.home.kraxel.org>
 <7ac2ae97-bcb7-22cc-272a-723e7209910c@13byte.com>
 <20190509122710.rfhfnhqez2u7inju@sirius.home.kraxel.org>
 <5d316321-2c48-342b-f2ce-359e3596dae0@opensynergy.com>
 <20190510121656.3ab7w5xef6io764o@sirius.home.kraxel.org>
 <76D732A88286A1478FFA94B453B715C1EEA25DD4@MXS02.open-synergy.com>,<20190510154824.GJ22311@stefanha-x1.localdomain>
In-Reply-To: <20190510154824.GJ22311@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, Marco Martinelli - 13Byte srl <marco@13byte.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, =?iso-8859-2?Q?K=F5v=E1g=F3_Zolt=E1n?= <dirty.ice.hu@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> Shared memory isn't a native concept to VIRTIO.  The device and the
> driver don't assume shared memory access in the general case (i.e.
> virtqueue buffers could even be copied and virtio-blk, virtio-net, etc
> would still work!).
>
> There is currently a spec extension on the mailing list to add Shared
> Memory Resources to VIRTIO and new device types will use it.  However, I
> don't think this is necessary for this use case.

Yes, we are awared about VIRTIO and shared memory relationships. Our origin=
al propose was to support classic way of communications by default. And, th=
anks to your comments, it can be further improved.

But there's one issue. An audio device is a real-time device. It has explic=
it hard deadline. And there're many factors helping an audio device to fail=
 to meet the deadline due to virtualization overhead. And in that sense a v=
irtual audio device differs from each and every other virtual devices. If a=
 block device becomes slower - not a big deal, if a network device becomes =
slower - not a big deal, if a GPU device starts to skip frames - not very n=
ice, but also not a big deal. But if an audio device starts to skip frames =
- it's a big problem, and device is nonfunctional as a matter of fact. Good=
 audio device implementation must met two criterias:

1. Low latency
2. No frame dropping at all

All I want to say is that any queue-based approach can not guaranty correct=
 functionality to an audio device for all possible use cases. Because a que=
ue has its natural limitations: either in terms of additional latency due t=
o queue notifications, or due to queue limited size. And an audio device ev=
entually will hit one of them for some application. It means, we can not su=
pport some cases, which works pretty fine in native operating systems. But =
such limitations are artificial ones due, again, using a queue for data tra=
nsfers. In case of shared memory such limitations are just gone.

So, our proposal is to support classic way of communications by default and=
 introduce shared memory based approach as either non-standard extension or=
 part of future VIRTIO device types. And switch to this mode where it's pos=
sible or make sense. Like, all modern type-2 hypervisors usually have no pr=
oblems with sharing memory between guest and host, so why not provide to us=
er high quality virtual audio device?

--
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

www.opensynergy.com

Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>
COQOS Hypervisor certified by T=DCV S=DCD
                [COQOS Hypervisor certified by T=DCV S=DCD]

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

