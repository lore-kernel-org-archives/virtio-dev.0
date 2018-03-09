Return-Path: virtio-return-2984-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 9 Mar 2018 09:16:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180309091646.362231d7.cohuck@redhat.com>
In-Reply-To: <20180308180221-mutt-send-email-mst@kernel.org>
References: <1519860484-7936-1-git-send-email-mst@redhat.com>
	<1519860484-7936-15-git-send-email-mst@redhat.com>
	<20180307121158.34829f6b.cohuck@redhat.com>
	<20180307155530-mutt-send-email-mst@kernel.org>
	<20180307154941.06a27742.cohuck@redhat.com>
	<1ad91690-7096-7826-3fe7-93330bc7d2a5@linux.vnet.ibm.com>
	<20180307171427.3eb8efc6.cohuck@redhat.com>
	<20180307214210-mutt-send-email-mst@kernel.org>
	<8f459bb6-6520-46ac-e858-34ae457ac314@linux.vnet.ibm.com>
	<20180308180221-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [virtio-dev] Re: [virtio] Re: [PATCH v9 14/16]
 VIRTIO_F_NOTIFICATION_DATA: extra data to devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 8 Mar 2018 18:19:39 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Mar 08, 2018 at 02:03:31PM +0100, Halil Pasic wrote:
> > One stray idea was something like
> > 
> > be32 (A:16;B:15;C:1);
> > 
> > With 
> > * A occupying bits 0-15
> > * B occupying bits 16-30
> > * C occupying bit 30
> > 
> > And bit n of B (n \in [0..15] being the n-16-th bit of the be32
> > subdivided into fields.
> > 
> > The idea behind () is that it ain't unusual for tuples, and
> > also the most common grouping semantic is fitting in a sense
> > that all the fields are together the be32. The separation by
> > semicolon is to make it obvious that this has nothing to do
> > with C and that it's not intended to be implemented with C
> > bit-fields.  
> 
> OK let's look at a real life example:
> 
> struct desc_event {
> 	le16 (
> 	     desc_event_off : 15; /* Descriptor Event Offset */
> 	     desc_event_wrap : 1; /* Descriptor Event Wrap Counter */
> 	);
> 	le16 (
> 	      desc_event_flags : 2; /* Descriptor Event Flags */
> 	      reserved : 14; /* Reserved, set to 0 */
> 	);
> };
> 
> As an option (2), I suggest curly brackets which look a bit more
> consistent:
> 
> struct desc_event {
> 	le16 {
> 	     desc_event_off : 15; /* Descriptor Event Offset */
> 	     desc_event_wrap : 1; /* Descriptor Event Wrap Counter */
> 	};
> 	le16 {
> 	      desc_event_flags : 2; /* Descriptor Event Flags */
> 	      reserved : 14; /* Reserved, set to 0 */
> 	};
> };
> 
> Cornelia, Halil - any preferences? Ack on one of the above two?

OK, both make it more obvious what is going on there. I think I prefer
option 2 (curly braces).

> 
> introduction text accordingly (using curly braces, will adopt
> accordingly):
> 
> When documenting sub-byte data fields, C-like bitfield notation is used.
> Fields within an integer are always listed in order, with their lengths,
> from the least significant to the most significant bit. The fields
> are considered unsigned integers of the specified width with the next in
> significance relationship on the bits preserved.
> 
> For example:
> \begin{lstlisting}
> struct S {
> 	be16 {
> 	     A : 15;
> 	     B : 1;
> 	};
> 	be16 C;
> }
> \end{lstlisting}
> documents the value A stored in the low 15 bit of a 16 bit
> integer and the value B stored in the high bit of the 16 bit
> integer, the integer in turn using the big-endian byte order
> and being stored at the beginning of the structure S,
> and being followed immediately by an unsigned integer C

add "in big-endian byte order"?

> stored at offset of 2 bytes (16 bits) from the beginning of
> the structure.
> 
> Note that this notation somewhat resembles the C bitfield syntax but
> should not be naively converted to a bitfield notation for portable
> code: it matches the way bitfields are packed by C compilers on
> little-endian architectures but not the way bitfields are packed by C
> compilers on big-endian architectures.
> 
> Assuming that CPU_TO_BE16 converts a 16-bit integer from a native
> CPU to the big-endian byte order, the following is the equivalent
> portable C code to generate a value in this format:

"(the first value in the example above)"?

> \begin{lstlisting}
> CPU_TO_BE16(B << 15 | A)
> \end{lstlisting}

Looks sane.

[I'll not be around for further discussions in the next two weeks, but
I'd vote on the issue on OASIS, should you decide to put up a vote.]

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

