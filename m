Return-Path: <eperezma@redhat.com>
MIME-Version: 1.0
References: <20211111185812.2326093-1-eperezma@redhat.com> <20211111185812.2326093-3-eperezma@redhat.com>
 <CACGkMEv+42=qMDHtn8vM1jG6K2rNuKWz=CLtpJqwVJ7u7WF=ZA@mail.gmail.com>
In-Reply-To: <CACGkMEv+42=qMDHtn8vM1jG6K2rNuKWz=CLtpJqwVJ7u7WF=ZA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 12 Nov 2021 11:50:38 +0100
Message-ID: <CAJaqyWdWCHS9TMunT1XEaMF8_YByLo+Zfpy+DY8GBeG349HAQA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] virtio: introduce STOP status bit
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, virtio-comment@lists.oasis-open.org, mst <mst@redhat.com>, Alexander Mikheev <amikheev@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Bodong Wang <bodong@nvidia.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Nov 12, 2021 at 5:18 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Fri, Nov 12, 2021 at 2:59 AM Eugenio P=C3=A9rez <eperezma@redhat.com> =
wrote:
> >
> > From: Jason Wang <jasowang@redhat.com>
> >
> > This patch introduces a new status bit STOP. This can be used by the
> > driver to stop the device in order to safely fetch used descriptors
> > status, making sure the device will not fetch new available ones.
> >
> > Its main use case is live migration, although it has other orthogonal
> > use cases. It can be used to safely discard requests that have not been
> > used: in other words, to rewind available descriptors.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> So this is much more complicated, see below.
>

I agree it's more complicated, but it addresses some concerns raised
on previous patches sent to the list. Not saying that all of them must
be addressed, or addressed this way though :).

