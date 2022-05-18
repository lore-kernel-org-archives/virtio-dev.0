Return-Path: <mst@redhat.com>
Date: Wed, 18 May 2022 19:56:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 4/7] Introduce virtio admin virtqueue
Message-ID: <20220518195619-mutt-send-email-mst@kernel.org>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-5-mgurtovoy@nvidia.com>
 <20220515105931-mutt-send-email-mst@kernel.org>
 <3da66392-d46c-6e44-a9e6-cfb50d6dbd3b@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <3da66392-d46c-6e44-a9e6-cfb50d6dbd3b@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, May 18, 2022 at 05:37:11PM +0300, Max Gurtovoy wrote:
> 
> On 5/15/2022 5:59 PM, Michael S. Tsirkin wrote:
> > On Wed, Apr 27, 2022 at 01:58:21AM +0300, Max Gurtovoy wrote:
> > > In one of the many use cases a user wants to manipulate features and
> > > configuration of the virtio devices regardless of the device type
> > > (net/block/console). For that the admin command set introduced. The
> > > admin virtqueue will be the first management interface to issue admin
> > > commands.
> > > 
> > > Currently virtio specification defines control virtqueue to manipulate
> > > features and configuration of the device it operates on. However,
> > > control virtqueue commands are device type specific, which makes it very
> > > difficult to extend for device agnostic commands.
> > > 
> > > To support this requirement in elegant way, this patch introduces a new
> > > admin virtqueue interface.
> > > 
> > > Manipulate features via admin virtqueue is asynchronous, scalable, easy
> > > to extend and doesn't require additional and expensive on-die resources
> > > to be allocated for every new feature that will be added in the future.
> > > 
> > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > ---
> > >   admin.tex       | 17 +++++++++++++++++
> > >   conformance.tex |  1 +
> > >   content.tex     |  6 ++++--
> > >   3 files changed, 22 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/admin.tex b/admin.tex
> > > index f816c3b..d09683d 100644
> > > --- a/admin.tex
> > > +++ b/admin.tex
> > > @@ -131,3 +131,20 @@ \subsection{VIRTIO ADMIN DEVICE CAPS ACCEPT command}\label{sec:Basic Facilities
> > >          u8 reserved[112];
> > >   };
> > >   \end{lstlisting}
> > > +
> > > +\section{Admin Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues}
> > > +
> > > +An admin virtqueue is a management interface of a device that can be used to send administrative
> > > +commands (see \ref{sec:Basic Facilities of a Virtio Device / Administration command set}) to manipulate
> > > +various features of the device and/or to manipulate various features, if possible, of another device.
> > > +
> > > +An admin virtqueue exists for a certain device if VIRTIO_F_ADMIN_VQ feature is
> > > +negotiated. The index of the admin virtqueue is exposed by the device in a
> > > +transport specific manner.
> > > +
> > > +If VIRTIO_F_ADMIN_VQ has been negotiated, the driver will use the admin virtqueue to send all admin commands.
> > > +
> > > +\devicenormative{\subsection}{Admin Virtqueues}{Basic Facilities of a Virtio Device / Admin Virtqueues}
> > > +A device that advertises VIRTIO_F_ADMIN_VQ capability MUST support all the mandatory admin commands.
> > 
> > don't see where these are defined.
> 
> In the command table (M - mandatory, O - optional)
> 

Add a link then.

> > 
> > > +
> > > +A device that advertises VIRTIO_F_ADMIN_VQ capability MAY support one or more optional admin commands.
> > > diff --git a/conformance.tex b/conformance.tex
> > > index 9807c30..3c7b7bc 100644
> > > --- a/conformance.tex
> > > +++ b/conformance.tex
> > > @@ -342,6 +342,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> > >   \item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / Available Buffer Notification Suppression}
> > >   \item \ref{devicenormative:Basic Facilities of a Virtio Device / Shared Memory Regions}
> > >   \item \ref{devicenormative:Reserved Feature Bits}
> > > +\item \ref{devicenormative:Basic Facilities of a Virtio Device / Admin Virtqueues}
> > >   \end{itemize}
> > >   \conformance{\subsection}{PCI Device Conformance}\label{sec:Conformance / Device Conformance / PCI Device Conformance}
> > > diff --git a/content.tex b/content.tex
> > > index 2e1df84..163cb34 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -99,10 +99,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
> > >   \begin{description}
> > >   \item[0 to 23, and 50 to 127] Feature bits for the specific device type
> > > -\item[24 to 40] Feature bits reserved for extensions to the queue and
> > > +\item[24 to 41] Feature bits reserved for extensions to the queue and
> > >     feature negotiation mechanisms
> > > -\item[41 to 49, and 128 and above] Feature bits reserved for future extensions.
> > > +\item[42 to 49, and 128 and above] Feature bits reserved for future extensions.
> > >   \end{description}
> > >   \begin{note}
> > > @@ -6849,6 +6849,8 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> > >     that the driver can reset a queue individually.
> > >     See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
> > > +  \item[VIRTIO_F_ADMIN_VQ (41)] This feature indicates that an administration virtqueue is supported.
> > > +
> > >   \end{description}
> > >   \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> > > -- 
> > > 2.21.0

