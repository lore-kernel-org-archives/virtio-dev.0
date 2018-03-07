Return-Path: virtio-return-2981-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 7 Mar 2018 21:53:19 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180307214210-mutt-send-email-mst@kernel.org>
References: <1519860484-7936-1-git-send-email-mst@redhat.com>
 <1519860484-7936-15-git-send-email-mst@redhat.com>
 <20180307121158.34829f6b.cohuck@redhat.com>
 <20180307155530-mutt-send-email-mst@kernel.org>
 <20180307154941.06a27742.cohuck@redhat.com>
 <1ad91690-7096-7826-3fe7-93330bc7d2a5@linux.vnet.ibm.com>
 <20180307171427.3eb8efc6.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307171427.3eb8efc6.cohuck@redhat.com>
Subject: Re: [virtio] Re: [PATCH v9 14/16] VIRTIO_F_NOTIFICATION_DATA: extra
 data to devices
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 07, 2018 at 05:14:27PM +0100, Cornelia Huck wrote:
> On Wed, 7 Mar 2018 17:05:24 +0100
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
> > On 03/07/2018 03:49 PM, Cornelia Huck wrote:
> > >>>> +When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> > >>>> +the driver notifies the device by writing the following
> > >>>> +32-bit value to the Queue Notify address:
> > >>>> +\begin{lstlisting}
> > >>>> +le32 vqn : 16,
> > >>>> +     next_off : 15,
> > >>>> +     next_wrap : 1;    
> > >>> Don't we want to write this as
> > >>>
> > >>> le32 vqn : 16;
> > >>> le32 next_off :15;
> > >>> le32 next_wrap : 1;
> > >>>
> > >>> ?    
> > >> Same thing in C, but would be more confusing IMHO since it will be up to
> > >> the reader to figure out which fields comprise the 32 bit integer.  
> > > It looked weird to me. Other opinions?
> > >   
> > 
> > Regarding the c11 standard the two are equivalent. Thus it does not
> > matter to me which notation is used. AFAIK bit-fields are only defined
> > in the context of structs (and/or unions), so I assumed that. Putting a
> > struct around it would be much better IMHO.
> > 
> > I don't agree with Michael's argument about 'which fields comprise the
> > 32 bit integer', as IMHO it does not make sense in terms of c11.
> > 
> > Consider 
> > 
> > struct A {
> > 	uint32_t a:30, b:1, c:2:, d:8;
> > };
> > 
> > I think, in this particular case the notation ain't very helpful in
> > figuring out what comprises what. For that reason, if I really need
> > to choose, I would side with Connie on this one.
> > 
> > But there is another, more significant problem IMHO. The guarantees
> > provided by the C language (c11) regarding the resulting memory layout
> > are not sufficient to reason about it like Michael's comment and
> > the bit's of the draft imply. To know the memory layout we need the
> > ABI specification for the given platform on top of the C standard.
> > 
> > So if the bit fields are about in memory layout, I find the stuff
> > problematic. If however we use bit-fields only to define how arithmetic
> > works, then we are fine.
> 
> I'm not sure we should go down the C standard rabbit hole. People have
> gotten lost in there.

+1
In particular virtio already uses C-like syntax for structure
without regard to what the C standard says. It's just pseudo-code,
nothing to be hang about.

> If the clarification of what we mean by this notation (patch 1 + the
> update sent later) is not enough,

Halil, can you pls say whether it's enough?

> I'd rather prefer us to add a
> clarifying sentence/diagram/... there. I was mainly bothered by the
> change to the definition in this patch...

Here's what we are trying to say (for example):

	+the value A stored in the low 15 bit of a 16 bit
	+integer and the value B stored in the high bit of the 16 bit
	+integer, the integer in turn using the big-endian byte order.

Thus we can write:

be16 A : 15,
     B : 1;

which maps to:

be -> big endian
16 -> 16 bit integer

A : 15 - low 15 bits
B : 1 - following 1 bit

Why not repeat be16 twice? Well first of all why repeat information
twice? Second this notation lets us list many integer fields
as we might have in the structure:

be16 A : 15,
     B : 1;
be16 C;

And it also ties to the existing notation for full integers.

Any suggestions on how to do it better?
Please provide an example based on the above.

-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

