Return-Path: virtio-return-2980-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 7 Mar 2018 21:27:14 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180307212400-mutt-send-email-mst@kernel.org>
References: <1519860484-7936-1-git-send-email-mst@redhat.com>
 <1519860484-7936-15-git-send-email-mst@redhat.com>
 <20180307121158.34829f6b.cohuck@redhat.com>
 <20180307155530-mutt-send-email-mst@kernel.org>
 <20180307154941.06a27742.cohuck@redhat.com>
 <1ad91690-7096-7826-3fe7-93330bc7d2a5@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ad91690-7096-7826-3fe7-93330bc7d2a5@linux.vnet.ibm.com>
Subject: Re: [virtio] Re: [PATCH v9 14/16] VIRTIO_F_NOTIFICATION_DATA: extra
 data to devices
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 07, 2018 at 05:05:24PM +0100, Halil Pasic wrote:
> 
> 
> On 03/07/2018 03:49 PM, Cornelia Huck wrote:
> >>>> +When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> >>>> +the driver notifies the device by writing the following
> >>>> +32-bit value to the Queue Notify address:
> >>>> +\begin{lstlisting}
> >>>> +le32 vqn : 16,
> >>>> +     next_off : 15,
> >>>> +     next_wrap : 1;  
> >>> Don't we want to write this as
> >>>
> >>> le32 vqn : 16;
> >>> le32 next_off :15;
> >>> le32 next_wrap : 1;
> >>>
> >>> ?  
> >> Same thing in C, but would be more confusing IMHO since it will be up to
> >> the reader to figure out which fields comprise the 32 bit integer.
> > It looked weird to me. Other opinions?
> > 
> 
> Regarding the c11 standard the two are equivalent. Thus it does not
> matter to me which notation is used. AFAIK bit-fields are only defined
> in the context of structs (and/or unions), so I assumed that. Putting a
> struct around it would be much better IMHO.

The point in not writing a struct around it is to
make sure people do not think it's portable C.

> I don't agree with Michael's argument about 'which fields comprise the
> 32 bit integer', as IMHO it does not make sense in terms of c11.
> 
> Consider 
> 
> struct A {
> 	uint32_t a:30, b:1, c:2:, d:8;
> };
> 
> I think, in this particular case the notation ain't very helpful in
> figuring out what comprises what. For that reason, if I really need
> to choose, I would side with Connie on this one.
> 
> But there is another, more significant problem IMHO. The guarantees
> provided by the C language (c11) regarding the resulting memory layout
> are not sufficient to reason about it like Michael's comment and
> the bit's of the draft imply. To know the memory layout we need the
> ABI specification for the given platform on top of the C standard.
> 
> So if the bit fields are about in memory layout, I find the stuff
> problematic. If however we use bit-fields only to define how arithmetic
> works, then we are fine.

Well, it's not C really. It's just a C-like notation.

+When documenting sub-byte data fields, C-like bitfield notation
+is used. Fields within an integer are always listed in order,
+from the least significant to the most significant bit.
+
+For example:
+\begin{lstlisting}
+be16 A : 15;
+be16 B : 1;
+\end{lstlisting}
+documents the value A stored in the low 15 bit of a 16 bit
+integer and the value B stored in the high bit of the 16 bit
+integer, the integer in turn using the big-endian byte order.
+
+Note that this notation typically matches the way bitfields are
+packed by C compilers on little-endian architectures but not the
+way bitfields are packed by C compilers on big-endian
+architectures.




> And a side note: A stronger/better reference to the C language could
> benefit clarity. Especially if we start relying on the less trivial
> properties of the C language.
> 
> Hope this helps!
> 
> Regards,
> Halil

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

