Return-Path: virtio-dev-return-5796-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4DA9F985B43
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Jun 2019 20:44:01 +0000 (UTC)
Date: Fri, 21 Jun 2019 16:43:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190621164315-mutt-send-email-mst@kernel.org>
References: <1557600460-18966-1-git-send-email-ndragazis@arrikto.com>
 <20190619145430.GA1232@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619145430.GA1232@stefanha-x1.localdomain>
Subject: Re: [virtio-dev] [PATCH v3 0/4] introduce virtio vhost-user backend
 device type
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Nikos Dragazis <ndragazis@arrikto.com>, virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Vangelis Koukis <vkoukis@arrikto.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jun 19, 2019 at 03:54:30PM +0100, Stefan Hajnoczi wrote:
> On Sat, May 11, 2019 at 09:47:36PM +0300, Nikos Dragazis wrote:
> > Hi everyone,
> > 
> > this PATCH presents an updated version of the RFC virtio device spec for
> > the virtio-vhost-user device. The initial RFC implementation can be
> > found here: [1].
> > 
> > This PATCH is split into four parts:
> > 
> > 1. the first commit is just a refactored version of the initial RFC
> > implementation [1]. I just moved the device spec into a separate .tex
> > file and changed the device id from #24 to #28 since the ids #24-#27 are
> > reserved.
> > 
> > 2. the second commit fixes some minor issues with the device spec. This
> > is quite straightforward.
> > 
> > 3. the third commit enhances the notification capability with some
> > device/driver requirements. This makes sense because the notification
> > capability behaves similarly to the MSI-X capability, thereby having
> > some requirements that need to be mentioned.
> > 
> > 4. the fourth commit synchronizes the shared memory capability with a
> > recent patch [2] that attempts to standardize a standalone
> > SHARED_MEMORY_CFG virtio capability.
> > 
> > v3 changes:
> >  * Device Requirements for the Notification Capability: point out the
> >    difference between the MSI-X Table Size stored in the Message Control
> >    register of the MSI-X capability structure and the actual MSI-X Table
> >    Size
> > 
> > v2 changes:
> >  * Change device id from #25 to #28
> > 
> > Looking forward to your comments.
> 
> I'm happy with v3.
> 
> Any other comments or shall we proceed to a vote?
> 
> Stefan

I think we need to wait for shared memory part to be finalized, right?

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

