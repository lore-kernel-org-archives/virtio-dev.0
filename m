Return-Path: virtio-return-3434-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 11 Aug 2020 10:39:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20200811103911.09feca42.cohuck@redhat.com>
In-Reply-To: <20200811042047-mutt-send-email-mst@kernel.org>
References: <20200810161501.1572834-1-mst@redhat.com>
	<20200810185928.2e722231.cohuck@redhat.com>
	<20200811042047-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: Re: [virtio] [PATCH RFC] VIRTIO_F_PARTIAL_ORDER for page fault
 handling
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 11 Aug 2020 04:23:13 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Aug 10, 2020 at 06:59:28PM +0200, Cornelia Huck wrote:
> > On Mon, 10 Aug 2020 12:15:15 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:

> > > diff --git a/split-ring.tex b/split-ring.tex
> > > index 123ac9f..cf197f8 100644
> > > --- a/split-ring.tex
> > > +++ b/split-ring.tex
> > > @@ -398,10 +398,11 @@ \subsection{The Virtqueue Used Ring}\label{sec:Basic Facilities of a Virtio Devi
> > >          le16 avail_event; /* Only if VIRTIO_F_EVENT_IDX */
> > >  };
> > >  
> > > -/* le32 is used here for ids for padding reasons. */
> > >  struct virtq_used_elem {
> > >          /* Index of start of used descriptor chain. */
> > > -        le32 id;
> > > +        le16 id;
> > > +#define VIRTQ_USED_ELEM_F_FLUSH  0x8000
> > > +        le16 flags;  
> > 
> > This is a bit confusing for legacy, as this will only work for
> > little-endian. The flags field will only be used for non-legacy, but I
> > think the id field should still be treated as 32 bit for legacy.
> > (We have a wholesale "it's guest endian when legacy" further up.)  
> 
> True. How do you suggest handling this? Just say that id is
> OR with VIRTQ_USED_ELEM_F_FLUSH ? Or maybe just add
> struct virtq_used_elem_legacy?

I think introducing a legacy struct is the least confusing option.

> 
> 
> > >          /* Total length of the descriptor chain which was used (written to) */
> > >          le32 len;
> > >  };


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

