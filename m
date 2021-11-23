Return-Path: <virtio-dev-return-8964-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CFA97986458
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Nov 2021 17:01:00 +0000 (UTC)
MIME-Version: 1.0
References: <20211111185812.2326093-1-eperezma@redhat.com> <20211111185812.2326093-3-eperezma@redhat.com>
 <YZZ4aXdOAA65v10Y@stefanha-x1.localdomain> <CAJaqyWcy3J=pSgXQbKch3EA-5swJJBa68qn-VCWFaixctR+ppw@mail.gmail.com>
 <YZzbtcNXRTD1BawU@stefanha-x1.localdomain>
In-Reply-To: <YZzbtcNXRTD1BawU@stefanha-x1.localdomain>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 23 Nov 2021 18:00:20 +0100
Message-ID: <CAJaqyWfwX4hUMKw5mK-jwUUDm8WQA2PxUvbD2EOavMUAO1Q0kQ@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v3 2/2] virtio: introduce STOP status bit
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, virtio-comment@lists.oasis-open.org, Michael Tsirkin <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alexander Mikheev <amikheev@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Bodong Wang <bodong@nvidia.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Nov 23, 2021 at 1:17 PM Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
>
> On Thu, Nov 18, 2021 at 08:58:05PM +0100, Eugenio Perez Martin wrote:
> > On Thu, Nov 18, 2021 at 5:00 PM Stefan Hajnoczi <stefanha@redhat.com> w=
rote:
> > >
> > > On Thu, Nov 11, 2021 at 07:58:12PM +0100, Eugenio P=C3=A9rez wrote:
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
> > > > +  device has been stopped by the driver.
> > >
> > > Who controls the STOP bit? If I understand correctly, the driver writ=
es
> > > STOP to the Status Register but the device will not report the STOP b=
it
> > > until the device has fully stopped?
> > >
> >
> > Yes, but to add the point of view of the driver here seems too much.
> > However, driver_ok is already explained from the point of view of the
> > driver, so I should try to accommodate that here too.
>
> I would drop "by the driver" to make it less confusing. The role of the
> driver and the device is explained later in this patch, so it can be
> omitted here to save the reader from guessing what "by the driver"
> means.
>

Ok we can do it that way.

> >
> > > > +  This status bit is different
> > > > +  from the reset since the device state is preserved.
> > >
> > > "the reset" -> "resetting the device"
> > >
> >
> > I will rephrase that.
> >
> > > > +
> > > > +\item[STOP_FAILED (32)] When VIRTIO_F_STOP is negotiated, indicate=
s that the
> > > > +  device could not stop the STOP request.
> > >
> > > "could not stop the STOP request" is weird, maybe "could not complete
> > > the STOP request" or just "could not stop".
> > >
> >
> > I think STOP_FAILED should be left out of the proposal for the next
> > revision actually, but you are right.
> >
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
> > > > +If VIRTIO_F_STOP has been negotiated, the driver MUST NOT set or c=
lear STOP if
> > > > +DRIVER_OK is not set.
> > >
> > > Small tweak: "if DRIVER_OK is not set" -> "when DRIVER_OK is not set"=
.
> > > That makes the sentence a little easier to read (for me, at least).
> > >
> >
> > Ok I will change that.
> >
> > > > +
> > > > +If VIRTIO_F_STOP has been negotiated the driver MUST re-read the d=
evice status
> > > > +to ensure the STOP or STOP_FAILED bit is set after the write. The =
device
> > > > +acknowledges the new paused status setting the first, or the failu=
re setting
> > > > +the last.
> > >
> > > This sentence is confusing. "paused status" introduces an alias for t=
he
> > > STOP functionality that is being described. Don't use multiple names =
for
> > > the same thing. The "first"/"last" is unnecessary indirection, just u=
se
> > > "STOP" and "STOP_FAILED" so the reader doesn't have to figure out wha=
t
> > > you meant. I suggest:
> > >
> > >   "The device indicates that it has stopped by reporting the STOP bit=
 or
