Return-Path: virtio-return-2869-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 5 Feb 2018 19:26:54 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180205192654.4cca75c0.cohuck@redhat.com>
In-Reply-To: <20180205202013-mutt-send-email-mst@kernel.org>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
	<1516665617-30748-8-git-send-email-mst@redhat.com>
	<20180130145044.648bbe4e.cohuck@redhat.com>
	<180bf54b-4e40-8c24-2888-0ea102ddb772@linux.vnet.ibm.com>
	<20180205161419-mutt-send-email-mst@kernel.org>
	<c97813f5-f980-610c-4b01-987bb28b8a2a@linux.vnet.ibm.com>
	<208b5b07-6b83-8bd5-8360-290b186eaa43@redhat.com>
	<20180205191654.451e3176.cohuck@redhat.com>
	<20180205202013-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [virtio-dev] Re: [virtio] [PATCH v7 08/11] packed virtqueues:
 more efficient virtqueue layout
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 5 Feb 2018 20:21:12 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Feb 05, 2018 at 07:16:54PM +0100, Cornelia Huck wrote:
> > > I agree that this doesn't seem optimal.  This is a much bigger change
> > > than anything between virtio 0.9 and in virtio 1.0, because it affects
> > > the data path directly.  
> > 
> > Nod. It looks in pretty good shape to me, once we fixed up the things I
> > noticed during this round, but I still feel a bit uncomfortable without
> > a prototype for non-pci.
> > 
> > One issue for me is that all work has been done with pci as the
> > transport, and with a view as to what could be helpful for implementers
> > of pci cards. There's nothing inherently bad in that, but it does
> > introduce a chance that other transports may run into problems when
> > they try to implement it.
> > 
> > Not an insurmountable problem, but something that should be kept in
> > mind.  
> 
> What do you suggest then?
> 

Do at least a quick qemu prototype. That gives you some idea where
things won't work, as it's the only way to cover all transports without
having to be aware of architecture details.

[The real solution is to have people with enough time, but that's a
pipe dream.]

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

