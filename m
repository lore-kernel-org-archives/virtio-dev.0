Return-Path: virtio-dev-return-6951-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BAACF984319
	for <virtio-dev@lists.oasis-open.org>; Mon, 16 Mar 2020 10:20:02 +0000 (UTC)
Date: Mon, 16 Mar 2020 11:19:54 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200316101954.2zlmrxm6el6hzdjz@sirius.home.kraxel.org>
References: <20200311140432.433238-1-Anton.Yakovlev@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <20200311140432.433238-1-Anton.Yakovlev@opensynergy.com>
Subject: [virtio-dev] Re: [PATCH v7] virtio-snd: add virtio sound device specification
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> 2. Rework jack configuration structure, now it's more aligned with the HD=
A spec.

Yep, that looks good.

> +\item[\field{hda_fn_nid}] indicates a functional node identifier
> +(see \hyperref[intro:HDA]{HDA}, section 7.1.2).

How is the nid used?

In general some of the defconf and caps fields might need some
clarification if and how they are used, given we just cherry-pick
some items from the HDA spec ...

> +\item[\field{hda_reg_caps}] indicates a pin capabilities value
> +(see \hyperref[intro:HDA]{HDA}, section 7.3.4.9).

... for example:

If the "Presence Detect Capable" bit is set the status is available in
the "connected" field.

"VRef Control" is not supported and must be zero.

> +\item[\field{connected}] indicates the current jack connection status
> +(1 - connected, 0 - disconnected).

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

