Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20210813145351.GA5604@quicinc.com> <20210816010725-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210816010725-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Aug 2021 12:01:18 +0800
Message-ID: <CACGkMEvW+M0rkpu4w0OCysdAmVP95pwa1Qrca6CuDkd2NKE=yw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-mmio: Specify wait needed in driver during reset
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, Cornelia Huck <cohuck@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Aug 16, 2021 at 1:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Aug 13, 2021 at 08:23:51PM +0530, Srivatsa Vaddagiri wrote:
> > Reset of a virtio-mmio device is initiated by writing 0 to its Status
> > register. The reset operation itself may or may not be completed by the=
 time
> > write instruction completes. For devices that are emulated in software,=
 writes
> > to Status register are trapped and resumed only after the reset operati=
on is
> > complete. Thus a driver can be assured of reset completion as soon as i=
ts write
> > completes. That may not be however true in other cases, such as when vi=
rtio-mmio
> > devices implemented directly in hardware. Driver's write to Status regi=
ster in
> > such case could complete before the device reset operation is completed=
.
> >
> > Update the specification to indicate when a driver may need to poll for=
 reset
> > completion before going ahead with the remaining initialization steps.
> >
> > Suggested-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
> >
> > ---
> > V2->V1:
> > - Use version 0x3 as an indication for drivers to poll for reset comple=
tion
> >   (rather than base it on a new feature bit)
> >
> > Previous version can be found at:
> >
> > https://lists.oasis-open.org/archives/virtio-dev/202107/msg00168.html
> >
> >  content.tex | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/content.tex b/content.tex
> > index 7cec1c3..b6b30a0 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -1730,9 +1730,9 @@ \subsection{MMIO Device Register Layout}\label{se=
c:Virtio Transport Options / Vi
> >    }
> >    \hline
> >    \mmioreg{Version}{Device version number}{0x004}{R}{%
> > -    0x2.
> > +    0x3.
> >      \begin{note}
> > -      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio O=
ver MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio=
 Over MMIO / Legacy interface}) used 0x1.
> > +      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio O=
ver MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio=
 Over MMIO / Legacy interface}) used 0x1. Devices that do not require drive=
rs to poll for reset completion can use 0x2. See \ref{devicenormative:Virti=
o Transport Options / Virtio Over MMIO / MMIO Device Register Layout} for m=
ore details.
> >      \end{note}
> >    }
> >    \hline
> > @@ -1916,7 +1916,7 @@ \subsection{MMIO Device Register Layout}\label{se=
c:Virtio Transport Options / Vi
> >
> >  The device MUST return 0x74726976 in \field{MagicValue}.
> >
> > -The device MUST return value 0x2 in \field{Version}.
> > +The device MUST return either value 0x3 or 0x2 in \field{Version} base=
d on its reset behavior. Drivers trigger reset of a device by writing 0 to =
\field{Status}. The reset operation itself may or may not be completed by t=
he time write operation is complete. Devices whose reset operation complete=
s synchronously with the write operation are allowed to return value of 0x2=
 for \field{Version}. Other devices, whose reset operation can be incomplet=
e by the time write operation completes MUST return value 0x3 as an indicat=
ion for drivers to poll for reset completion.
> >
> >  The device MUST present each event by setting the corresponding bit in=
 \field{InterruptStatus} from the
> >  moment it takes place, until the driver acknowledges the interrupt
> > @@ -1947,12 +1947,15 @@ \subsection{MMIO Device Register Layout}\label{=
sec:Virtio Transport Options / Vi
> >  The driver MUST ignore a device with \field{MagicValue} which is not 0=
x74726976,
> >  although it MAY report an error.
> >
> > -The driver MUST ignore a device with \field{Version} which is not 0x2,
> > +The driver MUST ignore a device with \field{Version} which is neither =
0x2 nor 0x3,
> >  although it MAY report an error.
> >
> >  The driver MUST ignore a device with \field{DeviceID} 0x0,
> >  but MUST NOT report any error.
> >
> > +After writing 0 to \field{Status}, which triggers a reset of device, t=
he driver MUST wait for a read of
> > +\field{Status} to return 0 before proceeding with the remaining steps =
of initializing the device.
>
> I know you copied this from pci but looking at PCI now, I think
> this is not great there either.
>
> 1.  This is IMHO too opaque in that we did not say driver should read.
>
> E.g. after writing 0 to Status and before reading any fields, the driver
> MUST read Status and wait for a read etc.
>
> also would not just a read be sufficient? Is there a case for device to r=
eturn any value
> other than 0 to signal "reset in progress"?

I'm not sure what case it can help. What is doing here is no worse
than the way PCI deal with it.

>
> 2. what if device encounters an error and sets
> NEED_RESET meanwhile? waiting for a reset will then deadlock ...
> I know, it's problematic like this in PCI too.

Yes, it's kind of a recursion that is not something that can be
handled at the virtio level.

We probably need a transport reset (FLR) here. But it's another topic I thi=
nk.

>
> Further what will device return after reset was written but
> before it completed? I think it is better to specify that
> rather than rely on any non-0 value meaning "wait for reset".
> For pci maybe make it a SHOULD ...
>

I agree.

Thanks

>
> > +
> >  Before reading from \field{DeviceFeatures}, the driver MUST write a va=
lue to \field{DeviceFeaturesSel}.
> >
> >  Before writing to the \field{DriverFeatures} register, the driver MUST=
 write a value to the \field{DriverFeaturesSel} register.
> >
> >
> > ---
> >
> > Qualcomm Innovation Center, Inc. is submitting the attached "feedback" =
as a
> > non-member to the virtio-dev mailing list for consideration and inclusi=
on.
>

