Return-Path: virtio-comment-return-653-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Mon, 25 Feb 2019 18:45:06 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190225184506.GF2710@work-vm>
References: <20190222115433.7160-1-dgilbert@redhat.com>
 <20190222115433.7160-4-dgilbert@redhat.com>
 <20190225165014.GE379@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225165014.GE379@stefanha-x1.localdomain>
Subject: Re: [virtio-comment] Re: [PATCH v2 3/3] shared memory: Define mmio
 registers
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Fri, Feb 22, 2019 at 11:54:33AM +0000, Dr. David Alan Gilbert (git) wrote:
> > diff --git a/content.tex b/content.tex
> > index 9838208..c3070bd 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -1726,6 +1726,28 @@ All register values are organized as Little Endian.
> >      selected by writing to \field{QueueSel}.
> >    }
> >    \hline 
> > +  \mmioreg{SHMId}{Shared memory id}{0x0ac}{W}{%
> > +    Writing to this register selects the shared memory region \ref{sec:Basic Facilities of a Virtio Device / Shared Memory Regions}
> > +    following operations on \field{SHMLenLow}, \field{SHMLenHigh},
> > +    \field{SHMBaseLow} and \field{SHMBaseHigh} apply to.
> > +  }
> > +  \hline 
> > +  \mmiodreg{SHMLenLow}{SHMLenHigh}{Shared memory region 64 bit long length}{0x0b0}{0x0xb4}{R}{%
> 
> QueueDescLow/High explicitly documents the low and high 32 bits
> relationship of these two registers.  Please do the same of
> SHMLenLow/High and SHMBaseLow/High for clarity and consistency.  That
> way readers know the purpose of Low and High.

Done (and to SHMBase)

> 
> > +    These registers return the length of the shared memory
> 
> Adding "in bytes" makes the units explicit.

Done

> > +    region, as defined by the device for the region selected by
> > +    the \field{SHMId} register.  Reading from a non-existent
> > +    region (i.e. where the ID written to \field{SHMId} is unused)
> > +    results in a length of -1.
> 
> -1 is used to indicate the absence of a region, does 0 have a meaning?

No, I'd be happy to switch; although this does lead to another question;
what happens on an older virtio-mmio implementation when a device
tries to read these registers to detect if the region exists?

> > @@ -1761,6 +1783,9 @@ driver seeing an inconsistent configuration state.
> >  
> >  The device MUST NOT access virtual queue contents when \field{QueueReady} is zero (0x0).
> >  
> > +The device MUST NOT respond to SHM Base writes for none-existent
> 
> s/none/non/

Done

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

