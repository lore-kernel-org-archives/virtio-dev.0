Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20211111185812.2326093-1-eperezma@redhat.com> <20211111185812.2326093-3-eperezma@redhat.com>
 <CACGkMEv+42=qMDHtn8vM1jG6K2rNuKWz=CLtpJqwVJ7u7WF=ZA@mail.gmail.com> <CAJaqyWdWCHS9TMunT1XEaMF8_YByLo+Zfpy+DY8GBeG349HAQA@mail.gmail.com>
In-Reply-To: <CAJaqyWdWCHS9TMunT1XEaMF8_YByLo+Zfpy+DY8GBeG349HAQA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Nov 2021 12:08:02 +0800
Message-ID: <CACGkMEvagQ8SDKb+WGL96w-7=w0fj70MQ+J3fJ9USMN1f3ANTA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] virtio: introduce STOP status bit
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, virtio-comment@lists.oasis-open.org, mst <mst@redhat.com>, Alexander Mikheev <amikheev@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Bodong Wang <bodong@nvidia.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Nov 12, 2021 at 6:51 PM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Nov 12, 2021 at 5:18 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Fri, Nov 12, 2021 at 2:59 AM Eugenio P=C3=A9rez <eperezma@redhat.com=
> wrote:
> > >
> > > From: Jason Wang <jasowang@redhat.com>
> > >
> > > This patch introduces a new status bit STOP. This can be used by the
> > > driver to stop the device in order to safely fetch used descriptors
> > > status, making sure the device will not fetch new available ones.
> > >
> > > Its main use case is live migration, although it has other orthogonal
> > > use cases. It can be used to safely discard requests that have not be=
en
> > > used: in other words, to rewind available descriptors.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >
> > So this is much more complicated, see below.
> >
>
> I agree it's more complicated, but it addresses some concerns raised
> on previous patches sent to the list. Not saying that all of them must
> be addressed, or addressed this way though :).
>
> > > ---
> > >  content.tex | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 83 insertions(+)
> > >
> > > diff --git a/content.tex b/content.tex
> > > index 2aa3006..9ed0d09 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -47,6 +47,13 @@ \section{\field{Device Status} Field}\label{sec:Ba=
sic Facilities of a Virtio Dev
> > >  \item[DRIVER_OK (4)] Indicates that the driver is set up and ready t=
o
> > >    drive the device.
> > >
> > > +\item[STOP (16)] When VIRTIO_F_STOP is negotiated, indicates that th=
e
> > > +  device has been stopped by the driver. This status bit is differen=
t
> > > +  from the reset since the device state is preserved.
> > > +
> > > +\item[STOP_FAILED (32)] When VIRTIO_F_STOP is negotiated, indicates =
that the
> > > +  device could not stop the STOP request.
> > > +
> > >  \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experie=
nced
> > >    an error from which it can't recover.
> > >  \end{description}
> > > @@ -74,11 +81,83 @@ \section{\field{Device Status} Field}\label{sec:B=
asic Facilities of a Virtio Dev
> > >  recover by issuing a reset.
> > >  \end{note}
> > >
> > > +If VIRTIO_F_STOP has been negotiated,
> >
> > "has not been" actually?
> >
>
> I think the sentence is ok. In other words, "Even when VIRTIO_F_STOP
> *has been* negotiated (in other words, driver sent FEATURES_OK), the
> driver must not set or clear the STOP bit before setting DRIVER_OK".

Ok, but what happens if we simply allow the STOP to be set if
DRIVER_OK is not set? It looks to me that the DRIVER_OK doesn't
conflict with STOP.

(Anyhow we allow to set STOP after DRIVER_OK)

>
> > > the driver MUST NOT set or clear STOP if
> > > +DRIVER_OK is not set.
> > > +
> > > +If VIRTIO_F_STOP has been negotiated the driver MUST re-read the dev=
ice status
> > > +to ensure the STOP or STOP_FAILED bit is set after the write. The de=
vice
> > > +acknowledges the new paused status setting the first, or the failure=
 setting
> > > +the last. Since this change may not be instantaneous, the driver MAY=
 wait for
> > > +the configuration change notification that the device must send afte=
r the
> > > +change.
> >
> > This is kind of tricky, it means the device can send notification
> > after it has been stopped.
>
> I don't think this part it's so tricky. That notification is also sent
> when the DEVICE_NEEDS_RESET bit is set,

I think they are different, DEVICE_NEEDS_RESET doesn't mean the device
is stopped. But what we want to achieve is to make sure there won't be
any interaction between device and driver after STOP is set by device.

> and (as I read) is for the
> same reason somehow: To avoid the status polling:
> * "The driver SHOULD NOT rely on completion of operations of a device
> if DEVICE_NEEDS_RESET is set." (copied from the standard)
> * The reading of the status field could be expensive / inconvenient in
> each operation.

It makes sense for the device initiated event to use interrupt. But
for a stop, it's driver initiated, in this case the driver won't start
the work (for example the cleanup) after it makes sure the device is
stopped. Polling the status should be fine as this is how the rest
works. Anything makes stop differ from reset here? Or what worries you
without the interrupt?

> * Solution: Instead of polling, make a device facility to notify the
> driver that it cannot trust the device is going to behave properly /
> same as before anymore via notification.
>
> We can add another exception to the "device configuration space
> change" in "Notification of Device Configuration Changes", like the
> one already present:
> "In addition, this notification is triggered by the device setting
> DEVICE_NEEDS_RESET".
>
> I understand it sounds tricky that the device sends a notification
> when it's stopped, but in my opinion it's aligned with previous
> behavior (DEVICE_NEEDS_RESET),

I think not,  e.g DEVICE_NEEDS_RESET doesn't (or it can't) mean the
device won't process the buffer or send an interrupt.

> it's explicitly stated that it will be
> the last one, and it's caused because of the inconvenience of polling
> device status. Even if the driver can use other mechanisms.

I think STOP works much more similarly to reset not NEEDS_RESET. The
only difference with reset is that STOP needs to preserve the device
states and we don't (or can't) use interrupt to signal the completion
of reset.

