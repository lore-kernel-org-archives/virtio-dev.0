Return-Path: <mst@redhat.com>
Date: Wed, 15 Feb 2023 00:09:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] [PATCH v10 05/10] pci: add admin vq registers
 to virtio over pci
Message-ID: <20230215000911-mutt-send-email-mst@kernel.org>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-6-mst@redhat.com>
 <m2y1p1zrbc.fsf@oracle.com>
 <a40f3ad9-2a63-84c1-39d3-ddf36355d3b5@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <a40f3ad9-2a63-84c1-39d3-ddf36355d3b5@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: David Edmondson <david.edmondson@oracle.com>, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 15, 2023 at 02:53:34AM +0200, Max Gurtovoy wrote:
> 
> 
> On 13/02/2023 14:21, David Edmondson wrote:
> > 
> > On Thursday, 2023-02-09 at 07:13:48 -05, Michael S. Tsirkin wrote:
> > > @@ -1031,6 +1035,19 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> > >           This field exists only if VIRTIO_F_RING_RESET has been
> > >           negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
> > > +\item[\field{admin_queue_index}]
> > > +        The device uses this to report the index of the first administration virtqueue.
> > > +        This field is valid only if VIRTIO_F_ADMIN_VQ has been negotiated.
> > > +\item[\field{admin_queue_num}]
> > > +	The device uses this to report the number of the
> > > +	supported administration virtqueues.  Virtqueues with index
> > > +	between \field{admin_queue_index} and (\field{admin_queue_index} +
> > > +	\field{admin_queue_num}) inclusive serve as administration
> > > +	virtqueues.
> > > +	Thus the number of administration virtqueues equals
> > > +	(\field{admin_queue_num} + 1).
> > 
> > Really the number of queues is "admin_queue_num + 1"?
> > 
> > That seems ... odd.
> 
> It's not odd if we'll mention that this is a zero based value.
> MST, can you add it please for the next version ?

OK I can.

> 
> > 
> > > +	This field is valid only if VIRTIO_F_ADMIN_VQ has been
> > > +	negotiated.
> > >   \end{description}
> > >   \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
> > > @@ -1117,6 +1134,14 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> > >   were used before the queue reset.
> > >   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
> > > +If VIRTIO_F_ADMIN_VQ has been negotiated, and if the driver
> > > +configures any administration virtqueues, the driver MUST
> > > +configure the administration virtqueues using the index
> > > +in the range \field{admin_queue_index} to
> > > +\field{admin_queue_index} + \field{admin_queue_num} inclusive.
> > > +The driver MAY configure less administration virtqueues than
> > > +supported by the device.
> > > +
> > >   \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
> > >   The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
> > > @@ -7684,6 +7709,15 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> > >     \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device exposes one or more
> > >     administration virtqueues.
> > > +  At the moment this feature is only supported for devices using
> > > +  \ref{sec:Virtio Transport Options / Virtio Over PCI
> > > +	  Bus}~\nameref{sec:Virtio Transport Options / Virtio Over PCI Bus}
> > > +	  as the transport and is reserved for future use for
> > > +	  devices using other transports (see
> > > +	  \ref{drivernormative:Basic Facilities of a Virtio Device / Feature Bits}
> > > +	and
> > > +	\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits} for
> > > +	handling features reserved for future use.
> > >   \end{description}

