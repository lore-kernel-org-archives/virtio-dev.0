Return-Path: <mst@redhat.com>
Date: Thu, 4 Aug 2022 02:26:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] Re: [PATCH v6 4/5] Add admin_queue_index
 register to PCI common configuration structure
Message-ID: <20220804022046-mutt-send-email-mst@kernel.org>
References: <20220731154354.15698-1-mgurtovoy@nvidia.com>
 <20220731154354.15698-5-mgurtovoy@nvidia.com>
 <20220731170049-mutt-send-email-mst@kernel.org>
 <00153057-1332-047a-2ce7-20570cb6fe31@nvidia.com>
 <20220801020359-mutt-send-email-mst@kernel.org>
 <a2677ced-4d46-5fe5-a20a-f47091edf4c7@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <a2677ced-4d46-5fe5-a20a-f47091edf4c7@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org, eperezma@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Aug 04, 2022 at 03:01:44AM +0300, Max Gurtovoy wrote:
> 
> On 8/1/2022 9:13 AM, Michael S. Tsirkin wrote:
> > On Mon, Aug 01, 2022 at 03:11:58AM +0300, Max Gurtovoy wrote:
> > > On 8/1/2022 12:03 AM, Michael S. Tsirkin wrote:
> > > > On Sun, Jul 31, 2022 at 06:43:53PM +0300, Max Gurtovoy wrote:
> > > > > This new register will be used for querying the index of the admin
> > > > > virtqueue of a virtio device. To configure, reset or enable the admin
> > > > > virtqueue, the driver should follow existing queue configuration/setup
> > > > > sequence.
> > > > > 
> > > > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > Can you please at least add text to MMIO and CCW that drivers and
> > > > devices must not negotiate the new feature bit? Will help avoid confusion.
> > > why this is needed ? who will create a device and expose bits that it
> > > doesn't know how to implement.
> > Any multi-transport implementation actually.
> > For example, on a Linux guest the default is to add a feature bit to all
> > transports. Extra care is needed to actually only add it
> > to the PCI transport. With qemu, same applies to features in
> > include/hw/virtio/virtio.h.
> 
> I don't know how a reasonable driver will want to negotiate feature bits
> that a device didn't expose.

As a result of a bug.

> Please suggest whatever you want me to add and where.
> 
> I don't mind adding this but I don't want to waste cycle of review on that
> so I need exact guideline and not hints please.

Sure. So

"The driver MUST NOT negotiate VIRTIO_F_ADMIN_QUEUE. This is because
there is as yet no way for the driver to discover the index of the admin
queue."

in Device Initialization chapter.

And similarly add a device normative:

"The device MUST NOT offer VIRTIO_F_ADMIN_QUEUE. This is because
there is as yet no way to device to expose the index of the admin
queue."



> > 
> > > And if I'll add it, we might forget to remove it later on.
> > When we add the implementation I'm reasonably sure we won't forget to
> > remove text saying it's not implemented.
> 
> Ok.
> 
> 
> > 
> > > > > ---
> > > > >    content.tex | 10 ++++++++++
> > > > >    1 file changed, 10 insertions(+)
> > > > > 
> > > > > diff --git a/content.tex b/content.tex
> > > > > index c15423e..5fda1a0 100644
> > > > > --- a/content.tex
> > > > > +++ b/content.tex
> > > > > @@ -904,6 +904,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> > > > >            le64 queue_device;              /* read-write */
> > > > >            le16 queue_notify_data;         /* read-only for driver */
> > > > >            le16 queue_reset;               /* read-write */
> > > > > +
> > > > > +        /* About admin virtqueue. */
> > > > > +        le16 admin_queue_index;         /* read-only for driver */
> > > > >    };
> > > > >    \end{lstlisting}
> > > > > @@ -989,6 +992,10 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> > > > >            This field exists only if VIRTIO_F_RING_RESET has been
> > > > >            negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
> > > > > +\item[\field{admin_queue_index}]
> > > > > +        The device uses this to report the index of the admin virtqueue.
> > > > > +        This field always exists. Its value is valid only if VIRTIO_F_ADMIN_VQ has been negotiated.
> > > > > +
> > > > >    \end{description}
> > > > >    \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
> > > > we have a mess with this exists versus valid. I think exists is the same
> > > the bigest mess that we have is for things like ring_reset that are
> > > optionally exist according to bit negotiation.
> > I think this optionally exist does not mean much, just that
> > it should not be accessed
> 
> If I understand the word "exist" translation correctly, it doesn't mean what
> you said about "shouldn't be accessed".
> 
> > > about valid - the driver shouldn't even look on registers that it didn't
> > > negotiated it's feature bits. There is no reason to do so.
> > > So yes, there is a mess but not in our proposal.
> > Right. I propose removing "This field always exists." just
> > say that it's valid with VIRTIO_F_ADMIN_VQ.
> 
> Why removing ? does it exist always or not ?

It doesn't. For example existing devices do not have it.


> > 
> > > > is valid personally. Do others object if we say same as for reset here?
> > > > Not a big deal either way, we need to clean this up later.
> > > > 
> > > > > @@ -1075,6 +1082,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> > > > >    were used before the queue reset.
> > > > >    (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
> > > > > +For configuring the admin virtqueue, the driver MUST use the value of \field{admin_queue_index}.
> > > > > +For more details on virtqueue configuration see section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtqueue Configuration}.
> > > > > +
> > > > >    \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
> > > > >    The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
> > > > > -- 
> > > > > 2.21.0
> > 
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> > 
> > In order to verify user consent to the Feedback License terms and
> > to minimize spam in the list archive, subscription is required
> > before posting.
> > 
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.oasis-open.org%2Farchives%2Fvirtio-comment%2F&amp;data=05%7C01%7Cmgurtovoy%40nvidia.com%7C46caf90d77cb4e2e7d1b08da7384fbe5%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637949312238253496%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=72o5SFbI1Ai5twIQXF0Onn2TTorpuIlWoqp46tpUgrQ%3D&amp;reserved=0
> > Feedback License: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.oasis-open.org%2Fwho%2Fipr%2Ffeedback_license.pdf&amp;data=05%7C01%7Cmgurtovoy%40nvidia.com%7C46caf90d77cb4e2e7d1b08da7384fbe5%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637949312238253496%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=7%2FdpXHFFpA7j97vIqLFXfaVQMj1FmDX2Ldwwzytpuuw%3D&amp;reserved=0
> > List Guidelines: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.oasis-open.org%2Fpolicies-guidelines%2Fmailing-lists&amp;data=05%7C01%7Cmgurtovoy%40nvidia.com%7C46caf90d77cb4e2e7d1b08da7384fbe5%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637949312238253496%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=lN2X%2BC%2BoHvd90YL%2BSf3FSleiNJYZnfTqRWSdDpK2wAc%3D&amp;reserved=0
> > Committee: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.oasis-open.org%2Fcommittees%2Fvirtio%2F&amp;data=05%7C01%7Cmgurtovoy%40nvidia.com%7C46caf90d77cb4e2e7d1b08da7384fbe5%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637949312238253496%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=5FFookod06loAfQ8uGp3HmeuEUdP2lurXWtPNOnCtNY%3D&amp;reserved=0
> > Join OASIS: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.oasis-open.org%2Fjoin%2F&amp;data=05%7C01%7Cmgurtovoy%40nvidia.com%7C46caf90d77cb4e2e7d1b08da7384fbe5%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637949312238253496%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=1OJe%2BI1%2FsWYMIaM0PIZjMKmcC%2FpGAoOkHr%2Bi4E4AJOE%3D&amp;reserved=0
> > 

