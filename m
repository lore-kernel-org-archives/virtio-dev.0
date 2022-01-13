Return-Path: <virtio-dev-return-9032-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6B539986502
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Jan 2022 15:17:08 +0000 (UTC)
Date: Thu, 13 Jan 2022 10:17:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220113101633-mutt-send-email-mst@kernel.org>
References: <20220112055755.41011-1-jasowang@redhat.com>
 <20220112055755.41011-3-jasowang@redhat.com>
 <Yd6wZ2WMP0FMXWh8@stefanha-x1.localdomain>
 <CACGkMEtb7wGZ8oG-LwUNpFD2pJgEKGx6ttZHgWM686EN4A060A@mail.gmail.com>
 <Yd//qzpb7EJ1fa1y@stefanha-x1.localdomain>
 <20220113054324-mutt-send-email-mst@kernel.org>
 <YeA88PL9oOfphhoa@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <YeA88PL9oOfphhoa@stefanha-x1.localdomain>
Subject: Re: [virtio-dev] Re: [PATCH V2 2/2] virtio-pci: add PASID
 configuration extended capability
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 13, 2022 at 02:53:36PM +0000, Stefan Hajnoczi wrote:
> On Thu, Jan 13, 2022 at 05:45:11AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Jan 13, 2022 at 10:32:11AM +0000, Stefan Hajnoczi wrote:
> > > > So my understanding is that instead of delaying the response to read
> > > > it's better to simply present the previous PASID value if there're any
> > > > pending transactions of previous PASID value. The driver can then
> > > > choose to poll or using timers etc.
> > 
> > Don't we limit these changes to before DRIVER_OK?
> > If we do then no previous transactions can exist.
> 
> Not sure if that's possible for the vDPA virtqueue assignment use case
> where one large VIRTIO device provides virtqueues for many smaller vDPA
> devices?
> 
> Stefan

Then I guess queue must be stopped?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

