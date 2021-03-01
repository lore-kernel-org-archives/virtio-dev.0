Return-Path: virtio-dev-return-8076-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6A455986307
	for <virtio-dev@lists.oasis-open.org>; Mon,  1 Mar 2021 17:52:23 +0000 (UTC)
MIME-Version: 1.0
References: <CAPR809ud5OC2fAdyRqHR0tw+H++nDVk1g2FZw2-KCLJHnCcm3Q@mail.gmail.com>
 <YDzN9zwyeOp8+ftw@stefanha-x1.localdomain>
In-Reply-To: <YDzN9zwyeOp8+ftw@stefanha-x1.localdomain>
From: Enrico Granata <egranata@google.com>
Date: Mon, 1 Mar 2021 10:52:10 -0700
Message-ID: <CAPR809uwcAGw7QH-FFNRzLXpuACQWf0MjExn1nOw-Yc2ZsB-bQ@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v2] Add lifetime metrics to virtio-blk
Content-Type: text/plain; charset="UTF-8"
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Thanks for pointing this issue out :) I respun a v3 patch with a new value (10)

Please feel free to take a look when you get a chance.

- Enrico

On Mon, Mar 1, 2021 at 4:20 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Thu, Feb 25, 2021 at 04:41:41PM -0700, Enrico Granata wrote:
> > @@ -4611,6 +4615,7 @@ \subsection{Device Operation}\label{sec:Device
> > Types / Block Device / Device Ope
> >  #define VIRTIO_BLK_T_GET_ID       8
> >  #define VIRTIO_BLK_T_DISCARD      11
> >  #define VIRTIO_BLK_T_WRITE_ZEROES 13
> > +#define VIRTIO_BLK_T_GET_LIFETIME 15
>
> Sorry I missed this in the previous revision:
>
> There is some funny business in the Linux drivers/block/virtio_blk.c
> driver and QEMU hw/block/virtio-blk.c device implementations where the
> least significant bit indicates a driver-to-device DMA transfer when
> set and a device-to-driver DMA transfer when clear. That's why
> DISCARD/WRITE_ZEROES have odd-numbered request types but GET_ID has an
> even-numbered request type.
>
> The implementations should probably be overhauled to stop doing this.
> There doesn't seem to be a good reason for it! :P
>
> To make life easy, please choose an even-numbered request type. That way
> these implementations will treat VIRTIO_BLK_T_GET_LIFETIME as a "read"
> instead of a "write". 10, 12, or 14 would work.
>
> Otherwise:
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

