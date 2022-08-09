Return-Path: <virtio-dev-return-9714-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B36A0986304
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Aug 2022 09:29:07 +0000 (UTC)
MIME-Version: 1.0
References: <20220802044548.9031-1-gavinl@nvidia.com> <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com> <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com> <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <20220809051849-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220809051849-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Aug 2022 17:28:53 +0800
Message-ID: <CACGkMEvMqnjcY2R-BWUT_DreK4YN5CWmE_KfSqosH89Yn4g62g@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Li <gavinl@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, "Hemminger, Stephen" <stephen@networkplumber.org>, davem <davem@davemloft.net>, virtualization <virtualization@lists.linux-foundation.org>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, loseweigh@gmail.com, Parav Pandit <parav@nvidia.com>, gavi@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 9, 2022 at 5:22 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Aug 09, 2022 at 03:44:22PM +0800, Jason Wang wrote:
> > > @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct virtio_device
> > > *vdev)
> > >       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > >           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
> > >           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
> > > -         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
> > > +         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO)) {
> > >               vi->big_packets = true;
> > > +             vi->gso_is_supported = true;
> > >
> > > Please do the same for virtnet_clear_guest_offloads(), and
> > > correspondingly virtnet_restore_guest_offloads() as well. Not sure why
> > > virtnet_clear_guest_offloads() or the caller doesn't unset big_packet on
> > > successful return, seems like a bug to me.
> >
> > It is fine as long as
> >
> > 1) we don't implement ethtool API for changing guest offloads
> > 2) big mode XDP is not enabled
> >
> > So that code works only for XDP but we forbid big packets in the case
> > of XDP right now.
> >
> > Thanks
>
> To put it another way, changing big_packets after probe requires a bunch
> of work as current code assumes this flag never changes.
> Adding a TODO to handle dynamic offload config is fine but
> I don't think it should block this.

Yes, this is what I mean.

Thanks

>
> --
> MST
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

