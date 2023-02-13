Return-Path: <mst@redhat.com>
Date: Mon, 13 Feb 2023 07:28:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] Re: [virtio-dev] [PATCH v10 01/10] virtio:
 document forward compatibility guarantees
Message-ID: <20230213072747-mutt-send-email-mst@kernel.org>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-2-mst@redhat.com>
 <m24jru3my1.fsf@oracle.com>
 <87edqtdb1z.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87edqtdb1z.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Edmondson <david.edmondson@oracle.com>, virtio-comment@lists.oasis-open.org, jasowang@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 13, 2023 at 01:06:32PM +0100, Cornelia Huck wrote:
> On Thu, Feb 09 2023, David Edmondson <david.edmondson@oracle.com> wrote:
> 
> > On Thursday, 2023-02-09 at 07:13:32 -05, Michael S. Tsirkin wrote:
> >> +In particular, this is
> >> +especially important for features limited to specific transports,
> >> +as enabling these for more transports in future versions of the
> >> +specification is highly likely to require changing the behaviour
> >> +from drivers and devices.  Drivers and devices supporting
> >
> > "changing the behaviour of" or "changed behaviour from" (prefer the
> > former).
> 
> Agreed, I'd prefer the former as well.
> 
> >
> >> +multiple transports need to carefully maintain per-transport
> >> +lists of allowed features.
> >> +
> >>  \drivernormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio Device / Feature Bits}
> >>  The driver MUST NOT accept a feature which the device did not offer,
> >>  and MUST NOT accept a feature which requires another feature which was
> >>  not accepted.
> >>  
> >> +The driver MUST validate the feature bits offered by the device.
> >> +The driver MUST ignore and MUST NOT accept any feature bit that is
> >> +\begin{itemize}
> >> +\item not described in this specification,
> >> +\item marked as reserved,
> >> +\item not supported for the specific transport,
> >
> > What does "supported" mean here? By the driver? By the specification in
> > respect of this transport?
> 
> Maybe "not specified for the specific transport"?

given in mmio and ccw sections we say things like
	+At this time, devices and drivers utilizing Virtio Over MMIO
	+do not support the following features:
I tend to agree.

> >
> >> +\item not defined for the device type.
> >> +\end{itemize}

