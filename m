Return-Path: virtio-comment-return-798-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Fri, 12 Jul 2019 13:16:56 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190712121656.GI2730@work-vm>
References: <20190710183212.29420-1-dgilbert@redhat.com>
 <20190710183212.29420-5-dgilbert@redhat.com>
 <20190712110141.072c1365.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712110141.072c1365.cohuck@redhat.com>
Subject: [virtio-comment] Re: [PATCH v6 4/5] shared memory: Define PCI capability
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, stefanha@redhat.com, vgoyal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

* Cornelia Huck (cohuck@redhat.com) wrote:
> On Wed, 10 Jul 2019 19:32:11 +0100
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> 
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Define the PCI capability used for enumerating shared memory regions.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  content.tex | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> 
> (...)
> 
> > +\devicenormative{\paragraph}{Device-specific configuration}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
> 
> Sorry about not noticing that before, but doesn't that need to be
> referenced in the conformance section somewhere?

OK, new version coming up.

Dave

> > +
> > +The region defined by the combination of the \field {cap.offset},
> > +\field {cap.offset_hi}, and \field {cap.length}, \field
> > +{cap.length_hi} fields MUST be contained within the declared bar.
> > +
> > +The \field{cap.id} MUST be unique for any one device instance.
> > +
> >  \subsubsection{PCI configuration access capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configuration access capability}
> >  
> >  The VIRTIO_PCI_CAP_PCI_CFG capability
> 
> Otherwise, looks good.
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

