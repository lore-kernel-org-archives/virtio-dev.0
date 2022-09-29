Return-Path: <virtio-dev-return-9988-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 26791986450
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Sep 2022 01:48:48 +0000 (UTC)
MIME-Version: 1.0
References: <1663297006-64248-1-git-send-email-hengqi@linux.alibaba.com>
 <3c3cc916-c605-1ed2-d3ff-d8d8ce668f17@redhat.com> <20220920032824.GA125047@h68b04307.sqa.eu95>
 <CACGkMEtOHXtNtG13Zxpc+bhYJVyefp999kttz4YcPi22nMBSpQ@mail.gmail.com>
 <1663903426.8765974-1-xuanzhuo@linux.alibaba.com> <CACGkMEsmqngS-HYPzzV8b9dmv95=W6dJebAa=asXGmo7VEAnoA@mail.gmail.com>
 <20220923013341-mutt-send-email-mst@kernel.org> <619af5b3-4c38-955f-0f7f-f351f5a9527e@redhat.com>
 <20220928093530-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220928093530-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Sep 2022 09:48:33 +0800
Message-ID: <CACGkMEsKHBo+tgJrADif9y5qLF-OHoK7pO6YvQBa-edjjPwVJQ@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v8] virtio_net: support for split transport header
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Kangjie Xu <kangjie.xu@linux.alibaba.com>, Heng Qi <hengqi@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Sep 28, 2022 at 9:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 26, 2022 at 04:06:17PM +0800, Jason Wang wrote:
> > > Jason I think the issue with previous proposals is that they conflict
> > > with VIRTIO_F_ANY_LAYOUT. We have repeatedly found that giving the
> > > driver flexibility in arranging the packet in memory is benefitial.
> >
> >
> > Yes, but I didn't found how it can conflict the any_layout. Device can just
> > to not split the header when the layout doesn't fit for header splitting.
> > (And this seems the case even if we're using buffers).
>
> Well spec says:
>
>         indicates to both the device and the driver that no
>         assumptions were made about framing.
>
> if device assumes that descriptor boundaries are where
> driver wants packet to be stored that is clearly
> an assumption.

Yes but what I want to say is, the device can choose to not split the
packet if the framing doesn't fit. Does it still comply with the above
description?

Thanks

>
>
> --
> MST
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

