Return-Path: <eperezma@redhat.com>
MIME-Version: 1.0
References: <20211111185812.2326093-1-eperezma@redhat.com> <20211111185812.2326093-3-eperezma@redhat.com>
 <CACGkMEv+42=qMDHtn8vM1jG6K2rNuKWz=CLtpJqwVJ7u7WF=ZA@mail.gmail.com>
 <CAJaqyWdWCHS9TMunT1XEaMF8_YByLo+Zfpy+DY8GBeG349HAQA@mail.gmail.com> <CACGkMEvagQ8SDKb+WGL96w-7=w0fj70MQ+J3fJ9USMN1f3ANTA@mail.gmail.com>
In-Reply-To: <CACGkMEvagQ8SDKb+WGL96w-7=w0fj70MQ+J3fJ9USMN1f3ANTA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 15 Nov 2021 19:16:17 +0100
Message-ID: <CAJaqyWe0=Ax5sZoY3pReuw8qJuO0hC8zMMixDFZDZp-Z7ivEBw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] virtio: introduce STOP status bit
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, virtio-comment@lists.oasis-open.org, mst <mst@redhat.com>, Alexander Mikheev <amikheev@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Bodong Wang <bodong@nvidia.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Nov 15, 2021 at 5:08 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Fri, Nov 12, 2021 at 6:51 PM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Fri, Nov 12, 2021 at 5:18 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Fri, Nov 12, 2021 at 2:59 AM Eugenio P=C3=A9rez <eperezma@redhat.c=
om> wrote:
> > > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > >
> > > > This patch introduces a new status bit STOP. This can be used by th=
e
> > > > driver to stop the device in order to safely fetch used descriptors
> > > > status, making sure the device will not fetch new available ones.
> > > >
> > > > Its main use case is live migration, although it has other orthogon=
al
> > > > use cases. It can be used to safely discard requests that have not =
been
> > > > used: in other words, to rewind available descriptors.
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > >
> > > So this is much more complicated, see below.
> > >
> >
> > I agree it's more complicated, but it addresses some concerns raised
> > on previous patches sent to the list. Not saying that all of them must
> > be addressed, or addressed this way though :).
> >
> > > > ---
> > > >  content.tex | 83 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 83 insertions(+)
> > > >
> > > > diff --git a/content.tex b/content.tex
> > > > index 2aa3006..9ed0d09 100644
> > > > --- a/content.tex
> > > > +++ b/content.tex
> > > > @@ -47,6 +47,13 @@ \section{\field{Device Status} Field}\label{sec:=
Basic Facilities of a Virtio Dev
> > > >  \item[DRIVER_OK (4)] Indicates that the driver is set up and ready=
 to
> > > >    drive the device.
> > > >
> > > > +\item[STOP (16)] When VIRTIO_F_STOP is negotiated, indicates that =
the
> > > > +  device has been stopped by the driver. This status bit is differ=
ent
> > > > +  from the reset since the device state is preserved.
> > > > +
> > > > +\item[STOP_FAILED (32)] When VIRTIO_F_STOP is negotiated, indicate=
s that the
> > > > +  device could not stop the STOP request.
> > > > +
> > > >  \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has exper=
ienced
> > > >    an error from which it can't recover.
> > > >  \end{description}
> > > > @@ -74,11 +81,83 @@ \section{\field{Device Status} Field}\label{sec=
:Basic Facilities of a Virtio Dev
> > > >  recover by issuing a reset.
> > > >  \end{note}
> > > >
> > > > +If VIRTIO_F_STOP has been negotiated,
> > >
> > > "has not been" actually?
> > >
> >
> > I think the sentence is ok. In other words, "Even when VIRTIO_F_STOP
> > *has been* negotiated (in other words, driver sent FEATURES_OK), the
> > driver must not set or clear the STOP bit before setting DRIVER_OK".
>
> Ok, but what happens if we simply allow the STOP to be set if
> DRIVER_OK is not set? It looks to me that the DRIVER_OK doesn't
> conflict with STOP.
>
> (Anyhow we allow to set STOP after DRIVER_OK)
>

We could change it to "the driver MUST NOT set or clear STOP if
FEATURES_OK is not set", which would allow the driver to start a
device in stop mode. Before that should be definitely not done by a
good driver.

But if we don't allow the resume, it makes little sense to allow the
driver to start (as "set DRIVER_OK bit") in stop mode anyhow. I would
say that it is better to limit that now, and allow it in the future if
we find a valid use case, enabling a specific feature flag for it.

I'm also fine if we decide to leave this unspecified, but limiting it
now could enable us to make something useful with it in the future.

> >
> > > > the driver MUST NOT set or clear STOP if
> > > > +DRIVER_OK is not set.
> > > > +
> > > > +If VIRTIO_F_STOP has been negotiated the driver MUST re-read the d=
evice status
> > > > +to ensure the STOP or STOP_FAILED bit is set after the write. The =
device
> > > > +acknowledges the new paused status setting the first, or the failu=
re setting
> > > > +the last. Since this change may not be instantaneous, the driver M=
AY wait for
> > > > +the configuration change notification that the device must send af=
ter the
> > > > +change.
> > >
> > > This is kind of tricky, it means the device can send notification
> > > after it has been stopped.
> >
> > I don't think this part it's so tricky. That notification is also sent
> > when the DEVICE_NEEDS_RESET bit is set,
>
> I think they are different, DEVICE_NEEDS_RESET doesn't mean the device
> is stopped.

To clarify, what I meant is that there are situations where this
notification is raised even if device configuration is not changed,
but its status.

NEED_RESET does not mean the device is stopped, but it (should) signal
the driver that further interaction with the device will be for sure
invalid. I may be wrong with this, but this way of notifying the
driver relieves it to the need for check status in every interaction.

> But what we want to achieve is to make sure there won't be
> any interaction between device and driver after STOP is set by device.
>

If I understand you correctly, what you meant is that that a driver
could (and I think it will a lot of times) read the status change in
this order:
1) STOP bit is set
2) Notification change arrives

