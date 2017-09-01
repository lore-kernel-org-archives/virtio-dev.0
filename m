Return-Path: virtio-dev-return-2508-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A9B3D5818F6A
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Sep 2017 10:45:17 -0700 (PDT)
Date: Fri, 1 Sep 2017 20:45:11 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170901204222-mutt-send-email-mst@kernel.org>
References: <1504199044.22080.11.camel@arista.com>
 <20170901183517-mutt-send-email-mst@kernel.org>
 <1504282793.12952.17.camel@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1504282793.12952.17.camel@arista.com>
Subject: [virtio-dev] Re: virtio_net: ethtool supported link modes
To: Radu Rendec <rrendec@arista.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Sep 01, 2017 at 05:19:53PM +0100, Radu Rendec wrote:
> On Fri, 2017-09-01 at 18:43 +0300, Michael S. Tsirkin wrote:
> > On Thu, Aug 31, 2017 at 06:04:04PM +0100, Radu Rendec wrote:
> > > Looking at the code in virtnet_set_link_ksettings, it seems the speed
> > > and duplex can be set to any valid value. The driver will "remember"
> > > them and report them back in virtnet_get_link_ksettings.
> > >=20
> > > However, the supported link modes (link_modes.supported in struct
> > > ethtool_link_ksettings) is always 0, indicating that no speed/duplex
> > > setting is supported.
> > >=20
> > > Does it make more sense to set (at least a few of) the supported link
> > > modes, such as 10baseT_Half ... 10000baseT_Full?
> > >=20
> > > I would expect to see consistency between what is reported in
> > > link_modes.supported and what can actually be set. Could you please
> > > share your opinion on this?
> >=20
> > I would like to know more about why this is desirable.
> >=20
> > We used not to support the modes at all, but it turned out
> > some tools are confused by this: e.g. people would try to
> > bond virtio with a hardware device, tools would see
> > a mismatch in speed and features between bonded devices
> > and get confused.
> >=20
> > See
> >=20
> > 	commit 16032be56c1f66770da15cb94f0eb366c37aff6e
> > 	Author: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> > 	Date:=A0=A0=A0Wed Feb 3 04:04:37 2016 +0100
> >=20
> > 	=A0=A0=A0=A0virtio_net: add ethtool support for set and get of settings
> >=20
> >=20
> > as well as the discussion around it
> > 	https://www.spinics.net/lists/netdev/msg362111.html
>=20
> Thanks for pointing these out. It is much more clear now why modes
> support is implemented the way it is and what the expectations are.
>=20
> > If you think we need to add more hacks like this, a stronger
> > motivation than "to see consistency" would be needed.
>=20
> The use case behind my original question is very simple:
>  * Net device is queried via ethtool for supported modes.
>  * Supported modes are presented to user.
>  * User can configure any of the supported modes.

Since this has no effect on virtio, isn't presenting
"no supported modes" to user the right thing to do?

> This is done transparently to the net device type (driver), so it
> actually makes sense for physical NICs.
>=20
> This alone of course is not a good enough motivation to modify the
> driver. And it can be easily addressed in user-space at the application
> level by testing for the driver.

I think you might want to special-case no supported modes.
Special-casing virtio is probably best avoided.

> I was merely trying to avoid driver-specific workarounds (i.e. keep the
> application driver agnostic)

I think that's the right approach. So if driver does not present
any supported modes this probably means it is not necessary
to display or program any.

> and wondered if "advertising" supported
> modes through ethtool made any sense and/or would be a desirable change
> from the driver perspective. I believe I have my answers now.
>=20
> Thanks,
> Radu

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

