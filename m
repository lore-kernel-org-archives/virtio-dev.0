Return-Path: virtio-dev-return-5750-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6ADC7985E88
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 May 2019 16:33:32 +0000 (UTC)
From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Date: Wed, 15 May 2019 16:33:23 +0000
Message-ID: <76D732A88286A1478FFA94B453B715C1EEA27CD5@MXS02.open-synergy.com>
References: <20190506052715.vkdopunuauyhl22m@sirius.home.kraxel.org>
 <7ac2ae97-bcb7-22cc-272a-723e7209910c@13byte.com>
 <20190509122710.rfhfnhqez2u7inju@sirius.home.kraxel.org>
 <5d316321-2c48-342b-f2ce-359e3596dae0@opensynergy.com>
 <20190510121656.3ab7w5xef6io764o@sirius.home.kraxel.org>
 <76D732A88286A1478FFA94B453B715C1EEA25DD4@MXS02.open-synergy.com>
 <20190510154824.GJ22311@stefanha-x1.localdomain>
 <76D732A88286A1478FFA94B453B715C1EEA25EB1@MXS02.open-synergy.com>
 <20190514134448.GB6555@stefanha-x1.localdomain>
 <76D732A88286A1478FFA94B453B715C1EEA27A2B@MXS02.open-synergy.com>,<20190515160339.GN29507@stefanha-x1.localdomain>
In-Reply-To: <20190515160339.GN29507@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, Marco Martinelli - 13Byte srl <marco@13byte.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, =?iso-8859-2?Q?K=F5v=E1g=F3_Zolt=E1n?= <dirty.ice.hu@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>


>> After careful consideration, I think polling mode should make it possibl=
e. Like, using dedicated "data" queue per stream in polling mode (multiplex=
ing is not an option, since it reduces queue throughput in proportion to th=
e number of multiplexed streams). How to describe it in specification?
>
> Polling is an implementation detail for both drivers and devices.
> Therefore it's not described explicitly in the specification.

And the only source of information in such case is to take a look into alre=
ady existed implementations?


> By the way, virtqueue buffers can be completed out-of-order by the
> device.  This means sharing a virtqueue between multiple streams does
> not necessarily introduce any kind of waiting.
>
> The only issue is the virtqueue size (e.g. 128 buffers) determines how
> many buffers can be made available from the driver to the device at any
> given time.  Some device implementations uses virtqueue sizes like 1024
> so that this does not become a practical concern.  Does this change your
> view on multiplexing streams?

Personally, I'm not a big fan of, because:

1. It makes overall logic more complex: you need to serialize access to the=
 queue on driver side and dispatch messages (find out recepient, serialize =
access etc) on device side. With separated queues you have only one produce=
r and consumer, and they both knows ahead how to handle buffers.
2. It requires to define message header for buffer transfers. With separate=
d queues you just put into descriptors a pointer to the buffer and its leng=
th.

The simpler the better. And with multiplexing basically you have no pros ex=
cept having one queue. Why separated queues are undesirable?


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