>
> If the community still has concerns about it, another option is to
> actually extract the way the device notifies it from the general
> facilities, and make it transport specific. But to use the device
> configuration change notification for this makes sense to me. The
> device configuration has changed.

See above, I think we should have a consistent way to handle reset and stop=
.

>
> > As discussed in the previous versions,
> > driver is freed to use timer or what ever other mechanism if it
> > doesn't like the busy polling. I wonder how much value we can gain
> > from a dedicated config interrupt. Especially consider some transport
> > can use transport specific interrupt (not virtio specific interrupt)
> > for reporting whether or not set status succeed.
> >
>
> In my opinion, *if* we agree that a stop is a virtio facility and not
> a per-device one, and *if* we agree that a notification is required
> for the device to notify the stop, it makes sense to use a
> transport-independent mechanism that the device must already
> implement.

So the major question is why a notification is a must? And Just to be
clear, there could be transport specific mechanisms for error
reporting.

E,g

1) PCI can have non-posted write, if we use non-posted write to carry
the stop command, the device can return whether or not the device is
stopped successfully.

or

2) Some other transport can convert the stop status bit set into a
command and queue it to device specific queue, device can then use
it's own specific interrupt to report the when the stop is handled
(success or fail)

>
> > >If the device sets the STOP_FAILED bit, the driver MUST clear it befor=
e
> > > +try new STOP attempts.
> >
> > Does the device need to re-read the STOP_FAILED for synchronization?
>
> I tend to see the status as something that belongs to the device and
> is exposed to the driver. In that sense, the write from the guest
> triggers an event on the device, and the device decides what will be
> exposed on that field (MMIO?) on the next driver read. If it's not
> that way, we couldn't use the STOP bit that way, right?

Yes, but this is not an answer to my question. It's about the
ordering, when write returns it doesn't mean the write arrives at the
device, this is the case of PCI at least. So we need a mechanism to
make sure the write arrives at the device (PCI read will flush
previous write).

