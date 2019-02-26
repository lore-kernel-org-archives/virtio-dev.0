Return-Path: virtio-comment-return-660-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Tue, 26 Feb 2019 15:11:34 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190226151133.GI2721@work-vm>
References: <20190222115433.7160-1-dgilbert@redhat.com>
 <20190222115433.7160-2-dgilbert@redhat.com>
 <20190222134839.7e0ef3e7.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222134839.7e0ef3e7.cohuck@redhat.com>
Subject: [virtio-comment] Re: [virtio-dev] Re: [PATCH v2 1/3] shared memory: Define shared
 memory regions
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

* Cornelia Huck (cohuck@redhat.com) wrote:
> On Fri, 22 Feb 2019 11:54:31 +0000
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> 
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Define the requirements and idea behind shared memory regions.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  content.tex    |  2 ++
> >  shared-mem.tex | 33 +++++++++++++++++++++++++++++++++
> >  2 files changed, 35 insertions(+)
> >  create mode 100644 shared-mem.tex
> > 
> > diff --git a/content.tex b/content.tex
> > index 836ee52..3dd504c 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -371,6 +371,8 @@ making any more buffers available. When VIRTIO_F_NOTIFICATION_DATA
> >  has been negotiated, these notifications would then have
> >  identical \field{next_off} and \field{next_wrap} values.
> >  
> > +\input{shared-mem.tex}
> > +
> >  \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
> >  
> >  We start with an overview of device initialization, then expand on the
> > diff --git a/shared-mem.tex b/shared-mem.tex
> > new file mode 100644
> > index 0000000..85b0c55
> > --- /dev/null
> > +++ b/shared-mem.tex
> > @@ -0,0 +1,33 @@
> > +\section{Shared Memory Regions}\label{sec:Basic Facilities of a Virtio Device / Shared Memory Regions}
> > +
> > +Shared memory regions are an additional facility
> > +available to devices that need a region of memory that's
> > +continuously shared between the host and the guest, rather
> > +than passed between them in the way virtqueue elements are.
> > +
> > +Example uses include shared caches and version pools for versioned
> > +data structures.
> > +
> > +The region is chosen by the host and presented to the guest, as
> > +such it is useful in situations where the memory is accessed on
> > +the host by other libraries that can't safely access guest RAM.
> 
> This explanation looks good to me.
> 
> > +
> > +Shared memory regions MUST NOT be used to control the operation
> > +of the device, nor to stream data; those should still be performed
> > +using virtqueues.
> 
> The 'MUST NOT' makes it look like a normative statement; however, this
> is more like design advice?

Hmm I'm not sure - the intention of this line is to try and stop people
using it as a hack to avoid standardising protocol for no good reason.

> > +
> > +A device may have multiple shared memory regions associated with
> > +it.  Each region has a \field{shmid} to identify it, the meaning
> > +of which is device-specific.
> > +
> > +Enumeration and location of shared memory regions is performed
> > +using a transport-specific data structure and mechanism.
> > +
> > +Memory consistency rules vary depending on the region and the
> > +device.  Devices MUST define the required behaviour for each
> > +region.
> 
> Same here.

OK, so should I reword this?

> > +
> > +The guest physical address and the host virtual address MUST NOT
> > +be used to identify structures within the memory regions; all
> > +addressing MUST be relative to the start of a particular region.
> > +
> 
> For that high-level overview, I'm not sure if any normative statements
> are needed/wanted, or whether those should be confined to the individual
> transport or device type definitions...

I think this one is stronger than the previous two; if people start
passing GPA/HVA in the underlying structures things are going to get
messy.

Dave

> The text on its own looks good to me.
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
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

