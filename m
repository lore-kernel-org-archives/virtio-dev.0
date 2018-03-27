Return-Path: virtio-return-3027-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 27 Mar 2018 16:15:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180327161528.0d7fb268.cohuck@redhat.com>
In-Reply-To: <20180327164832-mutt-send-email-mst@kernel.org>
References: <1522119462-48265-1-git-send-email-mst@redhat.com>
	<20180327113116.39a09c23.cohuck@redhat.com>
	<20180327164832-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH v11] VIRTIO_F_NOTIFICATION_DATA: extra data to devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 27 Mar 2018 16:51:18 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Mar 27, 2018 at 11:31:16AM +0200, Cornelia Huck wrote:
> > On Tue, 27 Mar 2018 05:59:27 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > Some devices benefit from ability to find out the number of available
> > > descriptors in the ring: for efficiency or as a debugging aid.
> > > 
> > > To help with these optimizations, add a new feature:
> > > VIRTIO_F_NOTIFICATION_DATA. When negotiated, driver notifications to the
> > > device include this extra information.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > > 
> > > v10 -> v11:
> > >         drop mention of interrupts: current proposal does not include
> > >         this interrupt related information
> > > 	drop unrelated introduction sections
> > > 
> > >  content.tex | 139 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 133 insertions(+), 6 deletions(-)

> > > @@ -1500,8 +1602,19 @@ All register values are organized as Little Endian.
> > >    }
> > >    \hline 
> > >    \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
> > > -    Writing a queue index to this register notifies the device that
> > > -    there are new buffers to process in the queue.
> > > +    Writing a value this register notifies the device that
> > > +    there are new buffers to process in a queue.
> > > +
> > > +    When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> > > +    the value written is the queue index.
> > > +
> > > +    When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> > > +    the value has the following format:
> > > +
> > > +    \lstinputlisting{notifications.c}  
> > 
> > Don't you need to write this down explicitly, as in the pci case?  
> 
> Are you asking why it's in a separate file here?
> latex forces me to use lstinputlisting to insert listing
> within a table.

I also don't see where notifications.c is.

> 
> > > +
> > > +    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}
> > > +    for the definition of the components.
> > >    }
> > >    \hline 
> > >    \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
> > > @@ -2340,12 +2453,22 @@ GPR  &   Input Value     & Output Value \\
> > >  \hline
> > >    2   &  Subchannel ID    & Host Cookie  \\
> > >  \hline
> > > -  3   & Virtqueue number  &              \\
> > > +  3   & Notification data &              \\
> > >  \hline
> > >    4   &   Host Cookie     &              \\
> > >  \hline
> > >  \end{tabular}
> > >  
> > > +When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> > > +the \field{Notification data} includes the Virtqueue number.  
> > 
> > s/includes/contains/
> >   
> > > +
> > > +When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> > > +the value has the following format:
> > > +\lstinputlisting{notifications.c}  
> > 
> > This also needs to be spelled out explicitly (in big endian format).  
> 
> Ah you are asking for two files, le-notifications.c and
> be-notifications.c - is that right?

That would make sense (you probably could use le-notifications.c for pci
as well, right?)

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