And 2) is weird since the device promised no more interaction somehow.

I agree to some extent, but it can be read even from the opposite
angle: From the moment the driver sets DRIVER_OK, every change on the
device (status or config) is notified using configuration change
interrupt.

a) Regarding the standard, I don't see it so different from the
NEED_RESET: the config change keeps being an out of band notification
system the driver can relay to know a (expected) status change.
b) I don't see a big deal with changing the semantic from "no more
interaction from the device" with "no more interaction but the
expected config change interrupt".
c) It's easy to ignore the interrupt, or even not to treat it
specially after the stop: The driver already should scan config to
look for changes in configuration and status, it will simply find
none. Although this is not implemented widely as far as I see.

In that regard, I feel that interaction is very innocuous, and to me
is the straightforward solution to avoid the active polling.

> > and (as I read) is for the
> > same reason somehow: To avoid the status polling:
> > * "The driver SHOULD NOT rely on completion of operations of a device
> > if DEVICE_NEEDS_RESET is set." (copied from the standard)
> > * The reading of the status field could be expensive / inconvenient in
> > each operation.
>
> It makes sense for the device initiated event to use interrupt. But
> for a stop, it's driver initiated, in this case the driver won't start
> the work (for example the cleanup) after it makes sure the device is
> stopped. Polling the status should be fine as this is how the rest
> works. Anything makes stop differ from reset here? Or what worries you
> without the interrupt?
>

This is proposed only in the scope of the concerns I saw raised in
previous series: the time to stop a device could be unbound, and
tricks to poll less frequently will increase migration time.

I will fully agree if these are left to the future: it is easy to
implement this chunk of the proposal under a separated feature flag if
this need arises. Sorry if that part was not clear enough.

> > * Solution: Instead of polling, make a device facility to notify the
> > driver that it cannot trust the device is going to behave properly /
> > same as before anymore via notification.
> >
> > We can add another exception to the "device configuration space
> > change" in "Notification of Device Configuration Changes", like the
> > one already present:
> > "In addition, this notification is triggered by the device setting
> > DEVICE_NEEDS_RESET".
> >
> > I understand it sounds tricky that the device sends a notification
> > when it's stopped, but in my opinion it's aligned with previous
> > behavior (DEVICE_NEEDS_RESET),
>
> I think not,  e.g DEVICE_NEEDS_RESET doesn't (or it can't) mean the
> device won't process the buffer or send an interrupt.
>

From the driver point of view, it means that the driver cannot trust
the device anymore until the reset, so the driver actions are similar:

