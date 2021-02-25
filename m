Return-Path: virtio-dev-return-8041-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 578A2986184
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Feb 2021 18:53:37 +0000 (UTC)
Date: Thu, 25 Feb 2021 13:53:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20210225135229-mutt-send-email-mst@kernel.org>
References: <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
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
In-Reply-To: <be6713d3-ac98-bbbf-1dc1-a003ed06a156@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, elic@nvidia.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 25, 2021 at 12:36:07PM +0800, Jason Wang wrote:
>=20
> On 2021/2/24 7:12 =E4=B8=8B=E5=8D=88, Cornelia Huck wrote:
> > On Wed, 24 Feb 2021 17:29:07 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> >=20
> > > On 2021/2/23 6:58 =E4=B8=8B=E5=8D=88, Cornelia Huck wrote:
> > > > On Tue, 23 Feb 2021 18:31:07 +0800
> > > > Jason Wang <jasowang@redhat.com> wrote:
> > > > > On 2021/2/23 6:04 =E4=B8=8B=E5=8D=88, Cornelia Huck wrote:
> > > > > > On Tue, 23 Feb 2021 17:46:20 +0800
> > > > > > Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > On 2021/2/23 =E4=B8=8B=E5=8D=885:25, Michael S. Tsirkin wrote=
:
> > > > > > > > On Mon, Feb 22, 2021 at 09:09:28AM -0800, Si-Wei Liu wrote:
> > > > > > > > > On 2/21/2021 8:14 PM, Jason Wang wrote:
> > > > > > > > > > On 2021/2/19 7:54 =E4=B8=8B=E5=8D=88, Si-Wei Liu wrote:
> > > > > > > > > > > Commit 452639a64ad8 ("vdpa: make sure set_features is=
 invoked
> > > > > > > > > > > for legacy") made an exception for legacy guests to r=
eset
> > > > > > > > > > > features to 0, when config space is accessed before f=
eatures
> > > > > > > > > > > are set. We should relieve the verify_min_features() =
check
> > > > > > > > > > > and allow features reset to 0 for this case.
> > > > > > > > > > >=20
> > > > > > > > > > > It's worth noting that not just legacy guests could a=
ccess
> > > > > > > > > > > config space before features are set. For instance, w=
hen
> > > > > > > > > > > feature VIRTIO_NET_F_MTU is advertised some modern dr=
iver
> > > > > > > > > > > will try to access and validate the MTU present in th=
e config
> > > > > > > > > > > space before virtio features are set.
> > > > > > > > > > This looks like a spec violation:
> > > > > > > > > >=20
> > > > > > > > > > "
> > > > > > > > > >=20
> > > > > > > > > > The following driver-read-only field, mtu only exists i=
f
> > > > > > > > > > VIRTIO_NET_F_MTU is set. This field specifies the maxim=
um MTU for the
> > > > > > > > > > driver to use.
> > > > > > > > > > "
> > > > > > > > > >=20
> > > > > > > > > > Do we really want to workaround this?
> > > > > > > > > Isn't the commit 452639a64ad8 itself is a workaround for =
legacy guest?
> > > > > > > > >=20
> > > > > > > > > I think the point is, since there's legacy guest we'd hav=
e to support, this
> > > > > > > > > host side workaround is unavoidable. Although I agree the=
 violating driver
> > > > > > > > > should be fixed (yes, it's in today's upstream kernel whi=
ch exists for a
> > > > > > > > > while now).
> > > > > > > > Oh  you are right:
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > static int virtnet_validate(struct virtio_device *vdev)
> > > > > > > > {
> > > > > > > >             if (!vdev->config->get) {
> > > > > > > >                     dev_err(&vdev->dev, "%s failure: config=
 access disabled\n",
> > > > > > > >                             __func__);
> > > > > > > >                     return -EINVAL;
> > > > > > > >             }
> > > > > > > >=20
> > > > > > > >             if (!virtnet_validate_features(vdev))
> > > > > > > >                     return -EINVAL;
> > > > > > > >=20
> > > > > > > >             if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU))=
 {
> > > > > > > >                     int mtu =3D virtio_cread16(vdev,
> > > > > > > >                                              offsetof(struc=
t virtio_net_config,
> > > > > > > >                                                       mtu))=
;
> > > > > > > >                     if (mtu < MIN_MTU)
> > > > > > > >                             __virtio_clear_bit(vdev, VIRTIO=
_NET_F_MTU);
> > > > > > > I wonder why not simply fail here?
> > > > > > I think both failing or not accepting the feature can be argued=
 to make
> > > > > > sense: "the device presented us with a mtu size that does not m=
ake
> > > > > > sense" would point to failing, "we cannot work with the mtu siz=
e that
> > > > > > the device presented us" would point to not negotiating the fea=
ture.
> > > > > > > >             }
> > > > > > > >=20
> > > > > > > >             return 0;
> > > > > > > > }
> > > > > > > >=20
> > > > > > > > And the spec says:
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > The driver MUST follow this sequence to initialize a device=
:
> > > > > > > > 1. Reset the device.
> > > > > > > > 2. Set the ACKNOWLEDGE status bit: the guest OS has noticed=
 the device.
