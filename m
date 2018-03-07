Return-Path: virtio-return-2977-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 7 Mar 2018 16:13:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180307161346.3fd8e5e9.cohuck@redhat.com>
In-Reply-To: <20180307170904-mutt-send-email-mst@kernel.org>
References: <1519860484-7936-1-git-send-email-mst@redhat.com>
	<1519860484-7936-15-git-send-email-mst@redhat.com>
	<20180307121158.34829f6b.cohuck@redhat.com>
	<20180307155530-mutt-send-email-mst@kernel.org>
	<20180307154941.06a27742.cohuck@redhat.com>
	<20180307170904-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH v9 14/16] VIRTIO_F_NOTIFICATION_DATA: extra data to
 devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 7 Mar 2018 17:10:21 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Mar 07, 2018 at 03:49:41PM +0100, Cornelia Huck wrote:
> > On Wed, 7 Mar 2018 16:09:33 +0200
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Wed, Mar 07, 2018 at 12:11:58PM +0100, Cornelia Huck wrote:  
> > > > On Thu, 1 Mar 2018 01:31:37 +0200
> > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:  

> > > > > @@ -2340,12 +2455,22 @@ GPR  &   Input Value     & Output Value \\
> > > > >  \hline
> > > > >    2   &  Subchannel ID    & Host Cookie  \\
> > > > >  \hline
> > > > > -  3   & Virtqueue number  &              \\
> > > > > +  3   & Notification data &              \\
> > > > >  \hline
> > > > >    4   &   Host Cookie     &              \\
> > > > >  \hline
> > > > >  \end{tabular}
> > > > >  
> > > > > +When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> > > > > +the \field{Notification data} includes the Virtqueue number.
> > > > > +
> > > > > +When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> > > > > +the value has the following format:
> > > > > +\lstinputlisting{notifications.c}    
> > > > 
> > > > And we probably want to make this be explicitly.    
> > > 
> > > Are you sure?
> > > I looked at s390 code and it just uses VQ index in native
> > > endian-ness, so I kept this consistent.  
> > 
> > Native endian is always be on s390. The registers for the hypercall are
> > therefore always be.  
> 
> Oh I thought there's ppc LE now.

ppc is not s390 :)

I highly doubt that there will be non-be s390 ever (too much legacy
software).

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

