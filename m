Return-Path: virtio-dev-return-5747-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6E78A985E56
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 May 2019 06:31:17 +0000 (UTC)
From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Date: Wed, 15 May 2019 06:30:45 +0000
Message-ID: <76D732A88286A1478FFA94B453B715C1EEA27A2B@MXS02.open-synergy.com>
References: <20190503164501.GB8373@stefanha-x1.localdomain>
 <863e1be1-11cc-816b-896d-3954427e98f3@13byte.com>
 <20190506052715.vkdopunuauyhl22m@sirius.home.kraxel.org>
 <7ac2ae97-bcb7-22cc-272a-723e7209910c@13byte.com>
 <20190509122710.rfhfnhqez2u7inju@sirius.home.kraxel.org>
 <5d316321-2c48-342b-f2ce-359e3596dae0@opensynergy.com>
 <20190510121656.3ab7w5xef6io764o@sirius.home.kraxel.org>
 <76D732A88286A1478FFA94B453B715C1EEA25DD4@MXS02.open-synergy.com>
 <20190510154824.GJ22311@stefanha-x1.localdomain>
 <76D732A88286A1478FFA94B453B715C1EEA25EB1@MXS02.open-synergy.com>,<20190514134448.GB6555@stefanha-x1.localdomain>
In-Reply-To: <20190514134448.GB6555@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, Marco Martinelli - 13Byte srl <marco@13byte.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, =?iso-8859-2?Q?K=F5v=E1g=F3_Zolt=E1n?= <dirty.ice.hu@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

>> So, our proposal is to support classic way of communications by default =
and introduce shared memory based approach as either non-standard extension=
 or part of future VIRTIO device types. And switch to this mode where it's =
possible or make sense. Like, all modern type-2 hypervisors usually have no=
 problems with sharing memory between guest and host, so why not provide to=
 user high quality virtual audio device?
>
> virtqueues offer reliable delivery, so #2 isn't an issue.
>
> Real-time is achievable and can be done with low latency.  Make the
> receiver a real-time thread that polls the vring periodically (based on
> the latency/buffer size requirement).  The vring supports lock-free
> access so this is perfect for real-time.
>
> When I say "receiver" I mean the driver's capture and device's playback
> components.  Both of them have real-time requirements.
>
> Does this approach meet your requirements?

After careful consideration, I think polling mode should make it possible. =
Like, using dedicated "data" queue per stream in polling mode (multiplexing=
 is not an option, since it reduces queue throughput in proportion to the n=
umber of multiplexed streams). How to describe it in specification?


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

