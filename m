Return-Path: virtio-dev-return-8020-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 52188986020
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Feb 2021 09:25:13 +0000 (UTC)
Date: Tue, 23 Feb 2021 04:25:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20210223041740-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
MIME-Version: 1.0
In-Reply-To: <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
Subject: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Jason Wang <jasowang@redhat.com>, elic@nvidia.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 22, 2021 at 09:09:28AM -0800, Si-Wei Liu wrote:
>=20
>=20
> On 2/21/2021 8:14 PM, Jason Wang wrote:
> >=20
> > On 2021/2/19 7:54 =E4=B8=8B=E5=8D=88, Si-Wei Liu wrote:
> > > Commit 452639a64ad8 ("vdpa: make sure set_features is invoked
> > > for legacy") made an exception for legacy guests to reset
> > > features to 0, when config space is accessed before features
> > > are set. We should relieve the verify_min_features() check
> > > and allow features reset to 0 for this case.
> > >=20
> > > It's worth noting that not just legacy guests could access
> > > config space before features are set. For instance, when
> > > feature VIRTIO_NET_F_MTU is advertised some modern driver
> > > will try to access and validate the MTU present in the config
> > > space before virtio features are set.
> >=20
> >=20
> > This looks like a spec violation:
> >=20
> > "
> >=20
> > The following driver-read-only field, mtu only exists if
> > VIRTIO_NET_F_MTU is set. This field specifies the maximum MTU for the
> > driver to use.
> > "
> >=20
> > Do we really want to workaround this?
>=20
> Isn't the commit 452639a64ad8 itself is a workaround for legacy guest?
>=20
> I think the point is, since there's legacy guest we'd have to support, th=
is
> host side workaround is unavoidable. Although I agree the violating drive=
r
> should be fixed (yes, it's in today's upstream kernel which exists for a
> while now).

Oh  you are right:


static int virtnet_validate(struct virtio_device *vdev)
{
        if (!vdev->config->get) {
                dev_err(&vdev->dev, "%s failure: config access disabled\n",
                        __func__);
                return -EINVAL;
        }

        if (!virtnet_validate_features(vdev))
                return -EINVAL;

        if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU)) {
                int mtu =3D virtio_cread16(vdev,
                                         offsetof(struct virtio_net_config,
                                                  mtu));
                if (mtu < MIN_MTU)
                        __virtio_clear_bit(vdev, VIRTIO_NET_F_MTU);
        }

        return 0;
}

And the spec says:


The driver MUST follow this sequence to initialize a device:
1. Reset the device.
2. Set the ACKNOWLEDGE status bit: the guest OS has noticed the device.
3. Set the DRIVER status bit: the guest OS knows how to drive the device.
4. Read device feature bits, and write the subset of feature bits understoo=
d by the OS and driver to the
device. During this step the driver MAY read (but MUST NOT write) the devic=
e-specific configuration
fields to check that it can support the device before accepting it.
5. Set the FEATURES_OK status bit. The driver MUST NOT accept new feature b=
its after this step.
6. Re-read device status to ensure the FEATURES_OK bit is still set: otherw=
ise, the device does not
support our subset of features and the device is unusable.
7. Perform device-specific setup, including discovery of virtqueues for the=
 device, optional per-bus setup,
reading and possibly writing the device=E2=80=99s virtio configuration spac=
e, and population of virtqueues.
8. Set the DRIVER_OK status bit. At this point the device is =E2=80=9Clive=
=E2=80=9D.


Item 4 on the list explicitly allows reading config space before
FEATURES_OK.

I conclude that VIRTIO_NET_F_MTU is set means "set in device features".

Generally it is worth going over feature dependent config fields
and checking whether they should be present when device feature is set
or when feature bit has been negotiated, and making this clear.

--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