> > ---
> >  content.tex | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 83 insertions(+)
> >
> > diff --git a/content.tex b/content.tex
> > index 2aa3006..9ed0d09 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -47,6 +47,13 @@ \section{\field{Device Status} Field}\label{sec:Basi=
c Facilities of a Virtio Dev
> >  \item[DRIVER_OK (4)] Indicates that the driver is set up and ready to
> >    drive the device.
> >
> > +\item[STOP (16)] When VIRTIO_F_STOP is negotiated, indicates that the
> > +  device has been stopped by the driver. This status bit is different
> > +  from the reset since the device state is preserved.
> > +
> > +\item[STOP_FAILED (32)] When VIRTIO_F_STOP is negotiated, indicates th=
at the
> > +  device could not stop the STOP request.
> > +
> >  \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienc=
ed
> >    an error from which it can't recover.
> >  \end{description}
> > @@ -74,11 +81,83 @@ \section{\field{Device Status} Field}\label{sec:Bas=
ic Facilities of a Virtio Dev
> >  recover by issuing a reset.
> >  \end{note}
> >
> > +If VIRTIO_F_STOP has been negotiated,
>
> "has not been" actually?
>

I think the sentence is ok. In other words, "Even when VIRTIO_F_STOP
*has been* negotiated (in other words, driver sent FEATURES_OK), the
driver must not set or clear the STOP bit before setting DRIVER_OK".

> > the driver MUST NOT set or clear STOP if
> > +DRIVER_OK is not set.
> > +
> > +If VIRTIO_F_STOP has been negotiated the driver MUST re-read the devic=
e status
> > +to ensure the STOP or STOP_FAILED bit is set after the write. The devi=
ce
> > +acknowledges the new paused status setting the first, or the failure s=
etting
> > +the last. Since this change may not be instantaneous, the driver MAY w=
ait for
> > +the configuration change notification that the device must send after =
the
> > +change.
>
> This is kind of tricky, it means the device can send notification
> after it has been stopped.

I don't think this part it's so tricky. That notification is also sent
when the DEVICE_NEEDS_RESET bit is set, and (as I read) is for the
same reason somehow: To avoid the status polling:
* "The driver SHOULD NOT rely on completion of operations of a device
if DEVICE_NEEDS_RESET is set." (copied from the standard)
* The reading of the status field could be expensive / inconvenient in
each operation.
* Solution: Instead of polling, make a device facility to notify the
driver that it cannot trust the device is going to behave properly /
same as before anymore via notification.

We can add another exception to the "device configuration space
change" in "Notification of Device Configuration Changes", like the
one already present:
"In addition, this notification is triggered by the device setting
DEVICE_NEEDS_RESET".

I understand it sounds tricky that the device sends a notification
when it's stopped, but in my opinion it's aligned with previous
behavior (DEVICE_NEEDS_RESET), it's explicitly stated that it will be
the last one, and it's caused because of the inconvenience of polling
device status. Even if the driver can use other mechanisms.

If the community still has concerns about it, another option is to
actually extract the way the device notifies it from the general
facilities, and make it transport specific. But to use the device
configuration change notification for this makes sense to me. The
device configuration has changed.

> As discussed in the previous versions,
> driver is freed to use timer or what ever other mechanism if it
> doesn't like the busy polling. I wonder how much value we can gain
> from a dedicated config interrupt. Especially consider some transport
> can use transport specific interrupt (not virtio specific interrupt)
> for reporting whether or not set status succeed.
>

In my opinion, *if* we agree that a stop is a virtio facility and not
a per-device one, and *if* we agree that a notification is required
for the device to notify the stop, it makes sense to use a
transport-independent mechanism that the device must already
implement.

> >If the device sets the STOP_FAILED bit, the driver MUST clear it before
> > +try new STOP attempts.
>
> Does the device need to re-read the STOP_FAILED for synchronization?

I tend to see the status as something that belongs to the device and
is exposed to the driver. In that sense, the write from the guest
triggers an event on the device, and the device decides what will be
exposed on that field (MMIO?) on the next driver read. If it's not
that way, we couldn't use the STOP bit that way, right?

> I
> wonder how much we can gain from STOP_FAILED, the patch is unclear on
> when that the device needs to set this bit. And driver can choose to
> reset after a specific timeout anyhow.
>

The conditions where the device needs to set this bit are unspecified
because it depends on the device: Not only to the kind of device, but
also on the device backend.

The same condition (regarding the possibility of handling the pending
buffers) could cause different devices to react differently. A network
device could decide it's fine to drop pending tx, let the guest think
that "the network lost them", and mark them as done, where a
persistent storage cannot do that for write requests. Just as an
example, not saying that networking devices must do that :).

> > +
> > +If VIRTIO_F_STOP has been negotiated and the device has confirmed its =
stop,
> > +the driver MAY change avail_idx in the case of split virtqueue, but th=
e new
> > +avail_idx MUST be within used_idx and used_idx plus virtqueue size.
>
> Any motivation for this? it looks to me it makes the feature coupled
> with the virtqueue state proposal? It seems odd to allow avail change
> but not the last_avail_idx change.
>

On second thought, I think you are right and this overlaps with the
state proposal.

> > +
> > +If VIRTIO_F_STOP has been negotiated and the device has confirmed its =
stop,
> > +the driver MAY change any descriptor.
> > +
> > +If VIRTIO_F_STOP has been negotiated and the device has confirmed its =
stopped,
> > +the driver can resume it clearing the STOP status bit. It MUST re-read=
 the
> > +device status to ensure the STOP bit is clear after the write. The dev=
ice
> > +acknowledges the new status clearing it. Since this change may not be
> > +instantaneous, the driver MAY wait for the configuration change notifi=
cation
> > +that the device must send after the change.
>
> Do we really needs resuming? it's kind of:
>
> 1) STOP -> clear STOP
>
> vs
>
> 2) STOP -> RESET -> DRIVER_OK
>
> Using 2) preserve the semantic that the driver can't clear the status bit=
.
>

