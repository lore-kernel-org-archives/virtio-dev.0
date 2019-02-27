Return-Path: virtio-comment-return-668-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 27 Feb 2019 14:56:52 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190227145652.22286c72.cohuck@redhat.com>
In-Reply-To: <20190225184506.GF2710@work-vm>
References: <20190222115433.7160-1-dgilbert@redhat.com>
	<20190222115433.7160-4-dgilbert@redhat.com>
	<20190225165014.GE379@stefanha-x1.localdomain>
	<20190225184506.GF2710@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-comment] Re: [PATCH v2 3/3] shared memory: Define mmio
 registers
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 25 Feb 2019 18:45:06 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > On Fri, Feb 22, 2019 at 11:54:33AM +0000, Dr. David Alan Gilbert (git) wrote:  

> > > +    region, as defined by the device for the region selected by
> > > +    the \field{SHMId} register.  Reading from a non-existent
> > > +    region (i.e. where the ID written to \field{SHMId} is unused)
> > > +    results in a length of -1.  
> > 
> > -1 is used to indicate the absence of a region, does 0 have a meaning?  
> 
> No, I'd be happy to switch; although this does lead to another question;
> what happens on an older virtio-mmio implementation when a device
> tries to read these registers to detect if the region exists?

You probably mean that the driver is reading, right? Not sure if we
ever specified what happens if a driver interacts with a register that
was not specified when the device was written... maybe we need to bump
the device version number? But that would break old drivers if they get
a 3 but expected a 2.

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