>
> > I
> > wonder how much we can gain from STOP_FAILED, the patch is unclear on
> > when that the device needs to set this bit. And driver can choose to
> > reset after a specific timeout anyhow.
> >
>
> The conditions where the device needs to set this bit are unspecified
> because it depends on the device: Not only to the kind of device, but
> also on the device backend.
>
> The same condition (regarding the possibility of handling the pending
> buffers) could cause different devices to react differently. A network
> device could decide it's fine to drop pending tx, let the guest think
> that "the network lost them", and mark them as done,

We may meet the similar issue during reset.

> where a
> persistent storage cannot do that for write requests. Just as an
> example, not saying that networking devices must do that :).

So I think this brings extra complexity that we probably don't need to
worry about now. The reason is that the spec doesn't allow the reset
to fail.

>
> > > +
> > > +If VIRTIO_F_STOP has been negotiated and the device has confirmed it=
s stop,
> > > +the driver MAY change avail_idx in the case of split virtqueue, but =
the new
> > > +avail_idx MUST be within used_idx and used_idx plus virtqueue size.
> >
> > Any motivation for this? it looks to me it makes the feature coupled
> > with the virtqueue state proposal? It seems odd to allow avail change
> > but not the last_avail_idx change.
> >
>
> On second thought, I think you are right and this overlaps with the
> state proposal.
>
> > > +
> > > +If VIRTIO_F_STOP has been negotiated and the device has confirmed it=
s stop,
> > > +the driver MAY change any descriptor.
> > > +
> > > +If VIRTIO_F_STOP has been negotiated and the device has confirmed it=
s stopped,
> > > +the driver can resume it clearing the STOP status bit. It MUST re-re=
ad the
> > > +device status to ensure the STOP bit is clear after the write. The d=
evice
> > > +acknowledges the new status clearing it. Since this change may not b=
e
> > > +instantaneous, the driver MAY wait for the configuration change noti=
fication
> > > +that the device must send after the change.
> >
> > Do we really needs resuming? it's kind of:
> >
> > 1) STOP -> clear STOP
> >
> > vs
> >
> > 2) STOP -> RESET -> DRIVER_OK
> >
> > Using 2) preserve the semantic that the driver can't clear the status b=
it.
> >
>
> You are totally right in that regard. But the use case simplifies the
> operation when the driver only wants to take back some available
> descriptors still not used, in the range last_avail_idx..avail_idx.
> Doing that could be a big burden for drivers, who would need to
> re-send every status. MST proposed that use case at [1].

Yes, but it looks to me this doesn't require the resuming? And the per
virtqueue reset is being proposed here.

https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg07818.html

Actually, there's a subtle difference between 1) and 2). That is using
2) doesn't make sure we can "resume" from the index where we stopped.
But this won't be an issue considering we know that we need to support
setting device virtqueue state(index). So if we want to resume from
the exact index it could be:

STOP -> RESET -> setting index -> DRIVER_OK

>
> In that regard, the straightforward thing to do is modify avail_idx /
> descriptors from that range and let resume. However, the RESET path
> makes it easier to implement the device part of course, and the guest
> can also achieve the rewind that way.
>
> > > +
> > >  \devicenormative{\subsection}{Device Status Field}{Basic Facilities =
of a Virtio Device / Device Status Field}
> > >
> > >  The device MUST NOT consume buffers or send any used buffer
> > >  notifications to the driver before DRIVER_OK.
> > >
> > > +If VIRTIO_F_STOP has not been negotiated the device MUST ignore the =
write of
> > > +STOP. If the DRIVER_OK status bit is not set the device SHOULD ignor=
e the write
> > > +or clear of STOP.
> > > +
> > > +If VIRTIO_F_STOP has been negotiated, the device MUST finish any in =
flight
> > > +operations after the driver writes STOP.
> >
> > I wonder if it's better to leave this to device to decide. E.g some
> > block devices may requires a very log time to finish the inflight
> > operations.
> >
>
> (Letting out SVQ + inflight descriptors for this part of the response,
> I will come back to it later)
>
> But if virtqueue is not valid anymore, how can it report them when
> finished?

It's still valid since the STOP bit is not set by the device.

> In that sense, I would say it's better to report failure and
> let the guest handle it as if the disk is unavailable (timeout?
> temporary faulty sector? I'm not sure what is the most suitable way).

This could be addressed by leaving the following choices to the devices:

1) complete the inflight requests
2) device or virtio specific for reporting inflight descriptors