> > > > > > > > 3. Set the DRIVER status bit: the guest OS knows how to dri=
ve the device.
> > > > > > > > 4. Read device feature bits, and write the subset of featur=
e bits understood by the OS and driver to the
> > > > > > > > device. During this step the driver MAY read (but MUST NOT =
write) the device-specific configuration
> > > > > > > > fields to check that it can support the device before accep=
ting it.
> > > > > > > > 5. Set the FEATURES_OK status bit. The driver MUST NOT acce=
pt new feature bits after this step.
> > > > > > > > 6. Re-read device status to ensure the FEATURES_OK bit is s=
till set: otherwise, the device does not
> > > > > > > > support our subset of features and the device is unusable.
> > > > > > > > 7. Perform device-specific setup, including discovery of vi=
rtqueues for the device, optional per-bus setup,
> > > > > > > > reading and possibly writing the device=E2=80=99s virtio co=
nfiguration space, and population of virtqueues.
> > > > > > > > 8. Set the DRIVER_OK status bit. At this point the device i=
s =E2=80=9Clive=E2=80=9D.
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Item 4 on the list explicitly allows reading config space b=
efore
> > > > > > > > FEATURES_OK.
> > > > > > > >=20
> > > > > > > > I conclude that VIRTIO_NET_F_MTU is set means "set in devic=
e features".
> > > > > > > So this probably need some clarification. "is set" is used ma=
ny times in
> > > > > > > the spec that has different implications.
> > > > > > Before FEATURES_OK is set by the driver, I guess it means "the =
device
> > > > > > has offered the feature";
> > > > > For me this part is ok since it clarify that it's the driver that=
 set
> > > > > the bit.
> > > > >=20
> > > > >=20
> > > > > > during normal usage, it means "the feature
> > > > > > has been negotiated".
> > > > > /?
> > > > >=20
> > > > > It looks to me the feature negotiation is done only after device =
set
> > > > > FEATURES_OK, or FEATURES_OK could be read from device status?
> > > > I'd consider feature negotiation done when the driver reads FEATURE=
S_OK
> > > > back from the status.
> > >=20
> > > I agree.
> > >=20
> > >=20
> > > > > >     (This is a bit fuzzy for legacy mode.)
> > > > ...because legacy does not have FEATURES_OK.
> > > > > The problem is the MTU description for example:
> > > > >=20
> > > > > "The following driver-read-only field, mtu only exists if
> > > > > VIRTIO_NET_F_MTU is set."
> > > > >=20
> > > > > It looks to me need to use "if VIRTIO_NET_F_MTU is set by device"=
.
> > > > "offered by the device"? I don't think it should 'disappear' from t=
he
> > > > config space if the driver won't use it. (Same for other config spa=
ce
> > > > fields that are tied to feature bits.)
> > >=20
> > > But what happens if e.g device doesn't offer VIRTIO_NET_F_MTU? It loo=
ks
> > > to according to the spec there will be no mtu field.
> > I think so, yes.
> >=20
> > > And a more interesting case is VIRTIO_NET_F_MQ is not offered but
> > > VIRTIO_NET_F_MTU offered. To me, it means we don't have
> > > max_virtqueue_pairs but it's not how the driver is wrote today.
> > That would be a bug, but it seems to me that the virtio-net driver
> > reads max_virtqueue_pairs conditionally and handles absence of the
> > feature correctly?
>=20
>=20
> Yes, see the avove codes:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (virtio_has_feature(vdev, V=
IRTIO_NET_F_MTU)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int mtu =3D virtio_cread16(vdev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 offsetof(struct virtio_net_config,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mt=
u));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (mtu < MIN_MTU)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __virtio=
_clear_bit(vdev, VIRTIO_NET_F_MTU);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> So it's probably too late to fix the driver.
>=20

Confused. What is wrong with the above? It never reads the
field unless the feature has been offered by device.


> >=20
> > >=20
> > > > > Otherwise readers (at least for me), may think the MTU is only va=
lid
> > > > > if driver set the bit.
> > > > I think it would still be 'valid' in the sense that it exists and h=
as
> > > > some value in there filled in by the device, but a driver reading i=
t
> > > > without negotiating the feature would be buggy. (Like in the kernel
> > > > code above; the kernel not liking the value does not make the field
> > > > invalid.)
> > >=20
> > > See Michael's reply, the spec allows read the config before setting
> > > features.
> > Yes, the period prior to finishing negotiation is obviously special.
> >=20
> > >=20
> > > > Maybe a statement covering everything would be:
> > > >=20
> > > > "The following driver-read-only field mtu only exists if the device
> > > > offers VIRTIO_NET_F_MTU and may be read by the driver during featur=
e
> > > > negotiation and after VIRTIO_NET_F_MTU has been successfully
> > > > negotiated."
> > > > > > Should we add a wording clarification to the spec?
> > > > > I think so.
> > > > Some clarification would be needed for each field that depends on a
> > > > feature; that would be quite verbose. Maybe we can get away with a
> > > > clarifying statement?
> > > >=20
> > > > "Some config space fields may depend on a certain feature. In that
> > > > case, the field exits if the device has offered the corresponding
> > > > feature,
> > >=20
> > > So this implies for !VIRTIO_NET_F_MQ && VIRTIO_NET_F_MTU, the config
> > > will look like:
> > >=20
> > > struct virtio_net_config {
> > >   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 mac[6];
> > >   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 status;
> > >   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 mtu;
> > > };
> > >=20
> > I agree.
>=20
>=20
> So consider it's probably too late to fix the driver which assumes some
> field are always persent, it looks to me need fix the spec do declare the
> fields are always existing instead.
>=20
>=20
> >=20
> > > >    and may be read by the driver during feature negotiation, and
> > > > accessed by the driver after the feature has been successfully
> > > > negotiated. A shorthand for this is a statement that a field only
> > > > exists if a certain feature bit is set."
> > >=20
> > > I'm not sure using "shorthand" is good for the spec, at least we can
> > > limit the its scope only to the configuration space part.
> > Maybe "a shorthand expression"?
>=20
>=20
> So the questions is should we use this for all over the spec or it will b=
e
> only used in this speicifc part (device configuration).
>=20
> Thanks
>=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