""
the driver can=E2=80=99t assume requests in flight will be completed if
DEVICE_NEEDS_RESET is set, nor can it assume that they have not been
completed
""

(Sorry for being circular here, I think it proceeds here too) What I
meant is that the device sent an out of band notification when the
device status changed. The driver could check the status field before
processing every used buffer and also with a timer just in case, and
DEVICE_NEEDS_RESET would not need the config interrupt change. But the
interrupt gives convenience to the whole operation.

Every time the driver gets that interrupt, it must re-check all the
device configuration and status anyway. It can still make buffers
available while processing it, but that's the meaning of the interrupt
to me. And a status change after DRIVER_OK fits to it, from my point
of view.

> > it's explicitly stated that it will be
> > the last one, and it's caused because of the inconvenience of polling
> > device status. Even if the driver can use other mechanisms.
>
> I think STOP works much more similarly to reset not NEEDS_RESET. The
> only difference with reset is that STOP needs to preserve the device
> states and we don't (or can't) use interrupt to signal the completion
> of reset.
>

From the semantic point of view, yes. But in practical terms we can
face unbounded time. I mean, both operations have unbound time for
sure, but I would say that any device should handle reset way faster
than the STOP.

I fully agree on your point, but I can also see the other way around:
It would be convenient to have a configuration interrupt for the reset
too, but it is impossible since we cannot configure any before the
reset.

> >
> > If the community still has concerns about it, another option is to
> > actually extract the way the device notifies it from the general
> > facilities, and make it transport specific. But to use the device
> > configuration change notification for this makes sense to me. The
> > device configuration has changed.
>
> See above, I think we should have a consistent way to handle reset and st=
op.
>
> >
> > > As discussed in the previous versions,
> > > driver is freed to use timer or what ever other mechanism if it
> > > doesn't like the busy polling. I wonder how much value we can gain
> > > from a dedicated config interrupt. Especially consider some transport
> > > can use transport specific interrupt (not virtio specific interrupt)
> > > for reporting whether or not set status succeed.
> > >
> >
> > In my opinion, *if* we agree that a stop is a virtio facility and not
> > a per-device one, and *if* we agree that a notification is required
> > for the device to notify the stop, it makes sense to use a
> > transport-independent mechanism that the device must already
> > implement.
>
> So the major question is why a notification is a must? And Just to be
> clear, there could be transport specific mechanisms for error
> reporting.
>
> E,g
>
> 1) PCI can have non-posted write, if we use non-posted write to carry
> the stop command, the device can return whether or not the device is
> stopped successfully.
>
> or
>
> 2) Some other transport can convert the stop status bit set into a
> command and queue it to device specific queue, device can then use
> it's own specific interrupt to report the when the stop is handled
> (success or fail)
>

I would be totally fine with that too.

> >
> > > >If the device sets the STOP_FAILED bit, the driver MUST clear it bef=
ore
> > > > +try new STOP attempts.
> > >
> > > Does the device need to re-read the STOP_FAILED for synchronization?
> >
> > I tend to see the status as something that belongs to the device and
> > is exposed to the driver. In that sense, the write from the guest
> > triggers an event on the device, and the device decides what will be
> > exposed on that field (MMIO?) on the next driver read. If it's not
> > that way, we couldn't use the STOP bit that way, right?
>
> Yes, but this is not an answer to my question. It's about the
> ordering, when write returns it doesn't mean the write arrives at the
> device, this is the case of PCI at least. So we need a mechanism to
> make sure the write arrives at the device (PCI read will flush
> previous write).
>

I didn't see that in your original question, sorry. But the PCI read
that flush the write is the driver one, isn't it?

In that case I would say that "the read" is part of "the write". It's
an issue of the PCI protocol, which I would say doesn't belong to this
section (or even this document?): To implement virtio over PCI, you
know that virtio needs a write, and, in particular, you know that PCI
needs a posterior read to make sure that write is effective.

Either that, or that the driver must use non-posted ones if it wants
the device to note it.

Or am I still missing something?

> >
> > > I
> > > wonder how much we can gain from STOP_FAILED, the patch is unclear on
> > > when that the device needs to set this bit. And driver can choose to
> > > reset after a specific timeout anyhow.
> > >
> >
> > The conditions where the device needs to set this bit are unspecified
> > because it depends on the device: Not only to the kind of device, but
> > also on the device backend.
> >
> > The same condition (regarding the possibility of handling the pending
> > buffers) could cause different devices to react differently. A network
> > device could decide it's fine to drop pending tx, let the guest think
> > that "the network lost them", and mark them as done,
>
> We may meet the similar issue during reset.
>

