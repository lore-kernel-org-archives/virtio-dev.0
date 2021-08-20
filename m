Return-Path: <mst@redhat.com>
Date: Fri, 20 Aug 2021 07:18:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio-mmio: Specify wait needed in driver during
 reset
Message-ID: <20210820071635-mutt-send-email-mst@kernel.org>
References: <20210813145351.GA5604@quicinc.com>
 <87zgtgrt2n.fsf@redhat.com>
 <729bdaa3-d5c8-8c4c-4eb0-6f2b135d31a9@redhat.com>
 <87wnojs1kx.fsf@redhat.com>
 <CACGkMEtUq6gjuEYQE2tpiB0jjbDHXUtPRX1HXJdTWxjko=1ZwA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtUq6gjuEYQE2tpiB0jjbDHXUtPRX1HXJdTWxjko=1ZwA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
To: Jason Wang <jasowang@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Aug 20, 2021 at 11:48:04AM +0800, Jason Wang wrote:
> On Wed, Aug 18, 2021 at 2:34 PM Cornelia Huck <cohuck@redhat.com> wrote:
> >
> > On Wed, Aug 18 2021, Jason Wang <jasowang@redhat.com> wrote:
> >
> > > 在 2021/8/17 下午11:26, Cornelia Huck 写道:
> > >> On Fri, Aug 13 2021, Srivatsa Vaddagiri <quic_svaddagi@quicinc.com> wrote:
> > >>
> > >>> Reset of a virtio-mmio device is initiated by writing 0 to its Status
> > >>> register. The reset operation itself may or may not be completed by the time
> > >>> write instruction completes. For devices that are emulated in software, writes
> > >>> to Status register are trapped and resumed only after the reset operation is
> > >>> complete. Thus a driver can be assured of reset completion as soon as its write
> > >>> completes. That may not be however true in other cases, such as when virtio-mmio
> > >>> devices implemented directly in hardware. Driver's write to Status register in
> > >>> such case could complete before the device reset operation is completed.
> > >>>
> > >>> Update the specification to indicate when a driver may need to poll for reset
> > >>> completion before going ahead with the remaining initialization steps.
> > >>>
> > >>> Suggested-by: Jason Wang <jasowang@redhat.com>
> > >>> Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
> > >>>
> > >>> ---
> > >>> V2->V1:
> > >>> - Use version 0x3 as an indication for drivers to poll for reset completion
> > >>>    (rather than base it on a new feature bit)
> > >>>
> > >>> Previous version can be found at:
> > >>>
> > >>> https://lists.oasis-open.org/archives/virtio-dev/202107/msg00168.html
> > >>>
> > >>>   content.tex | 11 +++++++----
> > >>>   1 file changed, 7 insertions(+), 4 deletions(-)
> > >>>
> > >>> diff --git a/content.tex b/content.tex
> > >>> index 7cec1c3..b6b30a0 100644
> > >>> --- a/content.tex
> > >>> +++ b/content.tex
> > >>> @@ -1730,9 +1730,9 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
> > >>>     }
> > >>>     \hline
> > >>>     \mmioreg{Version}{Device version number}{0x004}{R}{%
> > >>> -    0x2.
> > >>> +    0x3.
> > >>>       \begin{note}
> > >>> -      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}) used 0x1.
> > >>> +      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}) used 0x1. Devices that do not require drivers to poll for reset completion can use 0x2. See \ref{devicenormative:Virtio Transport Options / Virtio Over MMIO / MMIO Device Register Layout} for more details.
> > >>>       \end{note}
> > >>>     }
> > >>>     \hline
> > >>> @@ -1916,7 +1916,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
> > >>>
> > >>>   The device MUST return 0x74726976 in \field{MagicValue}.
> > >>>
> > >>> -The device MUST return value 0x2 in \field{Version}.
> > >>> +The device MUST return either value 0x3 or 0x2 in \field{Version} based on its reset behavior. Drivers trigger reset of a device by writing 0 to \field{Status}. The reset operation itself may or may not be completed by the time write operation is complete. Devices whose reset operation completes synchronously with the write operation are allowed to return value of 0x2 for \field{Version}. Other devices, whose reset operation can be incomplete by the time write operation completes MUST return value 0x3 as an indication for drivers to poll for reset completion.
> > >> Maybe I'm overthining this, but might that suddenly render some existing
> > >> device non-compliant? IIUC, we never mandated reset to be completed when
> > >> the write was completed, only kind of implied it. An existing device
> > >> will have version 2, but it might not be quite finished with reset after
> > >> the status write yet.
> > >
> > >
> > > Won't this break the driver probe/registering?
> >
> > It might be racy, I guess; I'm not sure how other device or driver
> > implementations work.
> 
> PCI forces a re-read like:
> 
>         /* 0 status means a reset. */
>         vp_modern_set_status(mdev, 0);
>         /* After writing 0 to device_status, the driver MUST wait for a read of
>          * device_status to return 0 before reinitializing the device.
>          * This will flush out the status write, and flush in device writes,
>          * including MSI-X interrupts, if any.
>          */
>         while (vp_modern_get_status(mdev))
>                 msleep(1);
>         /* Flush pending VQ/configuration callbacks. */
>         vp_synchronize_vectors(vdev);

Something to fix as we deal with suprise removal, BTW.

> 
> So it's fine.
> 
> Thanks
> 
> >
> > >
> > > int register_virtio_device(struct virtio_device *dev)
> > >
> > > {
> > >
> > > ...
> > >
> > >          /* We always start by resetting the device, in case a previous
> > >           * driver messed it up.  This also tests that code path a
> > > little. */
> > >          dev->config->reset(dev);
> > >
> > >          /* Acknowledge that we've seen the device. */
> > >          virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> > >
> > > }
> > >
> > > Thanks
> > >
> > >
> > >>
> >