You are totally right in that regard. But the use case simplifies the
operation when the driver only wants to take back some available
descriptors still not used, in the range last_avail_idx..avail_idx.
Doing that could be a big burden for drivers, who would need to
re-send every status. MST proposed that use case at [1].

In that regard, the straightforward thing to do is modify avail_idx /
descriptors from that range and let resume. However, the RESET path
makes it easier to implement the device part of course, and the guest
can also achieve the rewind that way.

> > +
> >  \devicenormative{\subsection}{Device Status Field}{Basic Facilities of=
 a Virtio Device / Device Status Field}
> >
> >  The device MUST NOT consume buffers or send any used buffer
> >  notifications to the driver before DRIVER_OK.
> >
> > +If VIRTIO_F_STOP has not been negotiated the device MUST ignore the wr=
ite of
> > +STOP. If the DRIVER_OK status bit is not set the device SHOULD ignore =
the write
> > +or clear of STOP.
> > +
> > +If VIRTIO_F_STOP has been negotiated, the device MUST finish any in fl=
ight
> > +operations after the driver writes STOP.
>
> I wonder if it's better to leave this to device to decide. E.g some
> block devices may requires a very log time to finish the inflight
> operations.
>

(Letting out SVQ + inflight descriptors for this part of the response,
I will come back to it later)

But if virtqueue is not valid anymore, how can it report them when
finished? In that sense, I would say it's better to report failure and
let the guest handle it as if the disk is unavailable (timeout?
temporary faulty sector? I'm not sure what is the most suitable way).

*If* we are not going to allow the guest to resume operation, where it
knows all the status of the device, then there is no value on let the
device delay the operation: From the guest point of view it either
succeed to send to the device backend and somebody else caused a
failure (external network lose the tx packet, bit rotting caused I'm
reading a different value than previously written), or it failed at
the stop moment.

This is different with the resume possibility, where the device can
decide to hold the descriptors, stop operating, and then resume
operation.

> > Depending on the device, it can do it
> > +in many ways as long as the driver can recover its normal operation if=
 it
> > +resumes the device without the need of resetting it:
> > +\begin{itemize}
> > +\item Drain and wait for the completion of all pending requests until =
a
> > +convenient avail descriptor. Ignore any other posterior descriptor.
> > +\item Return a device-specific failure for these descriptors, so the d=
river
> > +can choose to retry or to cancel them.
>
> If we allow the driver to retry, we need a way to report inflight
> buffers which is not supported by the spec. A way to solve this is to
> make it device specific.
>

Regarding the retry, I don't get you here. Re-reading the patch, I
think that "driver retry" is very ambiguous: I meant for the device to
mark the descriptor as used, but with a communication specific error
code, so the application, guest kernel, etc (driver in the standard)
can decide to retry.

Regarding the in-flight descriptor report, it's interesting but I
cannot see a way where it does not complicate the solution a lot or
adds new dependencies. I have the next thoughts:
1) If it works as inflight_fd, "a region of shared memory"
1.1) This region must be in the guest's AS so the device has access to
it. This either invalidates the use of STOP from the driver point of
view as "let me know where you are not going to modify the guest's
memory anymore".
1.2) This region is on the hypervisor's AS. If the device supports it,
it is possible to implement the SVQ without the need of STOP bit. This
is equivalent to "I have a PF that also supports VF dirty memory
tracking".
2) If it works as the config space, where the driver can ask for its
status, STOP means "STOP writing used and report via config space". No
need for reset.

Did you have something different in mind?

> > +\item Mark them as done even if they are not, if the kind of device ca=
n
> > +assume to lose them.
>
> I think "make buffer used" is better than "mark them as done". And we
> need a accurate definition on who is "them".
>

All items include other operations, like the ones that the device must
do internally to process the control virtqueue. But I cannot find an
example where telling the driver they are done when it's not is valid
for this particular item.

But I agree it needs better wording.

And I will s/them/operations/. for the next one.

> > +\end{itemize}
> > +
> > +If VIRTIO_F_STOP has been negotiated and it needs to fail the device s=
top after
> > +a guest's request,
>
> It's not clear what did "a guest's request" means.
>

