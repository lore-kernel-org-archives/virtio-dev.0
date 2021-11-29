Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20210831135753.GG9207@quicinc.com> <20211125162349-mutt-send-email-mst@kernel.org>
 <CACGkMEun-obsMTLAGCCtKpqNxWHBKk_QC_6WywsVsFb7mfW9qw@mail.gmail.com> <87v90fiab1.fsf@redhat.com>
In-Reply-To: <87v90fiab1.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Nov 2021 10:40:37 +0800
Message-ID: <CACGkMEtk+VOuKm06mOz2PNWxfM3x5EG9iXiiu91rZzLfTituyQ@mail.gmail.com>
Subject: Re: [PATCH v3] virtio-mmio: Specify wait needed in driver during reset
Content-Type: text/plain; charset="UTF-8"
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Trilok Soni <tsoni@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Nov 26, 2021 at 4:35 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Fri, Nov 26 2021, Jason Wang <jasowang@redhat.com> wrote:
>
> > On Fri, Nov 26, 2021 at 5:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> On Tue, Aug 31, 2021 at 07:27:53PM +0530, Srivatsa Vaddagiri wrote:
> >> > Reset of a virtio-mmio device is initiated by writing 0 to its Status register.
> >> > In case of some devices, the reset operation itself may not be completed
> >> > by the time write instruction completes and hence such devices would require
> >> > drivers to wait on reset operation to complete before they proceed with
> >> > remaining steps of initialization.
> >> >
> >> > Update the specification to indicate which devices would need driver to block on
> >> > reset completion.
> >> >
> >> > Suggested-by: Jason Wang <jasowang@redhat.com>
> >> > Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
> >>
> >> I have been thinking about this some more.
> >>
> >>
> >> \section{Device Reset}\label{sec:Basic Facilities of a Virtio Device / Device Reset}
> >>
> >> The driver may want to initiate a device reset at various times; notably,
> >> it is required to do so during device initialization and device cleanup.
> >>
> >> The mechanism used by the driver to initiate the reset is transport specific.
> >>
> >> \devicenormative{\subsection}{Device Reset}{Basic Facilities of a Virtio Device / Device Reset}
> >>
> >> A device MUST reinitialize \field{device status} to 0 after receiving a reset.
> >>
> >> A device MUST NOT send notifications or interact with the queues after
> >> indicating completion of the reset by reinitializing \field{device status}
> >> to 0, until the driver re-initializes the device.
> >>
> >> \drivernormative{\subsection}{Device Reset}{Basic Facilities of a Virtio Device / Device Reset}
> >>
> >> The driver SHOULD consider a driver-initiated reset complete when it
> >> reads \field{device status} as 0.
> >
> > I wonder if we need to switch to using MUST here.
>
> I'm not quite sure what advantage s/SHOULD/MUST/ would give us here.

It means the driver needs to validate the completion. Using SHOULD
means for some reason it can be ignored. So considering mmio doesn't
do the validation now, maybe SHOULD be better. Or I wonder if we can
change to use

"The driver SHOULD consider a driver-initiated reset complete in a
transport specific way"?

>
> I don't think we want to force the driver to read back the device status
> to determine success if the transport already has a different way to
> signal completion. (I probably should undust my ccw reset clarification
> patch...)

Right.

>
> >> So I guess we can just fix the mmio driver to read status
> >> and declare victory? Do we really need all the spec changes?
> >
> > Probably, but one consideration of this change is to avoid the
> > breaking of existing devices. Maybe it's over engineering.
>
> How big is the chance that we use an unfixed driver with a device that
> would get it into trouble?

The problem I guess is that it would be impossible to fix the device sometime.

>The proposed change is pretty complex, I'd
> rather avoid it if possible.

I agree, I think it may as simple as adding things like:

"After writing 0 to status, the driver MUST wait for a read of status
to return 0 before reinitializing the device."

For the version bumping, it's probably because we don't have a
capability enumeration like pci, so there's no more choices.

Thanks

>