Yes, but the driver should be fine to fail a reset, it does not want
to use the device anymore or it wants to totally override the device
state. If a stop fails, the driver would expect the device to continue
operating in my opinion, because it will be impossible to recover the
device state.

This is again something that we could leave if we decide it is not
necessary at this moment: It just shows how a concern of previous
proposals can be solved, at least technically.

> > where a
> > persistent storage cannot do that for write requests. Just as an
> > example, not saying that networking devices must do that :).
>
> So I think this brings extra complexity that we probably don't need to
> worry about now. The reason is that the spec doesn't allow the reset
> to fail.
>

It can be left for the future for sure.

> >
> > > > +
> > > > +If VIRTIO_F_STOP has been negotiated and the device has confirmed =
its stop,
> > > > +the driver MAY change avail_idx in the case of split virtqueue, bu=
t the new
> > > > +avail_idx MUST be within used_idx and used_idx plus virtqueue size=
.
> > >
> > > Any motivation for this? it looks to me it makes the feature coupled
> > > with the virtqueue state proposal? It seems odd to allow avail change
> > > but not the last_avail_idx change.
> > >
> >
> > On second thought, I think you are right and this overlaps with the
> > state proposal.
> >
> > > > +
> > > > +If VIRTIO_F_STOP has been negotiated and the device has confirmed =
its stop,
> > > > +the driver MAY change any descriptor.
> > > > +
> > > > +If VIRTIO_F_STOP has been negotiated and the device has confirmed =
its stopped,
> > > > +the driver can resume it clearing the STOP status bit. It MUST re-=
read the
> > > > +device status to ensure the STOP bit is clear after the write. The=
 device
> > > > +acknowledges the new status clearing it. Since this change may not=
 be
> > > > +instantaneous, the driver MAY wait for the configuration change no=
tification
> > > > +that the device must send after the change.
> > >
> > > Do we really needs resuming? it's kind of:
> > >
> > > 1) STOP -> clear STOP
> > >
> > > vs
> > >
> > > 2) STOP -> RESET -> DRIVER_OK
> > >
> > > Using 2) preserve the semantic that the driver can't clear the status=
 bit.
> > >
> >
> > You are totally right in that regard. But the use case simplifies the
> > operation when the driver only wants to take back some available
> > descriptors still not used, in the range last_avail_idx..avail_idx.
> > Doing that could be a big burden for drivers, who would need to
> > re-send every status. MST proposed that use case at [1].
>
> Yes, but it looks to me this doesn't require the resuming? And the per
> virtqueue reset is being proposed here.
>
> https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg07818.htm=
l
>
> Actually, there's a subtle difference between 1) and 2). That is using
> 2) doesn't make sure we can "resume" from the index where we stopped.
> But this won't be an issue considering we know that we need to support
> setting device virtqueue state(index). So if we want to resume from
> the exact index it could be:
>
> STOP -> RESET -> setting index -> DRIVER_OK
>

With the state I meant more than VQ state, but the device state in
general. For example, for the network, you must also send all the
needed control commands to recover mac, rx filters, etc.

That's what I meant with "if you just want to rewind some descriptors,
resetting the whole device is overkill".

The example may be wrong, I can think of virtiofs and the need to keep
files opened:
* If we go through a full reset circle, the files opened may not be
the same as the closed ones, like deleted files with open handles.
* If we go through a full reset circle, watchers may skip a change.

Of course, this complexity may be left for the future and simply state
that, if that is the case, the device cannot offer stop feature.
Virtiofs have already other complexities that makes its migration
hard, but I think the point is explained.

