Return-Path: virtio-dev-return-5973-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AAA50985D15
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Aug 2019 06:33:17 +0000 (UTC)
Date: Wed, 14 Aug 2019 02:33:15 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <742877012.8416916.1565764395758.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190813152131.GC32090@stefanha-x1.localdomain>
References: <20190813125133.19754-1-pagupta@redhat.com> <20190813152131.GC32090@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH] content: document console vq detach buffer
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, amit@kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>


> 
> On Tue, Aug 13, 2019 at 06:21:33PM +0530, Pankaj Gupta wrote:
> > This patch documents console special case where vq buffers
> > are deleted at port hotunplug time. This behavior is different in
> > other devices where vq buffers are deleted at device unplug time.
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  content.tex | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/content.tex b/content.tex
> > index ee0d7c9..33e8ccc 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -497,6 +497,8 @@ \section{Device Cleanup}\label{sec:General
> > Initialization And Device Operation /
> >  of a live virtqueue.
> >  
> >  Thus a driver MUST ensure a virtqueue isn't live (by device reset) before
> >  removing exposed buffers.
> > +Console has a special property that when port is detached virtqueue is
> > considered stopped, device
> > +must not use any buffers, and it is legal to take buffers out of the
> > device.
> 
> The word "detach" is not defined or used in the spec, so it's unclear
> what this is supposed to mean.  Is this related to a control message
> (VIRTIO_CONSOLE_PORT_OPEN)?

By detach here we mean "unplug".  

> 
> How about:
> 
>   The device MUST NOT use buffers after it has sent
>   VIRTIO_CONSOLE_PORT_OPEN with value=0 for a port.
> 
> I'm not sure what you mean by "take buffers out of the device"?  I guess
> you mean the driver can modify the vring because the device isn't
> looking.

"take buffers out of the device" means "remove the unused buffers from the virt queue".

How about the below text:

Console has a special property that when port is unplugged virtqueue is
considered stopped, device must not use any buffers, and it is legal to
remove the unused buffers from the device.

Thanks,
Pankaj
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