> > >   indicates failure by reporting the STOP_FAILED bit in the device
> > >   status field."
> > >
> >
> > I agree, I will change that.
> >
> > To be sure, you mean to replace just the second part of the paragraph, =
isn't it?
>
> Yes, just the last sentence of the paragraph.
>
> > > > +Since this change may not be instantaneous, the driver MAY wait fo=
r
> > > > +the configuration change notification that the device must send af=
ter the
> > >
> > > "must" is lowercase. If this is a device normative section then it
> > > should be "MUST". Otherwise I suggest removing the "must": "that the
> > > device sends after ...".
> > >
> >
> > It's in lowercase because it's the driver normative, not the device
> > one. But the "after" alternative sounds perfect to me.
> >
> > > > +change. If the device sets the STOP_FAILED bit, the driver MUST cl=
ear it before
> > > > +try new STOP attempts.
> > >
> > > s/try/trying/
> > >
> >
> > I'll probably discard the STOP_FAILED part for the next revisions but
> > I will take into account if I recover that, thanks!
> >
> > > > +
> > > > +If VIRTIO_F_STOP has been negotiated and the device has confirmed =
its stop,
> > >
> > > "its stop" should probably be "it has stopped", but a more explicit w=
ay
> > > to explain this is:
> > >
> > > "If VIRTIO_F_STOP has been negotiated and the driver reads the STOP b=
it
> > > from the device status field,"
> > >
> >
> > I will change that.
> >
> > > > +the driver MAY change avail_idx in the case of split virtqueue, bu=
t the new
> > > > +avail_idx MUST be within used_idx and used_idx plus virtqueue size=
.
> > >
> > > I'm trying to understand how this would work. Available buffers may b=
e
> > > consumed out-of-order unless VIRTIO_F_IN_ORDER was negotiated, so the
> > > avail ring could contain something like:
> > >
> > >   avail.ring =3D [Used, Not used, Used, Not used, ...]
> > >                                                 ^--- avail.idx
> > >
> > > There are num_not_used =3D avail.idx - used.idx requests that are "No=
t
> > > used" in avail.ring.
> > >
> > > Does this mean the driver can rewind avail.idx by counting the number=
 of
> > > "Not used" buffers and skipping "Used" buffers until it reaches
> > > num_not_used "Not used" buffers?
> > >
> >
> > I'm going to also drop the "resume" part for the next version because
> > it adds extra complexity not actually needed, and it can be achieved
> > with a full reset in a simpler way.
> >
> > But I'll explain it below with your examples. Long story short, the
> > driver only can rewind the available descriptors that are still in the
> > available ring, and the device must flush the ones that cannot recover
> > from the ring.
> >
> > > I think there is a known issue with this approach:
> > >
> > > Imagine a vring with 4 elements:
> > >
> > >   avail.ring =3D [0,        1,    2,    3   ]
> > >                 Not used, used, used, used
> > >                                            ^--- avail.idx
> > >
> > > Since the device has used 3 buffers the driver now has space to make
> > > more buffers available. avail.idx wraps back to the start of the ring
> > > and the driver overwrites the first element ("Not used"):
> > >
> > >   avail.ring =3D [1,        N/A,  N/A,  N/A]
> > >                 Not used, N/A,  N/A,  N/A
> > >                          ^--- avail.idx
> > >
> > > Since vring descriptor 0 is still in use the driver chose descriptor =
1
> > > for the new available buffer.
> > >
> > > Now we stop the device, knowing there are two buffers available that
> > > have not been used. But avail.ring[] actually only contains the new
> > > buffer (vring descriptor 1) that we made available because we overwro=
te
> > > the old avail.ring[] element (vring descriptor 0).
> > >
> > > What now? Where does the device reset its internal avail_idx to?
> >
> > To be on the same page, in qemu the device maintains two "internal
> > avail idx": shadow_avail_idx (last seen in the available ring, could
> > be 4 in this case) and last_avail_idx (next descriptor to fetch from
> > avail, 2). The device must forget shadow_avail_idx and flush the
> > descriptors that cannot recover (0). So last_avail_idx is now 3. Now
> > it can stop.
> >
> > The proposal allows the device to fail descriptor 0 in a
> > device-specific way, but I think now it was a bad choice.
> >
> > The driver cannot move the device's last_avail_idx in this operation:
> > The device is simply forced to flush used ones to the used ring or
> > descriptor ring in a packed vq case. So the device's internal
> > avail_idx =3D=3D used_idx =3D=3D 3. When the device resumes, it's still=
 3.
> >
> > The device must keep its last_avail_idx through stop and resume cycle.
>
> Are you saying that all buffers avail->ring[i % ring_size] must be
> completed by the device before the STOP bit is reported where i <=3D
> last_avail_idx?
>
> This means the driver can modify avail->ring[i % ring_size] where
> avail_idx >=3D i > used_idx.
>

Yes, That's correct. The driver could also decide to modify the
descriptor table instead of the avail ring to do so, but I think the
point is clear now.

Somehow it is thought after the premise that the out of order
descriptors are descriptors that the device must wait to complete
before the pause anyway. Depending on the device, it might prefer to
cancel them, to wait for them, etc. The interesting descriptors to
rewind are the ones that have not reached the device (i > used_idx).
The driver can do whatever it wants with them.

If we assume all the in-flight descriptors are idempotent and we
expose a way for the device to expose them, the model is way more
simpler than this.

