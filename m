Return-Path: virtio-return-2975-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 7 Mar 2018 15:49:41 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180307154941.06a27742.cohuck@redhat.com>
In-Reply-To: <20180307155530-mutt-send-email-mst@kernel.org>
References: <1519860484-7936-1-git-send-email-mst@redhat.com>
	<1519860484-7936-15-git-send-email-mst@redhat.com>
	<20180307121158.34829f6b.cohuck@redhat.com>
	<20180307155530-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH v9 14/16] VIRTIO_F_NOTIFICATION_DATA: extra data to
 devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 7 Mar 2018 16:09:33 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Mar 07, 2018 at 12:11:58PM +0100, Cornelia Huck wrote:
> > On Thu, 1 Mar 2018 01:31:37 +0200
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:

> > > +When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> > > +the driver notifies the device by writing the following
> > > +32-bit value to the Queue Notify address:
> > > +\begin{lstlisting}
> > > +le32 vqn : 16,
> > > +     next_off : 15,
> > > +     next_wrap : 1;  
> > 
> > Don't we want to write this as
> > 
> > le32 vqn : 16;
> > le32 next_off :15;
> > le32 next_wrap : 1;
> > 
> > ?  
> 
> Same thing in C, but would be more confusing IMHO since it will be up to
> the reader to figure out which fields comprise the 32 bit integer.

It looked weird to me. Other opinions?

> > > @@ -2340,12 +2455,22 @@ GPR  &   Input Value     & Output Value \\
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
> > > +
> > > +When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> > > +the value has the following format:
> > > +\lstinputlisting{notifications.c}  
> > 
> > And we probably want to make this be explicitly.  
> 
> Are you sure?
> I looked at s390 code and it just uses VQ index in native
> endian-ness, so I kept this consistent.

Native endian is always be on s390. The registers for the hypercall are
therefore always be.

> > > diff --git a/notifications.c b/notifications.c
> > > new file mode 100644
> > > index 0000000..2ae96d4
> > > --- /dev/null
> > > +++ b/notifications.c
> > > @@ -0,0 +1,3 @@
> > > +u32 vqn : 16,
> > > +    next_off : 15,
> > > +    next_wrap : 1;  
> > 
> > I'm wondering how useful the u32 notation is here.  
> 
> It says vqn in low 16 bits of a 32 bit counter, so e.g.
> on LE system byte 0 and on BE system byte 3.
> Compare to 
> 
> be32 vqn : 16,
>      next_off : 15,
>      next_wrap : 1;
> 
> where we say it's in low 16 bits of a 32 bit BE integer,
> so byte 3.

I was referring to the endianness: AFAICS, pci and mmio want le, ccw
wants be. If we want to be explicit, notifications.c does not make much
sense IMO.

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