> >
> > In that regard, the straightforward thing to do is modify avail_idx /
> > descriptors from that range and let resume. However, the RESET path
> > makes it easier to implement the device part of course, and the guest
> > can also achieve the rewind that way.
> >
> > > > +
> > > >  \devicenormative{\subsection}{Device Status Field}{Basic Facilitie=
s of a Virtio Device / Device Status Field}
> > > >
> > > >  The device MUST NOT consume buffers or send any used buffer
> > > >  notifications to the driver before DRIVER_OK.
> > > >
> > > > +If VIRTIO_F_STOP has not been negotiated the device MUST ignore th=
e write of
> > > > +STOP. If the DRIVER_OK status bit is not set the device SHOULD ign=
ore the write
> > > > +or clear of STOP.
> > > > +
> > > > +If VIRTIO_F_STOP has been negotiated, the device MUST finish any i=
n flight
> > > > +operations after the driver writes STOP.
> > >
> > > I wonder if it's better to leave this to device to decide. E.g some
> > > block devices may requires a very log time to finish the inflight
> > > operations.
> > >
> >
> > (Letting out SVQ + inflight descriptors for this part of the response,
> > I will come back to it later)
> >
> > But if virtqueue is not valid anymore, how can it report them when
> > finished?
>
> It's still valid since the STOP bit is not set by the device.
>

Then I don't understand your answer. To my proposal of:

"If VIRTIO_F_STOP has been negotiated, the device MUST finish any
in-flight operations after the driver writes STOP."

You answered:

"I wonder if it's better to leave this to device to decide. E.g some
block devices may requires a very log time to finish the inflight
operations."

The device must finish all requests before it shows the STOP bit as
set to the device. Maybe it is better to rephrase it like:

If VIRTIO_F_STOP has been negotiated, the device MUST finish any
in-flight operations after the driver writes STOP and before it sets
its status bit STOP as set.

?

> > In that sense, I would say it's better to report failure and
> > let the guest handle it as if the disk is unavailable (timeout?
> > temporary faulty sector? I'm not sure what is the most suitable way).
>
> This could be addressed by leaving the following choices to the devices:
>
> 1) complete the inflight requests
> 2) device or virtio specific for reporting inflight descriptors
>

As previously, I'm not sure how this relates with "the stop bit is not
set by the device", so my answer may be completely wrong here,

Even assuming the device can report in-flight descriptors, it needs to
wait for the backend before reporting them anyhow. And we would need
another indication. What is the use of separating these status?
(waiting for stop bit, waiting for inflight descriptors to be valid).

The only possibility I can come up with is to actually stop the
request right in the middle of an operation. For example, to allow a
big block read to stop and then when the device is informed about
these inflight descriptors and its progress, it can continue. I would
say this is very out of scope, more about this later ([1]).

> >
> > *If* we are not going to allow the guest to resume operation, where it
> > knows all the status of the device, then there is no value on let the
> > device delay the operation: From the guest point of view it either
> > succeed to send to the device backend and somebody else caused a
> > failure (external network lose the tx packet, bit rotting caused I'm
> > reading a different value than previously written), or it failed at
> > the stop moment.
>
> So it's highly device specific, e.g for ethernet, we can afford the
> loss of packets but not for the block devices so reporting inflight
> descriptors may help to res-submit those after "resuming".
>

Right.

> >
> > This is different with the resume possibility, where the device can
> > decide to hold the descriptors, stop operating, and then resume
> > operation.
> >
> > > > Depending on the device, it can do it
> > > > +in many ways as long as the driver can recover its normal operatio=
n if it
> > > > +resumes the device without the need of resetting it:
> > > > +\begin{itemize}
> > > > +\item Drain and wait for the completion of all pending requests un=
til a
> > > > +convenient avail descriptor. Ignore any other posterior descriptor=
.
> > > > +\item Return a device-specific failure for these descriptors, so t=
he driver
> > > > +can choose to retry or to cancel them.
> > >
> > > If we allow the driver to retry, we need a way to report inflight
> > > buffers which is not supported by the spec. A way to solve this is to
> > > make it device specific.
> > >
> >
> > Regarding the retry, I don't get you here. Re-reading the patch, I
> > think that "driver retry" is very ambiguous: I meant for the device to
> > mark the descriptor as used, but with a communication specific error
> > code, so the application, guest kernel, etc (driver in the standard)
> > can decide to retry.
>
> That's why I think introducing the virtqueue state is a must for stop,
> With all the indexes defined, it would be much easier to describe what
> the device or driver is expected to work.
>

I still don't see the relationship, sorry.

What I intended to say in the patch is that the device can choose to
just return a device / communication error to indicate that the
transaction has failed at device level, but related to virtio, the
buffer would be marked as used.

