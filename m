Return-Path: virtio-dev-return-6957-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B3A4985CE6
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 Mar 2020 09:15:42 +0000 (UTC)
Date: Tue, 17 Mar 2020 10:15:33 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200317091533.biyhxvpjrbqgdxds@sirius.home.kraxel.org>
References: <20200311140432.433238-1-Anton.Yakovlev@opensynergy.com>
 <20200316101954.2zlmrxm6el6hzdjz@sirius.home.kraxel.org>
 <769eea1f-9ef6-94ae-b265-5dd62503b7c3@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <769eea1f-9ef6-94ae-b265-5dd62503b7c3@opensynergy.com>
Subject: Re: [virtio-dev] Re: [PATCH v7] virtio-snd: add virtio sound device
 specification
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Mar 16, 2020 at 09:30:59PM +0100, Anton Yakovlev wrote:
> Hi,
>=20
> On 16.03.2020 11:19, Gerd Hoffmann wrote:
> >    Hi,
> >=20
> > > 2. Rework jack configuration structure, now it's more aligned with th=
e HDA spec.
> >=20
> > Yep, that looks good.
> >=20
> > > +\item[\field{hda_fn_nid}] indicates a functional node identifier
> > > +(see \hyperref[intro:HDA]{HDA}, section 7.1.2).
> >=20
> > How is the nid used?
>=20
> Since a functional group in HDA links entities of different kinds
> together, as an example, the linux driver can provide different groups
> as different PCM devices (and this well aligns with hardware case when
> streams with different capabilities live in different groups). This may
> be necessary to reassign the jack, because you need to know which
> streams are attached to the jacks. In addition, it will allow you to
> associate device controls with the stream/PCM device.

Ah, there is virtio_snd_pcm_config.hda_fn_nid.  So this is how jacks are
associated with streams.  Havn't noticed this update before.

> > In general some of the defconf and caps fields might need some
> > clarification if and how they are used, given we just cherry-pick
> > some items from the HDA spec ...
>=20
> Yes, I also thought about it. But will this lead to a direct dependence
> on the HDA specification? If something changes there, we should update
> here. Therefore, I left these elements transparent and allowed the
> device/driver to decide on the wise use of these fields.

I'm mostly thinking about virtio-sound specific stuff which obviously
isn't covered by the HDA spec, like this:

> > If the "Presence Detect Capable" bit is set the status is available in
> > the "connected" field.

Most fields don't need a comment in virtio-sound, things like the jack
color should be pretty clear without that.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

