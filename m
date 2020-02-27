Return-Path: virtio-dev-return-6804-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1D9E9985E3D
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Feb 2020 14:09:05 +0000 (UTC)
References: <20200109140743.303046-1-Anton.Yakovlev@opensynergy.com>
 <20200114101251.3qdo7w4zfsablo7t@sirius.home.kraxel.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <889de025-edfe-5d31-33b6-6cc842a91aee@opensynergy.com>
Date: Thu, 27 Feb 2020 15:08:59 +0100
MIME-Version: 1.0
In-Reply-To: <20200114101251.3qdo7w4zfsablo7t@sirius.home.kraxel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v5] virtio-snd: add virtio sound device
 specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hello all,

We have completed the implementation of the PoC specification v5. Below are=
=20
our comments on what might or should be improved in the specification.

Initialization:

1. I think we should add the direction of the jack (in/out) to the
configuration of the jack. Because some properties (for example, a label fo=
r
some jack types) are based on this direction. The Linux HDA subsystem takes
this information from a pin/complex configuration. But we don't have (and
don't need) such entities.

2. The stream configuration contains =E2=80=9Cfeatures=E2=80=9D that partia=
lly work as normal
virtio features, and partially do not. Maybe it is better to rename the fie=
ld
to =E2=80=9Cflags=E2=80=9D (as well as in the set_params request) and enter=
 two sets of flags:
one is reported in the stream configuration, and the other is used in the
set_params request? This should make things less confusing.

Message-based PCM transport:

1. In the latest version of the specification, we resized the =E2=80=9Cfeat=
ures=E2=80=9D field
in the stream configuration (u8->le32), but forgot to do the same in the
set_params request. This should be fixed.

2. The device may report polling support for message-based transport. In th=
is
case, the driver can be optimized so that it does not kick virtqueue for ea=
ch
message.

3. For the input stream (capture), we decided to report the actual filled s=
ize
using the len field in the virtqueue descriptor. Should the specification
clearly indicate that the value contains sizeof(struct virtio_snd_pcm_statu=
s)
+ the size of the recorded frames?

4. We also need to add a device requirement to complete all pending message=
s
for a stream on a RELEASE request. Otherwise, they may become stuck in the
virtqueue.

We are looking forward for your comments.


--=20
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

