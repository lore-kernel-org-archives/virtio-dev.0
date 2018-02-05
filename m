Return-Path: virtio-return-2867-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 5 Feb 2018 19:16:54 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180205191654.451e3176.cohuck@redhat.com>
In-Reply-To: <208b5b07-6b83-8bd5-8360-290b186eaa43@redhat.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
	<1516665617-30748-8-git-send-email-mst@redhat.com>
	<20180130145044.648bbe4e.cohuck@redhat.com>
	<180bf54b-4e40-8c24-2888-0ea102ddb772@linux.vnet.ibm.com>
	<20180205161419-mutt-send-email-mst@kernel.org>
	<c97813f5-f980-610c-4b01-987bb28b8a2a@linux.vnet.ibm.com>
	<208b5b07-6b83-8bd5-8360-290b186eaa43@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [virtio-dev] Re: [virtio] [PATCH v7 08/11] packed virtqueues:
 more efficient virtqueue layout
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 5 Feb 2018 18:00:07 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 05/02/2018 17:57, Halil Pasic wrote:
> >> This is certainly not how we did it for v1.0, and not how
> >> oasis process works generally. Implementations are required
> >> to move to an oasis standard change. We are working on
> >> a committee standard deliverables.
> >>
> >> I don't yet plan to work on an implementation yet: it's a bit of a
> >> chicked and egg problem. People are reluctant to work on what's not in
> >> the spec. We can always make changes as long as there are no
> >> implementations.
> >>  
> > 'We can always make changes as long as there are no implementations'
> > comes very surprising to me. I believed, once a committee specification
> > is released the requirements for changes are given, and don't depend
> > on known implementations.
> > 
> > Does this imply that one should be reluctant about implementing
> > a virtio specification that still has no implementation (because it ain't
> > stable, and may change, because there is no implementation yet)?  
> 
> I agree that this doesn't seem optimal.  This is a much bigger change
> than anything between virtio 0.9 and in virtio 1.0, because it affects
> the data path directly.

Nod. It looks in pretty good shape to me, once we fixed up the things I
noticed during this round, but I still feel a bit uncomfortable without
a prototype for non-pci.

One issue for me is that all work has been done with pci as the
transport, and with a view as to what could be helpful for implementers
of pci cards. There's nothing inherently bad in that, but it does
introduce a chance that other transports may run into problems when
they try to implement it.

Not an insurmountable problem, but something that should be kept in
mind.

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

