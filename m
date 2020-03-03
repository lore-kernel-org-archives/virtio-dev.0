Return-Path: virtio-dev-return-6881-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C012E985F10
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Mar 2020 14:52:56 +0000 (UTC)
Date: Tue, 3 Mar 2020 15:52:49 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200303145249.wix2y6eoddpmwnei@sirius.home.kraxel.org>
References: <20200302152429.1666557-1-Anton.Yakovlev@opensynergy.com>
 <20200303112053.xuskcdi4747rnzcd@sirius.home.kraxel.org>
 <54b98087-36c8-b595-49f9-26cb6fdbd9bb@opensynergy.com>
 <20200303121005.mmcjlwuu7v7vvyqm@sirius.home.kraxel.org>
 <abfad80f-4e7d-bb58-1fbd-513f30ca3c2a@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <abfad80f-4e7d-bb58-1fbd-513f30ca3c2a@opensynergy.com>
Subject: Re: [virtio-dev] Re: [PATCH v6] virtio-snd: add virtio sound device
 specification
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Mar 03, 2020 at 01:27:38PM +0100, Anton Yakovlev wrote:
> On 03.03.2020 13:10, Gerd Hoffmann wrote:
> > On Tue, Mar 03, 2020 at 12:28:32PM +0100, Anton Yakovlev wrote:
> > > Hi,
> > >=20
> > > On 03.03.2020 12:20, Gerd Hoffmann wrote:
> > > >     Hi,
> > > >=20
> > > > > 4. Introduce the polling mode feature for a message-based transpo=
rt.
> > > >=20
> > > > BTW: is that driver -> device or device -> driver or both?
> > > > In case both: should we have two separate feature flags maybe?
> > >=20
> > > It's driver -> device direction. The driver needs notifications from =
the
> > > device in any case, so it makes no sense to suppress notifications in=
 this
> > > direction (device -> driver).
> >=20
> > Hmm, unless I missed something it doesn't matter whenever the guest
> > kernel checks virtqueues from irq handler or timer ...
>=20
> Because in the general case, it is impossible to predict when a notificat=
ion
> will come from the device. Even if we are talking about a period time, th=
is
> does not mean that the device will send notifications precisely at these
> intervals. And this means that the driver must do a tricky poll, trying
> to guess when the notification will arrive, i.e. just waste CPU resources=
.

Well, the simplest way to handle this would be that each time the driver
submits a buffer to the device it also checks whenever the device has
completed buffers.  No irq, no timer -> no extra wakeups to collect
completed buffers.

Drawback is that completed buffers might be unnoticed for a while then
due to jitter, the driver might see sometimes no buffers and sometimes
multiple buffers.  For latency-sensitive workloads this will probably
not work very well.

So, not sure whenever it makes sense to have that as an option or
whenever guest drivers would just use notifications unconditionally
anyway.

But in any case we should clarify in the spec that this means the driver
doesn't notify and the device polls.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

