Return-Path: virtio-dev-return-8026-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 11A95986027
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Feb 2021 10:58:58 +0000 (UTC)
Date: Tue, 23 Feb 2021 11:58:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20210223115833.732d809c.cohuck@redhat.com>
In-Reply-To: <bbb0a09e-17e1-a397-1b64-6ce9afe18e44@redhat.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
	<605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
	<ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
	<20210223041740-mutt-send-email-mst@kernel.org>
	<788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
	<20210223110430.2f098bc0.cohuck@redhat.com>
	<bbb0a09e-17e1-a397-1b64-6ce9afe18e44@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, elic@nvidia.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 23 Feb 2021 18:31:07 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On 2021/2/23 6:04 =E4=B8=8B=E5=8D=88, Cornelia Huck wrote:
> > On Tue, 23 Feb 2021 17:46:20 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> > =20
> >> On 2021/2/23 =E4=B8=8B=E5=8D=885:25, Michael S. Tsirkin wrote: =20
> >>> On Mon, Feb 22, 2021 at 09:09:28AM -0800, Si-Wei Liu wrote: =20
> >>>> On 2/21/2021 8:14 PM, Jason Wang wrote: =20
> >>>>> On 2021/2/19 7:54 =E4=B8=8B=E5=8D=88, Si-Wei Liu wrote: =20
> >>>>>> Commit 452639a64ad8 ("vdpa: make sure set_features is invoked
> >>>>>> for legacy") made an exception for legacy guests to reset
> >>>>>> features to 0, when config space is accessed before features
> >>>>>> are set. We should relieve the verify_min_features() check
> >>>>>> and allow features reset to 0 for this case.
> >>>>>>
> >>>>>> It's worth noting that not just legacy guests could access
> >>>>>> config space before features are set. For instance, when
> >>>>>> feature VIRTIO_NET_F_MTU is advertised some modern driver
> >>>>>> will try to access and validate the MTU present in the config
> >>>>>> space before virtio features are set. =20
> >>>>> This looks like a spec violation:
> >>>>>
> >>>>> "
> >>>>>
> >>>>> The following driver-read-only field, mtu only exists if
> >>>>> VIRTIO_NET_F_MTU is set. This field specifies the maximum MTU for t=
he
> >>>>> driver to use.
> >>>>> "
> >>>>>
> >>>>> Do we really want to workaround this? =20
> >>>> Isn't the commit 452639a64ad8 itself is a workaround for legacy gues=
t?
> >>>>
> >>>> I think the point is, since there's legacy guest we'd have to suppor=
t, this
> >>>> host side workaround is unavoidable. Although I agree the violating =
driver
> >>>> should be fixed (yes, it's in today's upstream kernel which exists f=
or a
> >>>> while now). =20
> >>> Oh  you are right:
> >>>
> >>>
> >>> static int virtnet_validate(struct virtio_device *vdev)
> >>> {
> >>>           if (!vdev->config->get) {
> >>>                   dev_err(&vdev->dev, "%s failure: config access disa=
bled\n",
> >>>                           __func__);
> >>>                   return -EINVAL;
> >>>           }
> >>>
> >>>           if (!virtnet_validate_features(vdev))
> >>>                   return -EINVAL;
> >>>
> >>>           if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU)) {
> >>>                   int mtu =3D virtio_cread16(vdev,
> >>>                                            offsetof(struct virtio_net=
_config,
> >>>                                                     mtu));
> >>>                   if (mtu < MIN_MTU)
> >>>                           __virtio_clear_bit(vdev, VIRTIO_NET_F_MTU);=
 =20
> >>
> >> I wonder why not simply fail here? =20
> > I think both failing or not accepting the feature can be argued to make
> > sense: "the device presented us with a mtu size that does not make
> > sense" would point to failing, "we cannot work with the mtu size that
> > the device presented us" would point to not negotiating the feature.
> > =20
> >> =20
> >>>           }
> >>>
> >>>           return 0;
> >>> }
> >>>
> >>> And the spec says:
> >>>
> >>>
> >>> The driver MUST follow this sequence to initialize a device:
> >>> 1. Reset the device.
> >>> 2. Set the ACKNOWLEDGE status bit: the guest OS has noticed the devic=
e.
> >>> 3. Set the DRIVER status bit: the guest OS knows how to drive the dev=
ice.
> >>> 4. Read device feature bits, and write the subset of feature bits und=
erstood by the OS and driver to the
> >>> device. During this step the driver MAY read (but MUST NOT write) the=
 device-specific configuration
> >>> fields to check that it can support the device before accepting it.
> >>> 5. Set the FEATURES_OK status bit. The driver MUST NOT accept new fea=
ture bits after this step.
> >>> 6. Re-read device status to ensure the FEATURES_OK bit is still set: =
otherwise, the device does not
> >>> support our subset of features and the device is unusable.
> >>> 7. Perform device-specific setup, including discovery of virtqueues f=
or the device, optional per-bus setup,
> >>> reading and possibly writing the device=E2=80=99s virtio configuratio=
n space, and population of virtqueues.
> >>> 8. Set the DRIVER_OK status bit. At this point the device is =E2=80=
=9Clive=E2=80=9D.
> >>>
> >>>
> >>> Item 4 on the list explicitly allows reading config space before
> >>> FEATURES_OK.
> >>>
> >>> I conclude that VIRTIO_NET_F_MTU is set means "set in device features=
". =20
> >>
> >> So this probably need some clarification. "is set" is used many times =
in
> >> the spec that has different implications. =20
> > Before FEATURES_OK is set by the driver, I guess it means "the device
> > has offered the feature"; =20
>=20
>=20
> For me this part is ok since it clarify that it's the driver that set=20
> the bit.
>=20
>=20
>=20
> > during normal usage, it means "the feature
> > has been negotiated". =20
>=20
> /?
>=20
> It looks to me the feature negotiation is done only after device set=20
> FEATURES_OK, or FEATURES_OK could be read from device status?

I'd consider feature negotiation done when the driver reads FEATURES_OK
back from the status.

>=20
>=20
> >   (This is a bit fuzzy for legacy mode.)

...because legacy does not have FEATURES_OK.
 =20
>=20
>=20
> The problem is the MTU description for example:
>=20
> "The following driver-read-only field, mtu only exists if=20
> VIRTIO_NET_F_MTU is set."
>=20
> It looks to me need to use "if VIRTIO_NET_F_MTU is set by device".

"offered by the device"? I don't think it should 'disappear' from the
config space if the driver won't use it. (Same for other config space
fields that are tied to feature bits.)
=20
> Otherwise readers (at least for me), may think the MTU is only valid
> if driver set the bit.

I think it would still be 'valid' in the sense that it exists and has
some value in there filled in by the device, but a driver reading it
without negotiating the feature would be buggy. (Like in the kernel
code above; the kernel not liking the value does not make the field
invalid.)

Maybe a statement covering everything would be:

"The following driver-read-only field mtu only exists if the device
offers VIRTIO_NET_F_MTU and may be read by the driver during feature
negotiation and after VIRTIO_NET_F_MTU has been successfully
negotiated."

>=20
>=20
> >
> > Should we add a wording clarification to the spec? =20
>=20
>=20
> I think so.

Some clarification would be needed for each field that depends on a
feature; that would be quite verbose. Maybe we can get away with a
clarifying statement?

"Some config space fields may depend on a certain feature. In that
case, the field exits if the device has offered the corresponding
feature, and may be read by the driver during feature negotiation, and
accessed by the driver after the feature has been successfully
negotiated. A shorthand for this is a statement that a field only
exists if a certain feature bit is set."


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

