Return-Path: <hengqi@linux.alibaba.com>
Date: Tue, 31 Jan 2023 13:31:23 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH v7] virtio-net:
 support inner header hash
Message-ID: <20230131053123.GB34480@h68b04307.sqa.eu95>
References: <20230104071401.31746-1-hengqi@linux.alibaba.com>
 <20230111042905-mutt-send-email-mst@kernel.org>
 <20230116080106.GA114763@h68b04307.sqa.eu95>
 <87k01mnb93.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87k01mnb93.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 16, 2023 at 09:18:16AM +0100, Cornelia Huck wrote:
> On Mon, Jan 16 2023, Heng Qi <hengqi@linux.alibaba.com> wrote:
> 
> > On Wed, Jan 11, 2023 at 04:45:12AM -0500, Michael S. Tsirkin wrote:
> >> On Wed, Jan 04, 2023 at 03:14:01PM +0800, Heng Qi wrote:
> >> > @@ -3386,7 +3391,8 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
> >> >          le16 num_buffers;
> >> >          le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
> >> >          le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
> >> > -        le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
> >> > +        u8 hash_report_tunnel;  (Only if VIRTIO_NET_F_HASH_REPORT negotiated, only valid of VIRTIO_NET_F_HASH_TUNNEL negotiated)
> >> 
> >> of -> if?
> >
> > Sorry for the late reply.
> > It's Cornelia's suggestion, and 'of' seems to work fine.
> 
> I think that was simply a typo, should have been 'if'.

Sorry for the late reply due to vacation.

It is my mistake, sorry.

Thanks.

> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

