Return-Path: <virtio-dev-return-9396-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A6A0B98646C
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Apr 2022 12:32:29 +0000 (UTC)
Date: Tue, 5 Apr 2022 08:32:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220405083048-mutt-send-email-mst@kernel.org>
References: <20220302155608.24189-1-mgurtovoy@nvidia.com>
 <20220302155608.24189-5-mgurtovoy@nvidia.com>
 <20220404085828-mutt-send-email-mst@kernel.org>
 <5677b877-129a-d481-ea5d-7be6f0ccc66a@nvidia.com>
 <20220404120950-mutt-send-email-mst@kernel.org>
 <c071a955-aeb3-4cca-5c8c-963d1f6e8f39@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <c071a955-aeb3-4cca-5c8c-963d1f6e8f39@nvidia.com>
Subject: [virtio-dev] Re: [PATCH v1 4/5] Add virtio Admin virtqueue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Apr 05, 2022 at 02:13:30PM +0300, Max Gurtovoy wrote:
> 
> On 4/4/2022 7:13 PM, Michael S. Tsirkin wrote:
> > On Mon, Apr 04, 2022 at 06:49:19PM +0300, Max Gurtovoy wrote:
> > > On 4/4/2022 4:02 PM, Michael S. Tsirkin wrote:
> > > > On Wed, Mar 02, 2022 at 05:56:07PM +0200, Max Gurtovoy wrote:
> > > > > In one of the many use cases a user wants to manipulate features and
> > > > > configuration of the virtio devices regardless of the device type
> > > > > (net/block/console). Some of this configuration is generic enough. i.e
> > > > > Number of MSI-X vectors of a virtio PCI VF device. There is a need to do
> > > > > such features query and manipulation by its parent PCI PF. For that the
> > > > > Admin Command Set introduced. The Admin virtqueue will be the first
> > > > > management interface to issue Admin commands.
> > > > > 
> > > > > Currently virtio specification defines control virtqueue to manipulate
> > > > > features and configuration of the device it operates on. However,
> > > > > control virtqueue commands are device type specific, which makes it very
> > > > > difficult to extend for device agnostic commands.
> > > > > 
> > > > > To support this requirement in elegant way, this patch introduces a new
> > > > > admin virtqueue interface.
> > > > > 
> > > > > Manipulate features via admin virtqueue is asynchronous, scalable, easy
> > > > > to extend and doesn't require additional and expensive on-die resources
> > > > > to be allocated for every new feature that will be added in the future.
> > > > > 
> > > > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > ---
> > > > >    admin.tex       | 17 +++++++++++++++++
> > > > >    conformance.tex |  1 +
> > > > >    content.tex     |  6 ++++--
> > > > >    3 files changed, 22 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/admin.tex b/admin.tex
> > > > > index 9a8969b..ed9f6bd 100644
> > > > > --- a/admin.tex
> > > > > +++ b/admin.tex
> > > > > @@ -158,3 +158,20 @@ \subsection{VIRTIO ADMIN DEVICE INFO command}\label{sec:Basic Facilities of a Vi
> > > > >    specification and can't be equal to zero. If bit 0 is not set, the driver will ignore \field{vf_number}.}
> > > > >    \end{note}
> > > > > +\section{Admin Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues}
> > > > > +
> > > > > +An admin virtqueue is a management interface of a device that can be used to send administrative
> > > > > +commands to manipulate various features of the device and/or to manipulate
> > > > > +various features, if possible, of another device within the same virtio subsystem
> > > > > +(see \ref{sec:Introduction / Definitions / virtio subsystem}).
> > > > > +
> > > > > +An admin virtqueue exists for a certain device if VIRTIO_F_ADMIN_VQ is
> > > > > +negotiated. The index of the admin virtqueue is exposed by the device in a
> > > > > +transport specific manner.
> > > > > +
> > > > > +If VIRTIO_F_ADMIN_VQ has been negotiated, the driver will use the admin virtqueue to send all admin commands.
> > > > > +
> > > > Add links please, and explain how do commands map to VQ buffers.
> > > I added a link to the definitions section and I'll replace it with the new
> > > proposed terminology chapter.
> > That explains what a subsystem is.
> 
> I'm confused. Are we staying with "subsystem" or moving to "group" ? I
> prefer to stay.


I prefer renaming. you asked which links to add. I answered that you
have a link to definition of subsystem or whatever it is named,
and that is not enough imo.

> 
> > 
> > > What other links should be added ?
> > A link to where it's explained how do admin commands look.
> 
> ok.
> 
> > 
> > > > E.g. I guess device readable an output buffer and device writeable an input
> > > > buffer...
> > > The buffers transfer from/to device/driver are using existing mechanism.
> > > Nothing new here.
> > > 
> > > It will just repeat existing chapters.
> > There could be some repetition but it's necessary to make things
> > explicit.  Look at e.g.
> > subsection{Device Operation}\label{sec:Device Types / Block Device / Device Operation}
> > as a lightweight example for how to explain it.
> 
> Ok, I'll check it.
> 
> The proposal is not small now, and I prefer not repeat on existing
> mechanisms in the spec.
> 
> Maybe I'll add a sentence or two.

Yea, like that. Not a full explanation.


> > 
> > 
> > 
> > 
> > > > > +\devicenormative{\subsection}{Admin Virtqueues}{Basic Facilities of a Virtio Device / Admin Virtqueues}
> > > > > +A device that advertises VIRTIO_F_ADMIN_VQ capability MUST support all the mandatory admin commands.
> > > > > +
> > > > > +A device that advertises VIRTIO_F_ADMIN_VQ capability MAY support one or more optional admin commands.
> > > > > diff --git a/conformance.tex b/conformance.tex
> > > > > index 42f8537..129831c 100644
> > > > > --- a/conformance.tex
> > > > > +++ b/conformance.tex
> > > > > @@ -341,6 +341,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> > > > >    \item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / Available Buffer Notification Suppression}
> > > > >    \item \ref{devicenormative:Basic Facilities of a Virtio Device / Shared Memory Regions}
> > > > >    \item \ref{devicenormative:Reserved Feature Bits}
> > > > > +\item \ref{devicenormative:Basic Facilities of a Virtio Device / Admin Virtqueues}
> > > > >    \end{itemize}
> > > > >    \conformance{\subsection}{PCI Device Conformance}\label{sec:Conformance / Device Conformance / PCI Device Conformance}
> > > > > diff --git a/content.tex b/content.tex
> > > > > index 2e1df84..163cb34 100644
> > > > > --- a/content.tex
> > > > > +++ b/content.tex
> > > > > @@ -99,10 +99,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
> > > > >    \begin{description}
> > > > >    \item[0 to 23, and 50 to 127] Feature bits for the specific device type
> > > > > -\item[24 to 40] Feature bits reserved for extensions to the queue and
> > > > > +\item[24 to 41] Feature bits reserved for extensions to the queue and
> > > > >      feature negotiation mechanisms
> > > > > -\item[41 to 49, and 128 and above] Feature bits reserved for future extensions.
> > > > > +\item[42 to 49, and 128 and above] Feature bits reserved for future extensions.
> > > > >    \end{description}
> > > > >    \begin{note}
> > > > > @@ -6849,6 +6849,8 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> > > > >      that the driver can reset a queue individually.
> > > > >      See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
> > > > > +  \item[VIRTIO_F_ADMIN_VQ (41)] This feature indicates that an administration virtqueue is supported.
> > > > > +
> > > > >    \end{description}
> > > > >    \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> > > > > -- 
> > > > > 2.21.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

