Return-Path: virtio-comment-return-700-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Thu, 7 Mar 2019 17:53:48 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190307175347.GL2811@work-vm>
References: <20190304132531.10507-1-dgilbert@redhat.com>
 <20190304132531.10507-2-dgilbert@redhat.com>
 <20190307162516.GH2843@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307162516.GH2843@stefanha-x1.localdomain>
Subject: Re: [virtio-comment] [PATCH v3 1/3] shared memory: Define shared
 memory regions
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Mon, Mar 04, 2019 at 01:25:29PM +0000, Dr. David Alan Gilbert (git) wrote:
> > +\subsection{Addressing within regions}\label{sec:Basic Facilities of a Virtio Device / Shared Memory Regions / Addressing within regions }
> > +
> > +Commands sent over the virtqueues may refer to data within the
> > +shared memory regions, for example a command may be used by a
> > +driver to cause a device to add or remove a mapping within
> > +a region.  When referring to data, the addresses will normally be
> > +offsets within a particular region rather than absolute host or
> > +guest addresses.  The \field{shmid} may be explicit or may be
> > +inferred from the command type.
> 
> This sounds like normative statements.  They belong in a driver or
> device normative section.

I think we were trying in a previous version to make it one; but the
problem is it's not really a statement about something a device or
driver must do; it's a statement advising someone writing the spec
for a particular device to make sure it's specified like that.

> Otherwise:
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks.

Dave


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