Right. Would "operation" fit better here?

> > the device MUST set the STOP_FAILED bit for the guest to
> > +read it. The device MUST ignore new writes to the STOP bit until the g=
uest
> > +clears STOP_FAILED.
> > +
> > +If VIRTIO_F_STOP has been negotiated and the guest has written the STO=
P bit,
> > +and the device can pause its operation, the device MUST set the descri=
ptors
> > +that it has done with them as used before exposing the STOP status bit=
 as set.
> > +
> > +If VIRTIO_F_STOP has been negotiated, the device MUST NOT perform thes=
e actions
> > +after exposing the STOP bit set:
> > +\begin{itemize}
> > +\item Read updates on the descriptor or driver area, or consume more b=
uffers.
> > +\item Send any used buffer notifications to the driver.
> > +\end{itemize}
> > +
> > +The device MUST send a configuration space change right after exposing=
 the STOP
> > +or STOP_FAILED as set to the driver, and MUST NOT change configuration=
 space or
> > +send another configuration space change notification to the driver aft=
erwards
> > +until the guest clears it.
> > +
> > +If VIRTIO_F_STOP has been negotiated and STOP device status flag is se=
t,
> > +the device MUST resume operation when the driver clears the STOP bit. =
The
> > +device MUST continue reading available descriptors as if an available =
buffer
> > +notification has reach it, starting from the last descriptor it marked=
 as used,
>
> So I still tend to define virtqueue state as basic facility before
> defining STOP. It can makes thing easier.
>

Yes, coming back to that approach can simplify the whole proposal.

> > +and continue the regular operation after that. The device MUST read ag=
ain
> > +descriptor and driver area beyond the last descriptor it marked as use=
d when it
> > +stopped, because the driver can change it. Device MUST set DEVICE_NEED=
S_RESET
> > +if for some reason it cannot continue.
> > +
> >  \label{sec:Basic Facilities of a Virtio Device / Device Status Field /=
 DEVICENEEDSRESET}The device SHOULD set DEVICE_NEEDS_RESET when it enters a=
n error state
> >  that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEE=
DS_RESET, the device
> >  MUST send a device configuration change notification to the driver.
> > @@ -6694,6 +6773,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserv=
ed Feature Bits}
> >    transport specific.
> >    For more details about driver notifications over PCI see \ref{sec:Vi=
rtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization =
And Device Operation / Available Buffer Notifications}.
> >
> > +\item[VIRTIO_F_STOP(41)] This feature indicates that the driver can
> > +  stop the device.
> > +  See \ref{sec:Basic Facilities of a Virtio Device / Device Status Fie=
ld}.
> > +
> >  \end{description}
>
> So I think the patch complicate thing is various ways:
>
> 1) STOP_FAILED status bit, which seems unnecessary or even duplicated
> with NEEDS_RESET
> 2) configuration change interrupt, looks conflict with the semantic of ST=
OP

I'm not sure about those two, I find we will have devices with unbound
stop time where both can be useful if we agree on making this a
general facility. Resetting the whole device because of this leaves
the driver with no possibility of knowing the state of the sent
descriptors.

Of course, if these use cases are not interesting, it's easier to
leave them out for sure.

> 3) status bit clearing (resuming), a functional duplication with RESET
> + DRIVER_OK
>

I agree it can be obtained with a whole reset, so it can be out and
leave it for the future if needed. However it seems overkill if we
just want to rewind some descriptors back, and there is no standard
way to recover the device status beyond vq_state.

Thanks!

> I think we'd better to stick to the minimal set of the function to
> reduce the complexity: virtqueue state + STOP bit (without clearing
> and no config interrupt).
>

[1] https://lists.oasis-open.org/archives/virtio-comment/202107/msg00043.ht=
ml

> Thanks
>
> >
> >  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bit=
s}
> > --
> > 2.27.0
> >
>

