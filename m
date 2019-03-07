Return-Path: virtio-comment-return-701-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Thu, 7 Mar 2019 18:24:57 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190307182457.GM2811@work-vm>
References: <20190304132531.10507-1-dgilbert@redhat.com>
 <20190304132531.10507-3-dgilbert@redhat.com>
 <20190307162811.GI2843@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307162811.GI2843@stefanha-x1.localdomain>
Subject: [virtio-comment] Re: [PATCH v3 2/3] shared memory: Define PCI capability
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Mon, Mar 04, 2019 at 01:25:30PM +0000, Dr. David Alan Gilbert (git) wrote:
> > +\begin{lstlisting}
> > +struct virtio_pci_shm_cap {
> > +        struct virtio_pci_cap cap;
> > +        u32 offset_hi;
> > +        u32 length_hi;
> > +        u8  id;
> > +};
> > +\end{lstlisting}
> 
> Are there any alignment requirements for PCI capability structures?

The PCI spec says 'Each capability must be DWORD aligned. '

> This struct ends with a u8, which might be a problem if 32-bit or 64-bit
> alignemnt is required by something.

It doesn't seem to be unusual, for example the MSI capability structure
seems to be 10 or 14 bytes even with the DWORD alignement restriction
for the start of it.


> Otherwise:
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks,

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

