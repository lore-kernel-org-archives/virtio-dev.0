Return-Path: <mst@redhat.com>
Date: Mon, 13 Feb 2023 17:23:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] [PATCH v8] virtio-net: support inner header hash
Message-ID: <20230213172158-mutt-send-email-mst@kernel.org>
References: <20230208090836.74355-1-hengqi@linux.alibaba.com>
 <0f73e9c7-5080-d01c-0f63-dd23942fa71b@linux.alibaba.com>
 <PH0PR12MB54817EAF86DF11B9FB0DCB8EDCDD9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54817EAF86DF11B9FB0DCB8EDCDD9@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 13, 2023 at 09:42:25PM +0000, Parav Pandit wrote:
> 
> 
> > From: Heng Qi <hengqi@linux.alibaba.com>
> > Sent: Monday, February 13, 2023 8:05 AM
> > Hi, all.
> > 
> > Do you have any comments on this version?
> > 
> > Thanks.
> > 
> > 在 2023/2/8 下午5:08, Heng Qi 写道:
> > > If the tunnel is used to encapsulate the packets, the hash calculated
> > > using the outer header of the receive packets is always fixed for the
> > > same flow packets, i.e. they will be steered to the same receive queue.
> > >
> > > We add a feature bit VIRTIO_NET_F_HASH_TUNNEL and related bitmasks in
> > > \field{hash_tunnel_types}, which instructs the device to calculate the
> > > hash using the inner headers of tunnel-encapsulated packets. Besides,
> > > values in \field{hash_report_tunnel_types} are added to report tunnel types.
> > >
> > > Note that VIRTIO_NET_F_HASH_TUNNEL only indicates the ability of the
> > > inner header hash, and does not give the device the ability to use the
> > > hash value to select a receiving queue to place the packet.
> > >
> [..]
> > > @@ -3384,9 +3396,10 @@ \subsection{Device Operation}\label{sec:Device
> > Types / Network Device / Device O
> > >           le16 csum_start;
> > >           le16 csum_offset;
> > >           le16 num_buffers;
> > > -        le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT
> > negotiated)
> > > -        le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT
> > negotiated)
> > > -        le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT
> > negotiated)
> > > +        le32 hash_value;              (Only if VIRTIO_NET_F_HASH_REPORT
> > negotiated)
> > > +        le16 hash_report;             (Only if VIRTIO_NET_F_HASH_REPORT
> > negotiated)
> > > +        u8 hash_report_tunnel_types;  (Only if VIRTIO_NET_F_HASH_REPORT
> 
> I am yet to review the changes of v8.
> But the quick response is, I do not see a use case of above field by sw driver.
> And this addition requires the core hw data path to supply this value.
> Without good motivation, it is hard to have it here.

I think I agree that we should be careful about adding stuff in packet
header. Yes it's using the padding but we only have 2 bytes of that.

> What is valuable is to have a VNI already identified and coming to the driver, like a hash value.
> This can cut down the cpu processing power, in outer header packet processing.
> However, that is relatively a different feature than inner hash.
> 
> So, my input is to omit hash_report_tunnel_types.
> Will respond to Michael question in other thread.