>
> *If* we are not going to allow the guest to resume operation, where it
> knows all the status of the device, then there is no value on let the
> device delay the operation: From the guest point of view it either
> succeed to send to the device backend and somebody else caused a
> failure (external network lose the tx packet, bit rotting caused I'm
> reading a different value than previously written), or it failed at
> the stop moment.

So it's highly device specific, e.g for ethernet, we can afford the
loss of packets but not for the block devices so reporting inflight
descriptors may help to res-submit those after "resuming".

>
> This is different with the resume possibility, where the device can
> decide to hold the descriptors, stop operating, and then resume
> operation.
>
> > > Depending on the device, it can do it
> > > +in many ways as long as the driver can recover its normal operation =
if it
> > > +resumes the device without the need of resetting it:
> > > +\begin{itemize}
> > > +\item Drain and wait for the completion of all pending requests unti=
l a
> > > +convenient avail descriptor. Ignore any other posterior descriptor.
> > > +\item Return a device-specific failure for these descriptors, so the=
 driver
> > > +can choose to retry or to cancel them.
> >
> > If we allow the driver to retry, we need a way to report inflight
> > buffers which is not supported by the spec. A way to solve this is to
> > make it device specific.
> >
>
> Regarding the retry, I don't get you here. Re-reading the patch, I
> think that "driver retry" is very ambiguous: I meant for the device to
> mark the descriptor as used, but with a communication specific error
> code, so the application, guest kernel, etc (driver in the standard)
> can decide to retry.

That's why I think introducing the virtqueue state is a must for stop,
With all the indexes defined, it would be much easier to describe what
the device or driver is expected to work.

>
> Regarding the in-flight descriptor report, it's interesting but I
> cannot see a way where it does not complicate the solution a lot or
> adds new dependencies. I have the next thoughts:
> 1) If it works as inflight_fd, "a region of shared memory"
> 1.1) This region must be in the guest's AS so the device has access to
> it. This either invalidates the use of STOP from the driver point of
> view as "let me know where you are not going to modify the guest's
> memory anymore".
> 1.2) This region is on the hypervisor's AS. If the device supports it,
> it is possible to implement the SVQ without the need of STOP bit. This
> is equivalent to "I have a PF that also supports VF dirty memory
> tracking".
> 2) If it works as the config space, where the driver can ask for its
> status, STOP means "STOP writing used and report via config space". No
> need for reset.
>
> Did you have something different in mind?

Not sure, maybe config space is better. What I want is to make the
feature as small as possible but leaving spaces for future extension.

E.g we start from the feature that is sufficient for networking
devices, (but doesn't prevent the future work to extend it to block
devices). I'm not familiar with the block device, but mandating the
completion of inflight descriptor make have troubles, e.g unexpected
downtime during live migration.

>
> > > +\item Mark them as done even if they are not, if the kind of device =
can
> > > +assume to lose them.
> >
> > I think "make buffer used" is better than "mark them as done". And we
> > need a accurate definition on who is "them".
> >
>
> All items include other operations, like the ones that the device must
> do internally to process the control virtqueue. But I cannot find an
> example where telling the driver they are done when it's not is valid
> for this particular item.
>
> But I agree it needs better wording.
>
> And I will s/them/operations/. for the next one.
>
> > > +\end{itemize}
> > > +
> > > +If VIRTIO_F_STOP has been negotiated and it needs to fail the device=
 stop after
> > > +a guest's request,
> >
> > It's not clear what did "a guest's request" means.
> >
>
> Right. Would "operation" fit better here?

Still unclear, I guess this sentence tries to define when the device
can fail the stop?

>
> > > the device MUST set the STOP_FAILED bit for the guest to
> > > +read it. The device MUST ignore new writes to the STOP bit until the=
 guest
