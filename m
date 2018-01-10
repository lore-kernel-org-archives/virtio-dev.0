Return-Path: virtio-return-2828-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 10 Jan 2018 16:39:29 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180110163923-mutt-send-email-mst@kernel.org>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
 <1515577653-9336-5-git-send-email-mst@redhat.com>
 <20180110134942.nz6nby2cu4uidj42@dhcp-192-241.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110134942.nz6nby2cu4uidj42@dhcp-192-241.str.redhat.com>
Subject: [virtio] Re: [virtio-dev] [PATCH v6 4/5] packed virtqueues: more efficient
 virtqueue layout
To: Jens Freimann <jfreimann@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 10, 2018 at 02:49:42PM +0100, Jens Freimann wrote:
> On Wed, Jan 10, 2018 at 11:47:58AM +0200, Michael S. Tsirkin wrote:
> [...]
> > +\subsection{Supplying Buffers to The Device}\label{sec:Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device}
> > +
> > +The driver offers buffers to one of the device's virtqueues as follows:
> > +
> > +\begin{enumerate}
> > +\item The driver places the buffer into free descriptor in the Descriptor Ring.
> > +
> > +\item The driver performs a suitable memory barrier to ensure that it updates
> > +  the descriptor(s) before checking for notification suppression.
> > +
> > +\item If notifications are not suppressed, the driver notifies the device
> > +    of the new available buffers.
> > +\end{enumerate}
> > +
> > +What follows is the requirements of each stage in more detail.
> > +
> > +\subsubsection{Placing Available Buffers Into The Descriptor Ring}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Placing Available Buffers Into The Descriptor Ring}
> > +
> > +For each buffer element, b:
> > +
> > +\begin{enumerate}
> > +\item Get the next descriptor table entry, d
> > +\item Get the next free buffer id value
> > +\item Set \field{d.addr} to the physical address of the start of b
> > +\item Set \field{d.len} to the length of b.
> > +\item Set \field{d.id} to the buffer id
> > +\item Calculate the flags as follows:
> > +\begin{enumerate}
> > +\item If b is device-writable, set the VIRTQ_DESC_F_WRITE bit to 1, otherwise 0
> > +\item Set VIRTQ_DESC_F_AVAIL bit to the current value of the Available Ring Wrap Counter
> > +\item Set VIRTQ_DESC_F_AVAIL bit to inverse value
> 
> This should be "Set VIRTQ_DESC_F_USED bit to inverse value, no?
> 
> regards,
> Jens

Right.

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

