Return-Path: virtio-comment-return-679-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 27 Feb 2019 18:37:29 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190227183728.GL2602@work-vm>
References: <20190222115433.7160-1-dgilbert@redhat.com>
 <20190222115433.7160-4-dgilbert@redhat.com>
 <20190225165014.GE379@stefanha-x1.localdomain>
 <20190225184506.GF2710@work-vm>
 <20190227145652.22286c72.cohuck@redhat.com>
 <20190227170612.GE927@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227170612.GE927@stefanha-x1.localdomain>
Subject: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH v2 3/3] shared
 memory: Define mmio registers
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Wed, Feb 27, 2019 at 02:56:52PM +0100, Cornelia Huck wrote:
> > On Mon, 25 Feb 2019 18:45:06 +0000
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > 
> > > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > > On Fri, Feb 22, 2019 at 11:54:33AM +0000, Dr. David Alan Gilbert (git) wrote:  
> > 
> > > > > +    region, as defined by the device for the region selected by
> > > > > +    the \field{SHMId} register.  Reading from a non-existent
> > > > > +    region (i.e. where the ID written to \field{SHMId} is unused)
> > > > > +    results in a length of -1.  
> > > > 
> > > > -1 is used to indicate the absence of a region, does 0 have a meaning?  
> > > 
> > > No, I'd be happy to switch; although this does lead to another question;
> > > what happens on an older virtio-mmio implementation when a device
> > > tries to read these registers to detect if the region exists?
> > 
> > You probably mean that the driver is reading, right? Not sure if we
> > ever specified what happens if a driver interacts with a register that
> > was not specified when the device was written... maybe we need to bump
> > the device version number? But that would break old drivers if they get
> > a 3 but expected a 2.
> 
> I see the rationale for using 0xffffffff since that's what loads produce
> when there is nothing at the memory address.  It would be good to
> document that :).

Is that actually defined that we get 0xffffffff? - in which case
yes I'd add it as a reasoning; but I hadn't realised it was actually
defined anywhere.

> Incrementing the version as Cornelia suggested is cleaner though, if
> existing drivers handle that gracefully.  Or maybe a transport feature
> bit (are they in short supply?).

We do have transport feature bits for other transports don't we, and
they can overlap those.

Dave

> Stefan


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

