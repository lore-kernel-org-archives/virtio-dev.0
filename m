Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v1] Add device reset timeout field
Date: Wed, 6 Oct 2021 12:03:24 +0000
Message-ID: <PH0PR12MB5481363BC8398F3F99BAB09DDCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211005171801.595250-1-parav@nvidia.com>
 <87v92azerq.fsf@redhat.com>
In-Reply-To: <87v92azerq.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Wednesday, October 6, 2021 2:55 PM
>=20
> > Motivation:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Currently when driver initiates a device reset operation, a device may
> > not be able finish the reset operation immediately. In such case
> > driver waits for an arbitrary amount of time in a hope that device
> > will finish the reset. Depending on the device type and its backend
> > implementation a device timeout can be different. Trying to wait for
> > all device type in same value may not be efficient or adequate.
> >
> > Proposal:
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > Hence, enhance the specification to let device report a device reset
> > timeout value in milliseconds. Such hint helps driver to know how long
> > should it wait for device reset to finish.
> >
> > This proposal introduces optional device reset timeout field for MMIO
> > and PCI transports. Such transports have a use case where virtio
> > devices are implemented in hardware and made available to the guest.
> >
> > A device reset timeout field has following attributes.
> > (a) It is an optional field to maintain backward compatibility.
> > (b) It is valid only when device advertises a new feature bit
> >     VIRTIO_F_DEV_RESET_TO
> > (b) When it is not advertised, this field is invalid and driver should
> >     choose the reasonable reset timeout.
> > (c) It is a 16-bit field covering wide range of timeout from 10
> > milliseconds to several hundred seconds.
> >
> > This proposal is an improvement over a past proposal [1].
> > Instead of just passing a flag for wait, this proposal offers upper
> > bound wait time making the device reset timeout and overall device
> > initialization more predictable.
> >
> > [1]
> > https://lists.oasis-open.org/archives/virtio-dev/202108/msg00161.html
> >
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> >
> > ---
> > changelog:
> > v0->v1:
> > - v0:
> > https://lists.oasis-open.org/archives/virtio-dev/202109/msg00133.html
> > - Addressed below comments from Cornelia Huck
> > - renamed VIRTIO_F_DEV_RESET_TO to VIRTIO_F_DEV_RESET_TIMEOUT
> > - removed references to device initialization sequence during device
> >   reset flow
> > - rewrote 'giving up on device'
> > ---
> >  content.tex | 40 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/content.tex b/content.tex index 37c45d3..c87833d 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -73,6 +73,12 @@ \section{\field{Device Status}
> > Field}\label{sec:Basic Facilities of a Virtio Dev  recover by issuing a=
 reset.
> >  \end{note}
> >
> > +Once the driver initiates a reset, the device may not be able to
> > +finish the reset immediately. Such device provides a hint to the
> > +driver about how long a device may take to complete the reset.
>=20
> Maybe
>=20
> "To accommodate that situation, the device can provide a hint to the driv=
er
> about how long it might take the device to complete the reset."
>
Ack.
=20
> > Driver should wait at least for the
>=20
> s/Driver/The driver/
>=20
Ack.

> > +time specified by the device to let device finish the reset or if the
> > +device status field to become 0 within the specified time interval.
>=20
> Hm, status =3D=3D 0 is supposed to signal completion of the reset anyway,=
 no?
> What about rewording this to
>=20
> "...for the device status field to become 0, signifying completion of the=
 reset
> operation."
Yes, but we probably don't need to repeat here what is the significance of =
device status zero mean.
It signify completion of the reset is already captured in the reset descrip=
tion.
So I think this paragraph should just say that let it become zero.

>=20
> ?
>=20
> > +
> >  \devicenormative{\subsection}{Device Status Field}{Basic Facilities
> > of a Virtio Device / Device Status Field}
> >
> >  The device MUST NOT consume buffers or send any used buffer @@
> > -210,11 +216,20 @@ \section{Device Reset}\label{sec:Basic Facilities
> > of a Virtio Device / Device Re  indicating completion of the reset by
> > reinitializing \field{device status}  to 0, until the driver re-initial=
izes the
> device.
> >
> > +A device may not be able to complete reset action when the driver init=
iates
> a reset operation.
>=20
> "...may not be able to complete the reset action immediately..." ?
>
Ok.
=20
> > +Such a device should provide the hint as to how long a device may take=
 to
> finish the reset operation.
>=20
> s/the hint/a hint/
>=20
Ack.

> > +This hint is provided by the device using device reset timeout field i=
n units
> of 10 milliseconds.
>=20
> Maybe
>=20
> "This hint is provided by the device via a device reset timeout value in =
units of
> 10 milliseconds."
>=20
> ?
>
Sounds equally fine.
=20
> > +
> >  \drivernormative{\subsection}{Device Reset}{Basic Facilities of a
> > Virtio Device / Device Reset}
> >
> >  The driver SHOULD consider a driver-initiated reset complete when it
> > reads \field{device status} as 0.
> >
> > +When a device reports a non-zero device reset timeout value, the
> > +driver SHOULD wait for the device to finish the reset action before
> > +considering the reset operation to have failed. When
>=20
> "...the driver SHOULD NOT consider the reset operation to have failed unl=
ess
> the specified timeout has expired." ?
>=20
I think it is better to have positive sentence as "driver should wait for t=
he device to finish" compare to saying
Should not considered failed" which contains two negative.
How about below version?

"When a device reports a non-zero device reset timeout value, the
driver SHOULD wait for the device to finish the reset action.
Once the specified timeout has expired, driver should consider that reset o=
peration has failed".

> > +device reset timeout is not provided by the device, driver SHOULD
> > +choose a reasonable timeout
>=20
> Maybe "When no device reset timeout is provided..." ?

I think "device reset timeout is not provided" reads better to me, compare =
to saying "no d_r_t provided".
Here the sentence refers to "device reset timeout" field being absent.
Saying "no" and provided in same sentence is confusing me.


> s/driver/the driver/
>
Ack.
=20
> > +value for reset operation to complete.
>=20
> s/reset operation/the reset operation/
>=20
Ack.
> > +
> >  \section{Device Configuration Space}\label{sec:Basic Facilities of a
> > Virtio Device / Device Configuration Space}
> >
> >  Device configuration space is generally used for rarely-changing or
> > @@ -859,6 +874,8 @@ \subsubsection{Common configuration structure
> layout}\label{sec:Virtio Transport
> >          le64 queue_driver;              /* read-write */
> >          le64 queue_device;              /* read-write */
> >          le16 queue_notify_data;         /* read-only for driver */
> > +        /* About the whole device. */
> > +        le16 device_reset_timeout;      /* read-only for driver */
>=20
> Is a 16 bit value reasonable for all devices? It very likely is (that's
> 10 minutes or so), but having to extend it later may be annoying. What va=
lues
> would you expect for the devices you know of today?
>=20
Devices that I know needs 2 to 3 minutes of time in worst cases.
We initially considered it be 32-bit value with granularity of 1 msec.
But during review, we felt that 10 minutes is high enough.

We waned to here from community if this should be le32 or le16 is good enou=
gh?

> >  };
> >  \end{lstlisting}
> >
> > @@ -938,6 +955,15 @@ \subsubsection{Common configuration structure
> layout}\label{sec:Virtio Transport
> >          may benefit from providing another value, for example an inter=
nal
> virtqueue
> >          identifier, or an internal offset related to the virtqueue num=
ber.
> >          \end{note}
> > +
> > +\item[\field{device_reset_timeout}]
> > +        This field exists only if the VIRTIO_F_DEV_RESET_TIMEOUT is
> advertised by the device.
>=20
> s/if the/if/
>=20
Ack.

> > +        This field provides the hint to the driver indicating how much=
 maximum
> time a
> > +        device can take to complete the reset once the driver initiate=
s the
> device reset
> > +        operation. This field unit is in 10 milliseconds. For example,=
 a field
> value of
> > +        3 indicates device reset timeout is 30 milliseconds. When
> VIRTIO_F_DEV_RESET_TIMEOUT
> > +=09feature is set by the device this field must contain a non zero val=
ue.
>=20
> s/feature is set/is offered/ ?
>
Ack.
=20
> > +
> >  \end{description}
> >
> >  \devicenormative{\paragraph}{Common configuration structure
> > layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Lay=
out /
> Common configuration structure layout} @@ -1804,6 +1830,15 @@
> \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Optio=
ns
> / Vi
> >      accesses apply to the queue selected by writing to \field{QueueSel=
}.
> >    }
> >    \hline
> > +  \mmioreg{DeviceResetTimeout}{Device reset timeout}{0x04c}{R}{%
> > +    This register exists only if the VIRTIO_F_DEV_RESET_TIMEOUT is
> advertised by the device.
> > +    It provides the hint to the driver indicating how much maximum tim=
e a
> > +    device can take to complete the reset once the driver initiates th=
e device
> reset operation.
> > +    This field unit is in 10 milliseconds. For example, a field value =
of 3
> indicates device
> > +    reset timeout is 30 milliseconds. When VIRTIO_F_DEV_RESET_TIMEOUT
> feature is set by the device
> > +    this field must contain a non zero value.
>=20
> Same nits here as for the PCI definition above.
>=20
Ok. will change.

> > +  }
> > +  \hline
> >    \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
> >      Writing a value to this register notifies the device that
> >      there are new buffers to process in a queue.
> > @@ -6673,6 +6708,11 @@ \chapter{Reserved Feature
> Bits}\label{sec:Reserved Feature Bits}
> >    transport specific.
> >    For more details about driver notifications over PCI see \ref{sec:Vi=
rtio
> Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And=
 Device
> Operation / Available Buffer Notifications}.
> >
> > +  \item[VIRTIO_F_DEV_RESET_TIMEOUT(40)] This feature indicates that
> > + the device  advertises a maximum reset timeout which the driver shoul=
d
> use during device reset stage.
>=20
> "...advertises a timeout value for the device reset operation." ?
>=20
Ack.
Timeout is anyway for the maximum. :-)

> > +  For more details about device reset timeout over PCI see \ref{sec:Vi=
rtio
> Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common
> configuration structure layout}.
> > +  For more details about device reset timeout over MMIO see \ref{sec:V=
irtio
> Transport Options / Virtio Over MMIO / MMIO Device Register Layout}.
> > +
> >  \end{description}
> >
> >  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature
> > Bits}
>=20
> Not quite sure yet how to model this for CCW, but it should not present a=
ny
> problems (I'm not aware of any devices addressed via CCW that would
> currently need this anyway... an advertised timeout value for *any* CCW
> operation that involves channel I/O would make more sense, I think. But t=
hat's
> beyond the scope of this proposal, and I'm not sure if we would be able t=
o
> come up with anything sane considering the other variables like delays on=
 the
> channel etc. involved, anyway.)
>=20
> So on the whole, I think this basically looks good.

Ok. Thanks a lot for te review. I will send v2 fixing above comments.