Maybe a good example of this is for the device to choose to return
VIRTIO_BLK_S_IOERR, even if the transaction is still going in the
block backend, but I don't know a lot of the blk device so I may be
wrong. I guess that the guest cannot know about the value being
written / read with that error code, and it is forced to re-read that.
But the virtqueue will be in a good state, and the device can be reset
and can recover its state. It's totally up to the device to choose to
do so.

Virtqueue state is still needed, but not because the device chooses to
return VIRTIO_BLK_S_IOERR, but because it needs a way to recover the
status after the reset.

> >
> > Regarding the in-flight descriptor report, it's interesting but I
> > cannot see a way where it does not complicate the solution a lot or
> > adds new dependencies. I have the next thoughts:
> > 1) If it works as inflight_fd, "a region of shared memory"
> > 1.1) This region must be in the guest's AS so the device has access to
> > it. This either invalidates the use of STOP from the driver point of
> > view as "let me know where you are not going to modify the guest's
> > memory anymore".

Long shot here, but might this work with the combination of the
balloon device? Making this far and far from the simplicity though...

> > 1.2) This region is on the hypervisor's AS. If the device supports it,
> > it is possible to implement the SVQ without the need of STOP bit. This
> > is equivalent to "I have a PF that also supports VF dirty memory
> > tracking".
> > 2) If it works as the config space, where the driver can ask for its
> > status, STOP means "STOP writing used and report via config space". No
> > need for reset.
> >
> > Did you have something different in mind?
>
> Not sure, maybe config space is better. What I want is to make the
> feature as small as possible but leaving spaces for future extension.
>
> E.g we start from the feature that is sufficient for networking
> devices, (but doesn't prevent the future work to extend it to block
> devices). I'm not familiar with the block device, but mandating the
> completion of inflight descriptor make have troubles, e.g unexpected
> downtime during live migration.
>

[1] I agree with that, but I feel that "device or virtio specific for
reporting inflight descriptors" is way too broad to make it useful at
the moment.

Maybe the best thing to do is to put all the restrictions at this
moment, and when we figure out a good format for the inflight, add
"\item report inflight descriptors". Then, the device and the driver
are free to not accept any combination. Does it make sense?

> >
> > > > +\item Mark them as done even if they are not, if the kind of devic=
e can
> > > > +assume to lose them.
> > >
> > > I think "make buffer used" is better than "mark them as done". And we
> > > need a accurate definition on who is "them".
> > >
> >
> > All items include other operations, like the ones that the device must
> > do internally to process the control virtqueue. But I cannot find an
> > example where telling the driver they are done when it's not is valid
> > for this particular item.
> >
> > But I agree it needs better wording.
> >
> > And I will s/them/operations/. for the next one.
> >
> > > > +\end{itemize}
> > > > +
> > > > +If VIRTIO_F_STOP has been negotiated and it needs to fail the devi=
ce stop after
> > > > +a guest's request,
> > >
> > > It's not clear what did "a guest's request" means.
> > >
> >
> > Right. Would "operation" fit better here?
>
> Still unclear, I guess this sentence tries to define when the device
> can fail the stop?
>

Not really, my intentions were to add a MUST operation for when the
device fails. The first is needed for the second though, so maybe we
can rephrase.

If we agree that a device can fail the stop, I think we should not
restrict the circumstances where the device can fail. "If the device
can find external circumstances where it cannot satisfy STOP must not
offer STOP feature" works for me too, actually.

> >
> > > > the device MUST set the STOP_FAILED bit for the guest to
> > > > +read it. The device MUST ignore new writes to the STOP bit until t=
he guest
> > > > +clears STOP_FAILED.
> > > > +
> > > > +If VIRTIO_F_STOP has been negotiated and the guest has written the=
 STOP bit,
> > > > +and the device can pause its operation, the device MUST set the de=
scriptors
> > > > +that it has done with them as used before exposing the STOP status=
 bit as set.
> > > > +
> > > > +If VIRTIO_F_STOP has been negotiated, the device MUST NOT perform =
these actions
> > > > +after exposing the STOP bit set:
> > > > +\begin{itemize}
> > > > +\item Read updates on the descriptor or driver area, or consume mo=
re buffers.
> > > > +\item Send any used buffer notifications to the driver.
> > > > +\end{itemize}
> > > > +
> > > > +The device MUST send a configuration space change right after expo=
sing the STOP
> > > > +or STOP_FAILED as set to the driver, and MUST NOT change configura=
tion space or
> > > > +send another configuration space change notification to the driver=
 afterwards