> (There might be off-by-one errors, I didn't check whether avail_idx and
> used_idx are inclusive or exclusive bounds the spec.)
>
> The example I gave violates these constraints and wouldn't be allowed.
>
> > > Does
> > > the device remember the available buffer with vring descriptor 0 or d=
o
> > > we need to add it again?
> > >
> >
> > If we want to keep the descriptor 0 as available, device and driver
> > should forget these internally tracked available buffers on stop and
> > skip those in the packed case, similar as in the descriptor chain or
> > IN_ORDER case. Regular stop and resume gets more complicated, but
> > descriptors rewinding is more powerful. And this solution gets way
> > more difficult or impossible to use from the VMM.
> >
> > We could allow the device and the driver to remember these internally
> > tracked available descriptors. But this makes it impossible to use the
> > solution from the VMM transparently to the guest unless a way to
> > provide them is used.
> >
> > However this gets more and more complicated. I think it's better to
> > rely on device stop + reset for descriptor recovery. Everything is way
> > more clear even if a few more steps are needed to resume, and all
> > descriptors are recoverable. The device still needs a way to expose
> > the in-flight ones in the not IN_ORDER case.
>
> I'm also wary of a complicated mechanism for modifying available
> descriptors. Reset sounds good.
>

The next version will include it.

> >
> > > I'm not sure if this idea works even with split virtqueues.
> > >
> > > > +
> > > > +If VIRTIO_F_STOP has been negotiated and the device has confirmed =
its stop,
> > >
> > > "its stop" -> "it has stopped".
> > >
> >
> > I will replace it.
> >
> > > > +the driver MAY change any descriptor.
> > >
> > > Not just descriptors, but also avail.ring[] and avail.idx?
> > >
> >
> > Right.
> >
> > > > +
> > > > +If VIRTIO_F_STOP has been negotiated and the device has confirmed =
its stopped,
> > >
> > > "its" -> "it has"
> > >
> > > > +the driver can resume it clearing the STOP status bit. It MUST re-=
read the
> > >
> > > "it clearing" -> "it by clearing"
> > >
> > > > +device status to ensure the STOP bit is clear after the write. The=
 device
> > > > +acknowledges the new status clearing it. Since this change may not=
 be
> > >
> > > "new status clearing" -> "new status by clearing"
> > >
> >
> > I will correct all of the above.
> >
> > > > +instantaneous, the driver MAY wait for the configuration change no=
tification
> > > > +that the device must send after the change.
> > >
> > > "must" -> "MUST" or "that the device sends"
> > >
> >
> > I will delete it.
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
> > > > +operations after the driver writes STOP.  Depending on the device,=
 it can do it
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
> > > This means each device type in the spec needs to define STOP semantic=
s
> > > so drivers know what to expect. Not sure it's feasible to do this. If
> > > you can drop this point from the patch I would because this is going =
to
> > > be hard to get right in implementations and a pain to specify properl=
y.
> > >
> >
> > Yes, this complicates the solution and is not needed if the device is
> > able to report the in-flight ones.
> >
> > > > +\item Mark them as done even if they are not, if the kind of devic=
e can
> > > > +assume to lose them.
> > > > +\end{itemize}
> > > > +
> > > > +If VIRTIO_F_STOP has been negotiated and it needs to fail the devi=
ce stop after
> > > > +a guest's request, the device MUST set the STOP_FAILED bit for the=
 guest to
> > > > +read it. The device MUST ignore new writes to the STOP bit until t=
he guest
> > > > +clears STOP_FAILED.
> > >
> > > s/guest/driver/ here and elsewhere in this patch
> > >
> >
> > I will review it.
> >
> > > > +
> > > > +If VIRTIO_F_STOP has been negotiated and the guest has written the=
 STOP bit,
> > > > +and the device can pause its operation, the device MUST set the de=
scriptors
> > > > +that it has done with them as used before exposing the STOP status=
 bit as set.
> > >
> > > This sentence is a bit confusing. What does "can" mean here?
> > >
> >
> > "the device can pause its operation" can be replaced by "The device
> > has set STOP bit". Is that clearer?
>
> I think that clause can be removed to make the sentence simpler:
>
>   If VIRTIO_F_STOP has been negotiated and the guest has written the
>   STOP bit, the device MUST mark as used all descriptors currently being
>   processed before reporting the STOP bit.
>
> BTW this sentence need to be made more specific if you want the "all
> buffers avail->ring[i % ring_size] must be completed by the device
> before the STOP bit is reported where i <=3D last_avail_idx" semantics. W=
e
> don't just want to mark in-flight buffers as used, but all buffers
> before the used descriptor with the highest free-running ring index.

Now I think it overlaps too much with the second clause, regarding the
completion of them. These are going to be discarded for the next
revision, but I save this suggestion in case we need to come back for
this :).

Thanks!


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

