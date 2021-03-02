Return-Path: virtio-dev-return-8081-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0CA7C98638D
	for <virtio-dev@lists.oasis-open.org>; Tue,  2 Mar 2021 12:08:28 +0000 (UTC)
Date: Tue, 2 Mar 2021 13:08:12 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20210302130812.6227f176.cohuck@redhat.com>
In-Reply-To: <cdd72199-ac7b-cc8d-2c40-81e43162c532@redhat.com>
References: <20210223041740-mutt-send-email-mst@kernel.org>
	<788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
	<20210223110430.2f098bc0.cohuck@redhat.com>
	<bbb0a09e-17e1-a397-1b64-6ce9afe18e44@redhat.com>
	<20210223115833.732d809c.cohuck@redhat.com>
	<8355f9b3-4cda-cd2e-98df-fed020193008@redhat.com>
	<20210224121234.0127ae4b.cohuck@redhat.com>
	<be6713d3-ac98-bbbf-1dc1-a003ed06a156@redhat.com>
	<20210225135229-mutt-send-email-mst@kernel.org>
	<0f8eb381-cc98-9e05-0e35-ccdb1cbd6119@redhat.com>
	<20210228162306-mutt-send-email-mst@kernel.org>
	<cdd72199-ac7b-cc8d-2c40-81e43162c532@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, elic@nvidia.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 1 Mar 2021 11:51:08 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On 2021/3/1 5:25 =E4=B8=8A=E5=8D=88, Michael S. Tsirkin wrote:
> > On Fri, Feb 26, 2021 at 04:19:16PM +0800, Jason Wang wrote: =20
> >> On 2021/2/26 2:53 =E4=B8=8A=E5=8D=88, Michael S. Tsirkin wrote: =20

> >>> Confused. What is wrong with the above? It never reads the
> >>> field unless the feature has been offered by device. =20
> >>
> >> So the spec said:
> >>
> >> "
> >>
> >> The following driver-read-only field, max_virtqueue_pairs only exists =
if
> >> VIRTIO_NET_F_MQ is set.
> >>
> >> "
> >>
> >> If I read this correctly, there will be no max_virtqueue_pairs field i=
f the
> >> VIRTIO_NET_F_MQ is not offered by device? If yes the offsetof() violat=
es
> >> what spec said.
> >>
> >> Thanks =20
> > I think that's a misunderstanding. This text was never intended to
> > imply that field offsets change beased on feature bits.
> > We had this pain with legacy and we never wanted to go back there.
> >
> > This merely implies that without VIRTIO_NET_F_MQ the field
> > should not be accessed. Exists in the sense "is accessible to driver".
> >
> > Let's just clarify that in the spec, job done. =20
>=20
>=20
> Ok, agree. That will make things more eaiser.

Yes, that makes much more sense.

What about adding the following to the "Basic Facilities of a Virtio
Device/Device Configuration Space" section of the spec:

"If an optional configuration field does not exist, the corresponding
space is still present, but reserved."

(Do we need to specify what a device needs to do if the driver tries to
access a non-existing field? We cannot really make assumptions about
config space accesses; virtio-ccw can just copy a chunk of config space
that contains non-existing fields... I guess the device could ignore
writes and return zeroes on read?)

I've opened https://github.com/oasis-tcs/virtio-spec/issues/98 for the
spec issues.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

