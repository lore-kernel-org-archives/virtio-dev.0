Return-Path: virtio-dev-return-7917-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D280985D76
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Jan 2021 14:01:46 +0000 (UTC)
Date: Mon, 11 Jan 2021 15:01:36 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20210111140136.5vylazemyu4mw56x@sirius.home.kraxel.org>
References: <20200330163413.975345-1-anton.yakovlev@opensynergy.com>
 <ceb22f05-67d5-e897-e31f-e07623a1e758@opensynergy.com>
 <3a0796c-86-2a97-35de-6f7b7f7b3a29@intel.com>
MIME-Version: 1.0
In-Reply-To: <3a0796c-86-2a97-35de-6f7b7f7b3a29@intel.com>
Subject: Re: [virtio-dev] Re: [PATCH v8] virtio-snd: add virtio sound device
 specification
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>, virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org, Shreyansh Chouhan <chouhan.shreyansh2702@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jan 08, 2021 at 02:56:31PM +0100, Guennadi Liakhovetski wrote:
> Hi Anton,
> 
> I see the standard has been merged into the VirtIO spec - congratulations! I
> also saw, that there was a GSOC project for VirtIO sound support in QEMU.

No one looked at qemu support in gsoc 2020.
A few days ago Shreyansh Chouhan (added to Cc:) indicated he wants work
on this (outside gsoc).  Some early discussions are @ qemu-devel right
now.

While being at it: what is the linux guest driver status?  Seems to not
be merged upstream yet ...

take care,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

