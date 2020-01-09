Return-Path: virtio-dev-return-6635-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1934C985E3F
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Jan 2020 14:01:26 +0000 (UTC)
Date: Thu, 9 Jan 2020 15:01:17 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200109140117.cr7mpsldq7x3p2rd@sirius.home.kraxel.org>
References: <20200107125049.99728-1-Anton.Yakovlev@opensynergy.com>
 <20200108103447.geh6qb4hay6konft@sirius.home.kraxel.org>
 <c103cd0b-07c9-bff7-83e0-f2897e28c613@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <c103cd0b-07c9-bff7-83e0-f2897e28c613@opensynergy.com>
Subject: [virtio-dev] Re: [PATCH v4] virtio-snd: add virtio sound device specification
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > Repeating "device-readable" or "device-writable" for each struct field
> > looks a bit odd because this applies to the whole struct.  Not so much
> > for these structs with a single field only, but there are structs with
> > more fields further down the spec ...
>=20
> Well, I'm not sure here. Previously, I was told to mark explicitly every
> field.

Was that for virtqueue structs, or for config space?

For config space which allows random access it surely makes sense.  In
contrast the virtqueue has in and out buffers, so you requests structs
are placed in "out" buffers and are device-readable. whereas response
structs are placed in "in" buffers and are device-writable.

> Also, regarding requirement for populating tx/rx queues with period size
> buffers. Maybe it's better to replace MUST with SHOULD? It would give mor=
e
> flexibility for the driver. What do you think?

I think relaxing this to SHOULD is fine.  I can't think of any bad side
effects of that.   The driver obviously can't use the buffer completion
as period notification then.  But that is the driver's choice and it
wouldn't break the virtio protocol ...

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