> > > +clears STOP_FAILED.
> > > +
> > > +If VIRTIO_F_STOP has been negotiated and the guest has written the S=
TOP bit,
> > > +and the device can pause its operation, the device MUST set the desc=
riptors
> > > +that it has done with them as used before exposing the STOP status b=
it as set.
> > > +
> > > +If VIRTIO_F_STOP has been negotiated, the device MUST NOT perform th=
ese actions
> > > +after exposing the STOP bit set:
> > > +\begin{itemize}
> > > +\item Read updates on the descriptor or driver area, or consume more=
 buffers.
> > > +\item Send any used buffer notifications to the driver.
> > > +\end{itemize}
> > > +
> > > +The device MUST send a configuration space change right after exposi=
ng the STOP
> > > +or STOP_FAILED as set to the driver, and MUST NOT change configurati=
on space or
> > > +send another configuration space change notification to the driver a=
fterwards
> > > +until the guest clears it.
> > > +
> > > +If VIRTIO_F_STOP has been negotiated and STOP device status flag is =
set,
> > > +the device MUST resume operation when the driver clears the STOP bit=
. The
> > > +device MUST continue reading available descriptors as if an availabl=
e buffer
> > > +notification has reach it, starting from the last descriptor it mark=
ed as used,
> >
> > So I still tend to define virtqueue state as basic facility before
> > defining STOP. It can makes thing easier.
> >
>
> Yes, coming back to that approach can simplify the whole proposal.
>
> > > +and continue the regular operation after that. The device MUST read =
again
> > > +descriptor and driver area beyond the last descriptor it marked as u=
sed when it
> > > +stopped, because the driver can change it. Device MUST set DEVICE_NE=
EDS_RESET
> > > +if for some reason it cannot continue.
> > > +
> > >  \label{sec:Basic Facilities of a Virtio Device / Device Status Field=
 / DEVICENEEDSRESET}The device SHOULD set DEVICE_NEEDS_RESET when it enters=
 an error state
> > >  that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_N=
EEDS_RESET, the device
> > >  MUST send a device configuration change notification to the driver.
> > > @@ -6694,6 +6773,10 @@ \chapter{Reserved Feature Bits}\label{sec:Rese=
rved Feature Bits}
> > >    transport specific.
> > >    For more details about driver notifications over PCI see \ref{sec:=
Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initializatio=
n And Device Operation / Available Buffer Notifications}.
> > >
> > > +\item[VIRTIO_F_STOP(41)] This feature indicates that the driver can
> > > +  stop the device.
> > > +  See \ref{sec:Basic Facilities of a Virtio Device / Device Status F=
ield}.
> > > +
> > >  \end{description}
> >
> > So I think the patch complicate thing is various ways:
> >
> > 1) STOP_FAILED status bit, which seems unnecessary or even duplicated
> > with NEEDS_RESET
> > 2) configuration change interrupt, looks conflict with the semantic of =
STOP
>
> I'm not sure about those two, I find we will have devices with unbound
> stop time where both can be useful if we agree on making this a
> general facility.

If the unbound stop time is the only worry, the way to report inflight
descriptors looks like a better solution. And STOP_FAILED is actually
not accurate since it means the stop is not finished in bound time
(but we need to define how long should be a bound time?)

> Resetting the whole device because of this leaves
> the driver with no possibility of knowing the state of the sent
> descriptors.
>
> Of course, if these use cases are not interesting, it's easier to
> leave them out for sure.
>
> > 3) status bit clearing (resuming), a functional duplication with RESET
> > + DRIVER_OK
> >
>
> I agree it can be obtained with a whole reset, so it can be out and
> leave it for the future if needed. However it seems overkill if we
> just want to rewind some descriptors back, and there is no standard
> way to recover the device status beyond vq_state.

It's more about the minimal self-contained set of the new features. If
it's just rewind, device or virtqueue reset is sufficient. If we want
to obtain the state, virtqueue state is a must and with virtqueue
state, resuming (clearing STOP) is not a must.

Thanks

>
> Thanks!
>
> > I think we'd better to stick to the minimal set of the function to
> > reduce the complexity: virtqueue state + STOP bit (without clearing
> > and no config interrupt).
> >
>
> [1] https://lists.oasis-open.org/archives/virtio-comment/202107/msg00043.=
html
>
> > Thanks
> >
> > >
> > >  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature B=
its}
> > > --
> > > 2.27.0
> > >
> >
>