> > > > +until the guest clears it.
> > > > +
> > > > +If VIRTIO_F_STOP has been negotiated and STOP device status flag i=
s set,
> > > > +the device MUST resume operation when the driver clears the STOP b=
it. The
> > > > +device MUST continue reading available descriptors as if an availa=
ble buffer
> > > > +notification has reach it, starting from the last descriptor it ma=
rked as used,
> > >
> > > So I still tend to define virtqueue state as basic facility before
> > > defining STOP. It can makes thing easier.
> > >
> >
> > Yes, coming back to that approach can simplify the whole proposal.
> >
> > > > +and continue the regular operation after that. The device MUST rea=
d again
> > > > +descriptor and driver area beyond the last descriptor it marked as=
 used when it
> > > > +stopped, because the driver can change it. Device MUST set DEVICE_=
NEEDS_RESET
> > > > +if for some reason it cannot continue.
> > > > +
> > > >  \label{sec:Basic Facilities of a Virtio Device / Device Status Fie=
ld / DEVICENEEDSRESET}The device SHOULD set DEVICE_NEEDS_RESET when it ente=
rs an error state
> > > >  that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE=
_NEEDS_RESET, the device
> > > >  MUST send a device configuration change notification to the driver=
.
> > > > @@ -6694,6 +6773,10 @@ \chapter{Reserved Feature Bits}\label{sec:Re=
served Feature Bits}
> > > >    transport specific.
> > > >    For more details about driver notifications over PCI see \ref{se=
c:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initializat=
ion And Device Operation / Available Buffer Notifications}.
> > > >
> > > > +\item[VIRTIO_F_STOP(41)] This feature indicates that the driver ca=
n
> > > > +  stop the device.
> > > > +  See \ref{sec:Basic Facilities of a Virtio Device / Device Status=
 Field}.
> > > > +
> > > >  \end{description}
> > >
> > > So I think the patch complicate thing is various ways:
> > >
> > > 1) STOP_FAILED status bit, which seems unnecessary or even duplicated
> > > with NEEDS_RESET
> > > 2) configuration change interrupt, looks conflict with the semantic o=
f STOP
> >
> > I'm not sure about those two, I find we will have devices with unbound
> > stop time where both can be useful if we agree on making this a
> > general facility.
>
> If the unbound stop time is the only worry, the way to report inflight
> descriptors looks like a better solution.

I'm not sure if that's the only condition under which a device can
fail to stop, but if we agree on that we could prepare a format for
block devices to report them, for example. They are needed somehow in
the networking case of packed if buffers are used out of order.

> And STOP_FAILED is actually
> not accurate since it means the stop is not finished in bound time
> (but we need to define how long should be a bound time?)
>
> > Resetting the whole device because of this leaves
> > the driver with no possibility of knowing the state of the sent
> > descriptors.
> >
> > Of course, if these use cases are not interesting, it's easier to
> > leave them out for sure.
> >
> > > 3) status bit clearing (resuming), a functional duplication with RESE=
T
> > > + DRIVER_OK
> > >
> >
> > I agree it can be obtained with a whole reset, so it can be out and
> > leave it for the future if needed. However it seems overkill if we
> > just want to rewind some descriptors back, and there is no standard
> > way to recover the device status beyond vq_state.
>
> It's more about the minimal self-contained set of the new features. If
> it's just rewind, device or virtqueue reset is sufficient.

I'm not sure if that is true for all devices with the features the
standard offers at the moment, but it might be right for serial.

> If we want
> to obtain the state, virtqueue state is a must and with virtqueue
> state, resuming (clearing STOP) is not a must.
>

Right.

Thanks!

> Thanks
>
> >
> > Thanks!
> >
> > > I think we'd better to stick to the minimal set of the function to
> > > reduce the complexity: virtqueue state + STOP bit (without clearing
> > > and no config interrupt).
> > >
> >
> > [1] https://lists.oasis-open.org/archives/virtio-comment/202107/msg0004=
3.html
> >
> > > Thanks
> > >
> > > >
> > > >  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature=
 Bits}
> > > > --
> > > > 2.27.0
> > > >
> > >
> >
>

