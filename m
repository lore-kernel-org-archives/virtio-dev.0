Return-Path: virtio-dev-return-8039-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 254F5986174
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Feb 2021 13:26:43 +0000 (UTC)
Date: Thu, 25 Feb 2021 14:26:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20210225142628.3659af58.cohuck@redhat.com>
In-Reply-To: <be6713d3-ac98-bbbf-1dc1-a003ed06a156@redhat.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
	<605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
	<ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
	<20210223041740-mutt-send-email-mst@kernel.org>
	<788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
	<20210223110430.2f098bc0.cohuck@redhat.com>
	<bbb0a09e-17e1-a397-1b64-6ce9afe18e44@redhat.com>
	<20210223115833.732d809c.cohuck@redhat.com>
	<8355f9b3-4cda-cd2e-98df-fed020193008@redhat.com>
	<20210224121234.0127ae4b.cohuck@redhat.com>
	<be6713d3-ac98-bbbf-1dc1-a003ed06a156@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, elic@nvidia.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 25 Feb 2021 12:36:07 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On 2021/2/24 7:12 =E4=B8=8B=E5=8D=88, Cornelia Huck wrote:
> > On Wed, 24 Feb 2021 17:29:07 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> > =20
> >> On 2021/2/23 6:58 =E4=B8=8B=E5=8D=88, Cornelia Huck wrote: =20
> >>> On Tue, 23 Feb 2021 18:31:07 +0800
> >>> Jason Wang <jasowang@redhat.com> wrote:

> >>>> The problem is the MTU description for example:
> >>>>
> >>>> "The following driver-read-only field, mtu only exists if
> >>>> VIRTIO_NET_F_MTU is set."
> >>>>
> >>>> It looks to me need to use "if VIRTIO_NET_F_MTU is set by device". =
=20
> >>> "offered by the device"? I don't think it should 'disappear' from the
> >>> config space if the driver won't use it. (Same for other config space
> >>> fields that are tied to feature bits.) =20
> >>
> >> But what happens if e.g device doesn't offer VIRTIO_NET_F_MTU? It look=
s
> >> to according to the spec there will be no mtu field. =20
> > I think so, yes.
> > =20
> >> And a more interesting case is VIRTIO_NET_F_MQ is not offered but
> >> VIRTIO_NET_F_MTU offered. To me, it means we don't have
> >> max_virtqueue_pairs but it's not how the driver is wrote today. =20
> > That would be a bug, but it seems to me that the virtio-net driver
> > reads max_virtqueue_pairs conditionally and handles absence of the
> > feature correctly? =20
>=20
>=20
> Yes, see the avove codes:
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (virtio_has_feature(vdev, =
VIRTIO_NET_F_MTU)) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int mtu =3D virtio_cread16(vdev,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 offsetof(struct virtio_net_config,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mt=
u));
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (mtu < MIN_MTU)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __virtio=
_clear_bit(vdev, VIRTIO_NET_F_MTU);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20

Ouch, you're right. The virtio_cread accessors all operate on offsets
into a structure, it's just more obvious here.

> So it's probably too late to fix the driver.

It is never too late to fix a driver :)

It seems involved, though. We'd need different config space structures
based upon which set of features has been negotiated. It's not too bad
when features build upon each other and add fields at the end (this
should be fine right now, if the code remembered to check for the
feature), but can become ugly if an in-between field depends upon a
feature.

I guess we've been lucky that it seems to be an extremely uncommon
configuration.

>=20
>=20
> > =20
> >> =20
> >>>       =20
> >>>> Otherwise readers (at least for me), may think the MTU is only valid
> >>>> if driver set the bit. =20
> >>> I think it would still be 'valid' in the sense that it exists and has
> >>> some value in there filled in by the device, but a driver reading it
> >>> without negotiating the feature would be buggy. (Like in the kernel
> >>> code above; the kernel not liking the value does not make the field
> >>> invalid.) =20
> >>
> >> See Michael's reply, the spec allows read the config before setting
> >> features. =20
> > Yes, the period prior to finishing negotiation is obviously special.
> > =20
> >> =20
> >>> Maybe a statement covering everything would be:
> >>>
> >>> "The following driver-read-only field mtu only exists if the device
> >>> offers VIRTIO_NET_F_MTU and may be read by the driver during feature
> >>> negotiation and after VIRTIO_NET_F_MTU has been successfully
> >>> negotiated."
> >>>    =20
> >>>>    =20
> >>>>> Should we add a wording clarification to the spec? =20
> >>>> I think so. =20
> >>> Some clarification would be needed for each field that depends on a
> >>> feature; that would be quite verbose. Maybe we can get away with a
> >>> clarifying statement?
> >>>
> >>> "Some config space fields may depend on a certain feature. In that
> >>> case, the field exits if the device has offered the corresponding
> >>> feature, =20
> >>
> >> So this implies for !VIRTIO_NET_F_MQ && VIRTIO_NET_F_MTU, the config
> >> will look like:
> >>
> >> struct virtio_net_config {
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 mac[6];
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 status;
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 mtu;
> >> };
> >> =20
> > I agree. =20
>=20
>=20
> So consider it's probably too late to fix the driver which assumes some=
=20
> field are always persent, it looks to me need fix the spec do declare=20
> the fields are always existing instead.

The problem with that is that it has been in the spec already, and a
compliant device that did not provide the fields without the features
would suddenly become non-compliant...

>=20
>=20
> > =20
> >>>    and may be read by the driver during feature negotiation, and
> >>> accessed by the driver after the feature has been successfully
> >>> negotiated. A shorthand for this is a statement that a field only
> >>> exists if a certain feature bit is set." =20
> >>
> >> I'm not sure using "shorthand" is good for the spec, at least we can
> >> limit the its scope only to the configuration space part. =20
> > Maybe "a shorthand expression"? =20
>=20
>=20
> So the questions is should we use this for all over the spec or it will=
=20
> be only used in this speicifc part (device configuration).

For command structures and the like, "feature is set" should always
mean "feature has been negotiated"; I think config space is special
because the driver can read it before feature negotiation is finished,
so device configuration is probably the proper place for it.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

